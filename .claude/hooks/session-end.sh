#!/usr/bin/env bash
# Compound Loop — Session End Hook (Stop event)
# Reminds Claude to run the compound-loop skill before the session closes.

echo ""
echo "=== COMPOUND LOOP REMINDER ==="
echo "This session is ending. Run /compound-loop now to update:"
echo "  - CONTEXT/project-overview.md"
echo "  - CONTEXT/error-log.md"
echo "  - CONTEXT/chat-summary.md"
echo ""
echo "Skipping this means the next session loses context from this one."
echo "================================"
