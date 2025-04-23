#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.12"
# dependencies = [
#     "tiktoken",
#     "pathspec",
# ]
# ///

import argparse
import os
from pathlib import Path
import tiktoken
import pathspec
import sys

def find_gitignore(start_path: Path) -> Path | None:
    current_path = start_path.resolve()
    while True:
        gitignore_path = current_path / ".gitignore"
        if gitignore_path.is_file():
            return gitignore_path
        if current_path.parent == current_path:
            return None
        current_path = current_path.parent

def load_gitignore_patterns(gitignore_path: Path | None) -> list[str]:
    patterns = []
    if gitignore_path and gitignore_path.is_file():
        try:
            with open(gitignore_path, 'r', encoding='utf-8') as f:
                patterns.extend(f.readlines())
        except Exception as e:
            print(f"Warning: Could not read {gitignore_path}: {e}", file=sys.stderr)
    return patterns

def get_pathspec(start_path: Path) -> pathspec.PathSpec:
    all_patterns = [".git/"]
    current_path = start_path.resolve()
    while True:
        gitignore_path = current_path / ".gitignore"
        if gitignore_path.is_file():
            patterns = load_gitignore_patterns(gitignore_path)
            relative_patterns = []
            for pattern in patterns:
                stripped_pattern = pattern.strip()
                if stripped_pattern and not stripped_pattern.startswith('#'):
                     relative_patterns.append(stripped_pattern)
            all_patterns.extend(relative_patterns)

        if current_path.parent == current_path:
            break
        current_path = current_path.parent

    return pathspec.PathSpec.from_lines(pathspec.patterns.GitWildMatchPattern, all_patterns)

def count_tokens_in_file(file_path: Path, encoding) -> int:
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
        return len(encoding.encode(content))
    except UnicodeDecodeError:
        print(f"Warning: Skipping non-UTF-8 file: {file_path}", file=sys.stderr)
        return 0
    except Exception as e:
        print(f"Warning: Could not process file {file_path}: {e}", file=sys.stderr)
        return 0

DEFAULT_SOURCE_EXTENSIONS = {
    ".py", ".js", ".ts", ".jsx", ".tsx", ".java", ".c", ".cpp", ".h", ".hpp",
    ".go", ".rs", ".swift", ".kt", ".scala", ".rb", ".php", ".html", ".css",
    ".scss", ".less", ".vue", ".svelte", ".md", ".json", ".yaml", ".yml",
    ".sh", ".bash", ".zsh", ".sql", ".dockerfile", "Dockerfile", ".tf",
    ".hcl", ".lua", ".pl", ".pm", ".r", ".dart", ".fs", ".fsx", ".cs", ".vb",
}

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("path", help="Directory path to scan for files.")
    parser.add_argument(
        "--all-files",
        action="store_true",
        help="Count tokens in all non-ignored files, not just source code."
    )
    args = parser.parse_args()

    target_path = Path(args.path)
    if not target_path.is_dir():
        print(f"Error: Path '{args.path}' is not a valid directory.", file=sys.stderr)
        sys.exit(1)

    try:
        encoding = tiktoken.get_encoding("cl100k_base")
    except Exception as e:
        print(f"Error: Could not load tiktoken encoding: {e}", file=sys.stderr)
        sys.exit(1)

    spec = get_pathspec(target_path)
    total_tokens = 0
    files_processed = 0

    for item in target_path.rglob('*'):
        relative_path_str = str(item.relative_to(target_path))

        is_ignored = spec.match_file(relative_path_str)
        is_hidden = any(part.startswith('.') for part in item.relative_to(target_path).parts)

        if is_ignored or is_hidden:
             if item.is_dir():
                 # Need to prevent pathspec from descending into ignored dirs implicitly
                 # This part is tricky with rglob; simpler might be os.walk
                 # For now, we just skip processing files within explicitly
                 pass
             continue

        if item.is_file():
            if not args.all_files:
                if item.suffix.lower() not in DEFAULT_SOURCE_EXTENSIONS and item.name != "Dockerfile":
                    continue

            total_tokens += count_tokens_in_file(item, encoding)
            files_processed += 1

    print(f"Total tokens: {total_tokens}")
    print(f"Files processed: {files_processed}")

if __name__ == "__main__":
    main()
