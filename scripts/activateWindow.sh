#!/usr/bin/env bash
# file: activateWindow.sh
# Desc: Activate a window using the name of that window.
# Usage: ./activateWindow.sh <arg1> <arg2> ... <argN>
# Example: ./activateWindow.sh Terminal ~


currentDesktop="$(wmctrl -d | grep "*" | head -c 1)"

for arg in "$@"
do
  currentWindowId="$(wmctrl -l | grep "  $currentDesktop " | grep "$arg" | head -c 10)"
  if [[ $currentWindowId ]]; then
    break
  fi 
done

echo "Current Desktop $currentDesktop, current Window $currentWindowId"

wmctrl -i -a "$currentWindowId"

