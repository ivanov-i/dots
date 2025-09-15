#!/usr/bin/env -S uv run
# /// script
# requires-python = ">=3.8"
# dependencies = []
# ///

import json
import sys
import subprocess
import re
import os
from textwrap import dedent

DEBUG = os.environ.get('HOOK_DEBUG', '').lower() == 'true'

ANALYSIS_PROMPT = """You are analyzing a Claude Code hook request to enforce a no-comments policy.

Claude Code is attempting to modify a file. Here is the complete hook input:

```json
{hook_input}
```

Examine the JSON to understand what modification is being attempted:
- tool_name: tells you which tool (Edit, Write, or MultiEdit)
- tool_input: contains the modification details

Your task: Check if the NEW content contains programming comments that should be blocked.
Consider the file type. For example, you should allow comments in non-code files (e.g. Markdown)

Remember that comments inside strings are NOT comments to block. Also, functional directives and metadata that control program behavior are NOT comments.

For Edit tool: Check the "new_string" field
For Write tool: Check the "content" field
For MultiEdit tool: Check all "new_string" fields in the "edits" array
Also check old string to make sure you only block new comments, not comment removal or the comments that are going to be left intact (around the actual change)

IMPORTANT: Distinguish between functional directives and actual comments.

ALLOW functional directives like:
- Shebangs (#!/usr/bin/env python, #!/bin/bash, etc.)
- Encoding declarations (# -*- coding: utf-8 -*-)
- PEP 723 script metadata blocks
- Pragmas, directives, and other language-specific functional annotations
- Any syntax that controls program behavior rather than explaining it
- TODO/FIXME/NOTE comments
- good documentation comments for tricky algorithms
- actually useful debug logs. sometimes they do printf or log-based debugging. allow this

BLOCK actual comments like:
- Explanatory comments that describe what code does.
- Commented-out code
- Any text meant for human readers rather than the interpreter/compiler

Respond with ONLY valid JSON:
{{
  "has_comments": true or false,
  "comment_details": "description of actual comments found together with explanations why do you report them"
}}"""

def analyze_with_claude(data):
    analysis_prompt = ANALYSIS_PROMPT.format(
        hook_input=json.dumps(data, indent=2)
    )

    try:
        # Use --settings to override MAX_THINKING_TOKENS for Haiku
        settings_override = json.dumps({"env": {"MAX_THINKING_TOKENS": "0"}})
        
        result = subprocess.run(
            ['claude', '-p', '--model', 'haiku', '--settings', settings_override],
            input=analysis_prompt,
            capture_output=True,
            text=True,
            timeout=None
        )

        if result.returncode == 0:
            output = result.stdout.strip()


            if DEBUG:
                print(f"Claude output: {output}", file=sys.stderr)
                print(f"Claude output length: {len(output)}", file=sys.stderr)
                print(f"Claude output repr: {repr(output)}", file=sys.stderr)

            json_block = re.search(r'```json\s*(\{.*?\})\s*```', output, re.DOTALL)
            if json_block:
                try:
                    return {"success": True, "data": json.loads(json_block.group(1))}
                except json.JSONDecodeError as e:
                    error_msg = f"Failed to parse JSON from Claude response: {str(e)}"
                    if DEBUG:
                        print(f"JSON block parsing failed: {error_msg}", file=sys.stderr)
                        print(f"JSON block content: {repr(json_block.group(1))}", file=sys.stderr)
                    return {"success": False, "error": error_msg, "claude_output": output}
            last_brace = output.rfind('}')
            if last_brace != -1:
                brace_count = 0
                json_start = -1
                for i in range(last_brace, -1, -1):
                    if output[i] == '}':
                        brace_count += 1
                    elif output[i] == '{':
                        brace_count -= 1
                        if brace_count == 0:
                            json_start = i
                            break

                if json_start != -1:
                    json_text = output[json_start:last_brace + 1]
                    try:
                        return {"success": True, "data": json.loads(json_text)}
                    except json.JSONDecodeError as e:
                        error_msg = f"Failed to parse JSON from Claude response: {str(e)}"


                        if DEBUG:
                            print(f"Brace-counting parsing failed: {error_msg}", file=sys.stderr)
                            print(f"Extracted JSON text: {repr(json_text)}", file=sys.stderr)
                            print(f"JSON start: {json_start}, end: {last_brace + 1}", file=sys.stderr)
                        return {"success": False, "error": error_msg, "claude_output": output}
            error_msg = "No valid JSON found in Claude response"
            if DEBUG:
                print(f"No JSON found: {error_msg}", file=sys.stderr)
                print(f"Full output for analysis: {repr(output)}", file=sys.stderr)
            return {"success": False, "error": error_msg, "claude_output": output}
        else:
            # Combine stdout and stderr for better error reporting
            stdout = result.stdout.strip() if result.stdout else ""
            stderr = result.stderr.strip() if result.stderr else ""
            error_output = stderr if stderr else stdout if stdout else "No error details"
            
            # Try to extract API error messages from the output
            if "API Error" in stdout or "API Error" in stderr:
                error_output = stdout + stderr
            
            return {"success": False, "error": f"Claude command failed with exit code {result.returncode}: {error_output[:500]}"}

    except subprocess.TimeoutExpired:
        return {"success": False, "error": "Claude analysis timed out"}
    except FileNotFoundError:
        return {"success": False, "error": "Claude CLI not found. Please ensure 'claude' is installed and in PATH"}
    except Exception as e:
        return {"success": False, "error": f"Unexpected error during analysis: {str(e)}"}

def is_non_code_file(data):
    tool_name = data.get('tool_name', '')
    tool_input = data.get('tool_input', {})

    non_code_extensions = {
        '.md', '.markdown', '.txt', '.rst', '.adoc', '.org',
        '.pdf', '.doc', '.docx', '.odt',
        '.csv', '.tsv',
        '.log', '.out', '.err',
        '.gitignore', '.dockerignore', '.editorconfig',
        'LICENSE', 'README', 'CHANGELOG', 'AUTHORS', 'CONTRIBUTORS'
    }

    file_paths = []

    if tool_name in ['Edit', 'Write']:
        file_path = tool_input.get('file_path', '')
        if file_path:
            file_paths.append(file_path)
    elif tool_name == 'MultiEdit':
        file_path = tool_input.get('file_path', '')
        if file_path:
            file_paths.append(file_path)

    for file_path in file_paths:
        file_name = os.path.basename(file_path)
        _, ext = os.path.splitext(file_path)

        if ext.lower() in non_code_extensions:
            return True

        if file_name.upper() in non_code_extensions:
            return True

    return False

def main():
    try:
        stdin_data = sys.stdin.read()

        if DEBUG:
            print(f"Raw stdin: {stdin_data}", file=sys.stderr)

        try:
            data = json.loads(stdin_data)
        except json.JSONDecodeError as e:
            if DEBUG:
                print(f"Malformed JSON from Claude Code: {str(e)}", file=sys.stderr)
                print(f"Raw input: {repr(stdin_data[:200])}", file=sys.stderr)
            print(json.dumps({}))
            return

        if DEBUG:
            print(f"Input: {json.dumps(data)}", file=sys.stderr)

        if is_non_code_file(data):
            if DEBUG:
                print("Skipping analysis for non-code file", file=sys.stderr)
            print(json.dumps({}))
            return

        analysis = analyze_with_claude(data)

        if analysis and analysis.get('success'):
            analysis_data = analysis.get('data', {})
            if analysis_data.get('has_comments'):
                comment_details = analysis_data.get('comment_details', 'No details provided')

                tool_name = data.get('tool_name', '')
                if tool_name in ['Edit', 'MultiEdit']:
                    reason = dedent(f"""
                        Comments found: {comment_details}

                        Reminder: Don't forget the no-comments rule.

                        Note: The {tool_name} tool only shows fragments without surrounding context. This detection may be incorrect if:
                        - The content is inside a string literal
                        - The content is data rather than code
                        - The fragment is part of a larger non-comment structure


                        If this is a false positive, try using a different approach that provides more context.

                        If you believe these comments are essential, ask the user to add them manually.
                    """).strip()
                else:
                    reason = dedent(f"""
                        Comments found: {comment_details}

                        Reminder: Don't forget the no-comments rule.

                        If you believe these comments are essential, ask the user to add them manually.
                    """).strip()

                print(json.dumps({
                    "decision": "block",
                    "reason": reason
                }))
            else:
                print(json.dumps({}))
        elif analysis and not analysis.get('success'):
            error_msg = analysis.get('error', 'Unknown error')
            claude_output = analysis.get('claude_output', 'No output captured')

            print(json.dumps({
                "decision": "block",
                "reason": f"Analysis failed: {error_msg}\n\nClaude output: {repr(claude_output[:200])}\n\nTo bypass this check, set HOOK_DEBUG=true"
            }))
        else:
            print(json.dumps({}))

    except Exception as e:
        if DEBUG:
            print(f"Exception: {e}", file=sys.stderr)
        print(json.dumps({}))

if __name__ == "__main__":
    main()

