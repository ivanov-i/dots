#!/usr/bin/env -S uv run
# /// script
# requires-python = ">=3.8"
# dependencies = []
# ///
"""
File modification analyzer - uses Claude to check for comments in code
"""

import json
import sys
import subprocess
import re
import os

DEBUG = os.environ.get('HOOK_DEBUG', '').lower() == 'true'

ANALYSIS_PROMPT = """Does this code contain any comments?

{content}

Respond with ONLY valid JSON:
{{
  "has_comments": true or false
}}"""

def analyze_with_claude(content):
    """Use claude to check for comments"""
    analysis_prompt = ANALYSIS_PROMPT.format(
        content=content.replace('"', '\\"')
    )
    
    try:
        result = subprocess.run(
            ['claude', '-p', '--model', 'claude-sonnet-4-20250514'],
            input=analysis_prompt,
            capture_output=True,
            text=True,
            timeout=10
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
    if DEBUG:
        print("Script started", file=sys.stderr)
    try:
        stdin_data = sys.stdin.read()
        if DEBUG:
            print(f"Raw stdin: {stdin_data}", file=sys.stderr)
        data = json.loads(stdin_data)
        tool_input = data.get('tool_input', {})
        
        if DEBUG:
            print(f"Input: {json.dumps(data)}", file=sys.stderr)
        
        content = tool_input.get('content', '') or tool_input.get('new_string', '')
        if not content and 'edits' in tool_input:
            edits = tool_input.get('edits', [])
            content = '\n'.join(edit.get('new_string', '') for edit in edits)
        
        if not content.strip():
            print(json.dumps({}))
            return
        
        analysis = analyze_with_claude(content)
        
        if analysis and analysis.get('has_comments'):
            print(json.dumps({
                "decision": "block",
                "reason": "🚫 Comments detected. Rule: Do not add any comments.\n💡 If you believe these comments are essential, ask the user to add them manually."
            }))
        else:
            print(json.dumps({}))
            
    except Exception as e:
        if DEBUG:
            print(f"Exception: {e}", file=sys.stderr)
        print(json.dumps({}))

if __name__ == "__main__":
    main()