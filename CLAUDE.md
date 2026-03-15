# CLAUDE.md — CompoundLoop Project

## Compound Loop Memory System

This repository uses the **Compound Loop** — a self-reinforcing memory system that ensures every session builds on all previous ones.

### How it works

```
┌─────────────────────────────────────────────────────┐
│                  COMPOUND LOOP CYCLE                │
│                                                     │
│  Session Start                                      │
│      │                                              │
│      ▼                                              │
│  [Hook] session-start.sh                            │
│  → Injects CONTEXT files into conversation          │
│      │                                              │
│      ▼                                              │
│  Claude reads accumulated memory and begins work    │
│      │                                              │
│      ▼                                              │
│  Session work (coding, debugging, planning...)      │
│      │                                              │
│      ▼                                              │
│  [Skill] /compound-loop                             │
│  → Updates all three CONTEXT files                  │
│      │                                              │
│      ▼                                              │
│  [Hook] session-end.sh                              │
│  → Reminds Claude to run /compound-loop if skipped  │
│      │                                              │
│      ▼                                              │
│  Session End (context is richer than before)        │
└─────────────────────────────────────────────────────┘
```

### Three Self-Updating Context Files

| File | Purpose | Updates when |
|------|---------|--------------|
| `CONTEXT/project-overview.md` | Living project spec — goals, stack, status, open questions | `/compound-loop` is run |
| `CONTEXT/error-log.md` | Persistent error registry with root causes and resolutions | `/compound-loop` is run |
| `CONTEXT/chat-summary.md` | Reverse-chronological session history | `/compound-loop` is run |

### Rules for Claude

1. **At session start**: Read all three CONTEXT files before doing anything else.
2. **During the session**: Note errors, decisions, and completed work mentally.
3. **At session end**: Run `/compound-loop` to update all three files. This is not optional.
4. **Never skip the update** — skipping breaks the compound loop and loses context permanently.

### Skill Reference

```
/compound-loop
```

Defined in `.claude/skills/compound-loop.md`. Updates all three CONTEXT files with everything that happened in the current session.

---

## Project Context

See `CONTEXT/project-overview.md` for the current project definition.
See `CONTEXT/chat-summary.md` for the history of what has been done.
See `CONTEXT/error-log.md` for known issues and their resolutions.
