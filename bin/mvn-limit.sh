#!/usr/bin/env zsh

while true; do
  pgrep -f 'org.codehaus.plexus.classworlds.launcher.Launcher' |
  while read pid; do
    if ! pgrep -f "cpulimit.*--pid=$pid" >/dev/null; then
      cpulimit \
        --pid="$pid" \
        --include-children \
        --limit=100
    fi
  done

  sleep 1
done
