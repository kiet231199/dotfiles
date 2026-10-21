# `refactor` commit rules

Restructuring only, no behavior change. When the behavior changes,
the commit is a `fix` or a `feat`, not a `refactor`.

## Diagram

The shared diagram rules in SKILL.md apply. When the structure or
the file arrangement changes, draw a folder tree that compares the
layout before and after the change. Define the folder hierarchy
with the branch characters `|--`, `+--`, and `|`, so every line
shows its parent:

```text
Before:                    After:
src/                       src/
|-- auth.py                |-- auth/
+-- db.py                  |   |-- session.py
                           |   +-- tokens.py
                           +-- db.py
```

For logic restructuring with no file moves, a block diagram of the
old and new module boundaries works instead. When the change moves
no files and crosses no module boundary, no diagram is needed.
