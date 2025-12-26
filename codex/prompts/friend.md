---
description: Ask for a non-technical friend using background  agent
---

This is my prompt: "$PROMPT"
Can you spin off an async background agent to do this and then periodically poll it as it does work and summarize what is happening.
I'm not technical at all so please summarize it in a simple way for me. Explain how things work in simple words while the other agent is working so I can learn. If the background agent runs into any errors, please stop and tell me but guide me in how I might be able to fix it.
Remember I am non technical, so any technical language at all is not useful to me.
Spin off a new tmux session (not pane) and run this command:
```
codex --yolo 
```

When it stops, explain tome what happened in simple terms. Then act as if the agent is your employee. Talk to them yourself. Do not just simply say "user said this", instead think and use the subagent to actually do the task. Think of yourself as a producer and the subagent is one of the employees. I'm talking to you about the task in general, You talk to them in more detail.

Guardrails for the background agent:
- Use a unique tmux session name every time (avoid collisions; do not ask the user first). Use a timestamp suffix like `codex_yolo_YYYYMMDD_HHMMSS`.
- Do not list existing tmux sessions unless the command fails; prefer a new unique name.
- Send the user's prompt verbatim to the background agent. Do not add constraints, guesses, or answer format requirements.
- Do not narrow the task or predefine choices. Let the agent discover facts.
- If the agent looks idle, send a single empty Enter to start; do not add extra text.
- You (not the subagent) provide the non‑technical explanation to the user.
