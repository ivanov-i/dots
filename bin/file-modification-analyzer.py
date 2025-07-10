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

Remember that comments inside strings are NOT comments to block. Also, functional directives and metadata that control program behavior are NOT comments.

For Edit tool: Check the "new_string" field
For Write tool: Check the "content" field
For MultiEdit tool: Check all "new_string" fields in the "edits" array

IMPORTANT: Distinguish between functional directives and actual comments.

ALLOW functional directives like:
- Shebangs (#!/usr/bin/env python, #!/bin/bash, etc.)
- Encoding declarations (# -*- coding: utf-8 -*-)
- PEP 723 script metadata blocks
- Pragmas, directives, and other language-specific functional annotations
- Any syntax that controls program behavior rather than explaining it
- TODO/FIXME/NOTE comments
- good documentation comments for tricky algorithms

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
        result = subprocess.run(
            ['claude', '-p', '--model', 'claude-sonnet-4-20250514'],
            input=analysis_prompt,
            capture_output=True,
            text=True,
            timeout=None
        )
        
        if result.returncode == 0:
            output = result.stdout.strip()
            
            if DEBUG:
                print(f"Claude output: {output}", file=sys.stderr)
            
            json_block = re.search(r'```json\s*(\{.*?\})\s*```', output, re.DOTALL)
            if json_block:
                try:
                    return json.loads(json_block.group(1))
                except json.JSONDecodeError:
                    pass
            json_match = re.search(r'\{.*\}', output, re.DOTALL)
            if json_match:
                return json.loads(json_match.group())
        
        return None
            
    except Exception:
        return None

def main():
    try:
        stdin_data = sys.stdin.read()
        
        if DEBUG:
            print(f"Raw stdin: {stdin_data}", file=sys.stderr)
        data = json.loads(stdin_data)
        
        if DEBUG:
            print(f"Input: {json.dumps(data)}", file=sys.stderr)
        
        analysis = analyze_with_claude(data)
        
        if analysis and analysis.get('has_comments'):
            comment_details = analysis.get('comment_details', 'No details provided')
            
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
        elif analysis is None:
            print(json.dumps({
                "decision": "block",
                "reason": dedent("""
                    Analysis service unavailable. Cannot determine if content contains comments.

                    The comment detection service failed to respond. Blocking the operation as a precaution.
                """).strip()
            }))
        else:
            print(json.dumps({}))
            
    except Exception as e:
        if DEBUG:
            print(f"Exception: {e}", file=sys.stderr)
        print(json.dumps({}))

if __name__ == "__main__":
    main()
