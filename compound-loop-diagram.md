# Compound Loop — Diagrams

## 1. The Loop Cycle

```mermaid
flowchart TD
    START([🚀 New Session Begins]) --> HOOK

    HOOK["⚙️ SessionStart Hook\nsession-start.sh"]
    HOOK --> INJECT

    INJECT["📥 Inject Context Files\nproject-overview · error-log · chat-summary"]
    INJECT --> ORIENT

    ORIENT["🧠 Claude Orients\nFull memory of all prior sessions loaded"]
    ORIENT --> WORK

    WORK["💻 Session Work\nCode · Debug · Plan · Decide"]
    WORK --> SKILL

    SKILL["/compound-loop skill\nUpdates all 3 CONTEXT files"]
    SKILL --> OV & ERR & SUM

    OV["📋 project-overview.md\nName · Goals · Stack\nDecisions · Status · Questions"]
    ERR["🪲 error-log.md\nError · Root Cause\nResolution · Lesson"]
    SUM["💬 chat-summary.md\nDiscussed · Completed\nDecisions · Next"]

    OV & ERR & SUM --> COMMIT

    COMMIT["📦 git commit\nContext files saved to branch"]
    COMMIT --> STOP

    STOP["⚙️ Stop Hook\nsession-end.sh — confirms loop is closed"]
    STOP --> END

    END([✅ Session Ends — Context Compounded])
    END -.->|"next session inherits richer context"| START

    style START fill:#1a1a2e,stroke:#7c6fff,color:#fff
    style END   fill:#1a1a2e,stroke:#66bb6a,color:#fff
    style HOOK  fill:#16161f,stroke:#7c6fff,color:#e8e8f0
    style INJECT fill:#16161f,stroke:#4fc3f7,color:#e8e8f0
    style ORIENT fill:#16161f,stroke:#4fc3f7,color:#e8e8f0
    style WORK  fill:#16161f,stroke:#66bb6a,color:#e8e8f0
    style SKILL fill:#16161f,stroke:#ffa726,color:#e8e8f0
    style OV    fill:#16161f,stroke:#7c6fff,color:#e8e8f0
    style ERR   fill:#16161f,stroke:#f06292,color:#e8e8f0
    style SUM   fill:#16161f,stroke:#4fc3f7,color:#e8e8f0
    style COMMIT fill:#16161f,stroke:#66bb6a,color:#e8e8f0
    style STOP  fill:#16161f,stroke:#ffa726,color:#e8e8f0
```

---

## 2. Context Files & What They Track

```mermaid
erDiagram
    SESSION ||--o{ PROJECT_OVERVIEW : updates
    SESSION ||--o{ ERROR_LOG : appends
    SESSION ||--o{ CHAT_SUMMARY : prepends

    SESSION {
        int     number
        date    date
        string  topics_discussed
        string  work_completed
    }

    PROJECT_OVERVIEW {
        string  project_name
        string  purpose_and_goals
        string  architecture_stack
        string  key_decisions
        string  current_status
        string  open_questions
        int     sessions_completed
        date    last_updated
    }

    ERROR_LOG {
        date    date
        string  title
        string  context
        string  error_message
        string  root_cause
        string  resolution
        string  lesson
    }

    CHAT_SUMMARY {
        int     session_number
        date    date
        string  discussed
        string  completed
        string  decisions
        string  next
    }
```

---

## 3. Compound Knowledge Growth

```mermaid
xychart-beta
    title "Context Quality Compounds Over Sessions"
    x-axis [S1, S2, S3, S4, S5, S6, S7, S8, S9, S10]
    y-axis "Quality %" 0 --> 100
    line [10, 25, 40, 53, 63, 71, 78, 83, 87, 91]
    line [5,  18, 32, 46, 57, 66, 73, 79, 84, 88]
    line [8,  20, 36, 50, 61, 70, 76, 81, 86, 90]
```

---

## 4. File & Hook Architecture

```mermaid
graph LR
    subgraph hooks [".claude/hooks/"]
        SS["session-start.sh\n▸ injects CONTEXT files"]
        SE["session-end.sh\n▸ reminds to run skill"]
    end

    subgraph settings [".claude/settings.json"]
        CFG["SessionStart → session-start.sh\nStop → session-end.sh"]
    end

    subgraph skills [".claude/skills/"]
        CL["compound-loop.md\n▸ /compound-loop skill"]
    end

    subgraph context ["CONTEXT/"]
        PO["project-overview.md"]
        EL["error-log.md"]
        CS["chat-summary.md"]
    end

    CFG --> SS & SE
    SS -->|reads| PO & EL & CS
    CL -->|writes| PO & EL & CS

    style hooks    fill:#16161f,stroke:#7c6fff,color:#e8e8f0
    style settings fill:#16161f,stroke:#ffa726,color:#e8e8f0
    style skills   fill:#16161f,stroke:#66bb6a,color:#e8e8f0
    style context  fill:#16161f,stroke:#4fc3f7,color:#e8e8f0
```
```

---

## 5. Session Timeline (Sequence)

```mermaid
sequenceDiagram
    actor User
    participant Hook as SessionStart Hook
    participant Claude
    participant Skill as /compound-loop
    participant Files as CONTEXT Files

    User->>Hook: opens new session
    Hook->>Files: reads all 3 files
    Files-->>Hook: returns content
    Hook->>Claude: injects accumulated context
    Claude-->>User: "I remember everything. What are we doing?"

    loop Session Work
        User->>Claude: asks / requests
        Claude-->>User: responds with full context
    end

    User->>Skill: /compound-loop
    Skill->>Claude: analyze this session
    Claude->>Files: update project-overview.md
    Claude->>Files: append to error-log.md
    Claude->>Files: prepend to chat-summary.md
    Files-->>Skill: all 3 updated ✓
    Skill-->>User: "Session N recorded. Context ready."

    Note over Files: git commit — loop sealed
    Note over User,Files: Next session inherits richer context
```
