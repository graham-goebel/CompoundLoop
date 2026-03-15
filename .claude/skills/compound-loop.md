# Compound Loop Skill

## What is Compound Loop?

The Compound Loop is a self-reinforcing memory system. At the end of every chat session, Claude updates three context files so that knowledge, errors, and decisions compound over time — each session is smarter than the last because it inherits the full accumulated context.

**Loop cycle:**
```
Session Start → Load Context → Do Work → Session End → Update Context → (repeat, compounding)
```

---

## When to Run This Skill

Run `/compound-loop` (or invoke this skill) at the **end of every chat session**, before closing the conversation.

The Stop hook in `.claude/settings.json` will remind you automatically.

---

## Instructions for Claude

When this skill is invoked, perform **all three updates** below in order. Be precise, factual, and concise. Do not hallucinate. Only record what actually happened in this session.

---

### Step 1 — Update `CONTEXT/project-overview.md`

Read the current file, then rewrite the content **between the header and the `<!-- COMPOUND_LOOP:OVERVIEW_END -->` marker** with an updated, accurate overview. Preserve the marker.

Update these fields based on everything discussed across all sessions:
- **Project Name** — the canonical name of the project
- **Purpose & Goals** — what the project does and why
- **Architecture & Stack** — languages, frameworks, services, patterns in use
- **Key Decisions Made** — important architectural or product decisions (append, don't overwrite)
- **Current Status** — one-line summary of where things stand right now
- **Open Questions** — unresolved questions or blockers

Increment `Sessions completed:` by 1 and set `Last updated:` to today's date.

---

### Step 2 — Update `CONTEXT/error-log.md`

Read the current file. If any **errors, bugs, failed commands, or unexpected behaviors** occurred in this session, append new entries **above the `<!-- COMPOUND_LOOP:ERRORS_END -->` marker** using this exact format:

```markdown
### [YYYY-MM-DD] <Short Error Title>
- **Context**: What was being worked on when this happened
- **Error**: The exact error message or description
- **Root Cause**: Why it happened (be specific)
- **Resolution**: How it was resolved — or `OPEN` if still unresolved
- **Lesson**: One sentence on what to avoid or watch for in future sessions
```

If no errors occurred, append a one-line note:
```markdown
### [YYYY-MM-DD] — No errors this session.
```

---

### Step 3 — Update `CONTEXT/chat-summary.md`

Read the current file. Prepend a new session entry **immediately after the `## Sessions` heading** (so the most recent session is always first) using this format:

```markdown
### Session N — YYYY-MM-DD
- **Discussed**: High-level topics and decisions covered
- **Completed**: Concrete work finished (files created, features built, bugs fixed)
- **Decisions**: Choices made that affect the project going forward
- **Next**: What should be picked up at the start of the next session
```

Where `N` is the current session number (increment from the last entry).

---

### Step 4 — Confirm

After all three files are updated, output a brief confirmation:

```
Compound Loop complete.
- project-overview.md ✓
- error-log.md ✓
- chat-summary.md ✓
Session N recorded. Context is ready for the next session.
```

---

## Design Principles

| Principle | What it means |
|-----------|--------------|
| **Compound** | Every session adds to — never replaces — the accumulated knowledge |
| **Accurate** | Only record what actually happened; no fabrication |
| **Concise** | Each file stays readable; summaries are tight, not verbose |
| **Recoverable** | Any new Claude session can read these three files and fully orient itself |
| **Resilient** | If a file is missing, recreate it from the template before updating |
