#!/usr/bin/env bash
# Compound Loop — Session Start Hook
# Injects the three context files into the session so Claude has full memory
# from the first message.

CONTEXT_DIR="$(git rev-parse --show-toplevel 2>/dev/null)/CONTEXT"

if [ ! -d "$CONTEXT_DIR" ]; then
  echo "[CompoundLoop] CONTEXT directory not found. Skipping context injection."
  exit 0
fi

echo "=== COMPOUND LOOP: SESSION CONTEXT ==="
echo ""
echo "You have access to accumulated project memory. Read it before responding."
echo ""

for file in "project-overview.md" "chat-summary.md" "error-log.md"; do
  path="$CONTEXT_DIR/$file"
  if [ -f "$path" ]; then
    echo "--- $file ---"
    cat "$path"
    echo ""
  fi
done

echo "=== END COMPOUND LOOP CONTEXT ==="
echo ""
echo "REMINDER: At the end of this session, run /compound-loop to update all three context files."
