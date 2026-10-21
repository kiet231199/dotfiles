---
name: coding-style
description: Bash/Python coding style. Use before writing or editing any .sh, .bash, or .py file: new script, refactor, or code review.
---

# Coding Style: Bash and Python

Write every line of Bash and Python for a reader who is new to both
languages. The reader must understand and change the code in one pass,
without asking questions. Optimize for that reader first, then for
the machine.

---

## 1. Core Principles

- **One job per unit.** Each function or block does one task. Name the
  unit after that task. When you write a comment to explain what a block
  does, extract the block into a function with that comment as its name.
- **Descriptive names replace comments.** Spend effort on names, not
  commentary. A reader who needs a comment to follow the code means a
  name or a structure needs work.
- **No inlined logic.** Lift every non-trivial expression, condition, or
  path out of its surrounding flow and give it a named home. A dense
  one-liner is a defect, not a virtue.
- **One source of truth.** Write each piece of logic once. When two
  blocks look similar, extract the shared part and let both call it.
- **Small surface.** A function fits on one screen. A script reads
  top-to-bottom like a table of contents: constants, functions,
  `main`.

---

## 2. Naming

- Function and variable names state intent: `fetch_active_users`,
  `parse_duration_seconds`, `retry_with_backoff`.
- Include units and types in names where the value alone hides them:
  `timeout_seconds`, `path_to_config`, `retry_count`.
- Booleans read as yes/no questions: `is_valid`, `has_entries`.
- Match the vocabulary of the surrounding code. Reuse an existing term
  before you invent a synonym for it.

---

## 3. Comments

- Write a comment only for a fact the code cannot show: a constraint
  from outside the code, a warning about a non-obvious failure mode,
  or the reason a workaround exists.
- A comment answers **why**, never **what**. The code itself answers
  what.
- Keep each comment to one short sentence. Delete a comment when the
  code changes and the comment no longer adds a fact.
- Write docstrings (Python) or usage headers (Bash) only where a new
  reader would otherwise open the implementation to learn how to call
  the unit.

---

## 4. Structure

- Extract functions in this order of priority:
  1. A block you already needed a comment for.
  2. A block that appears more than once.
  3. Any condition or expression longer than one line.
- Give each function a single exit point where practical. Guard
  clauses that return early count as clear; deep nesting does not.
- Flatten nesting. Replace nested conditionals with guard clauses or
  early returns. Aim for a nesting depth of at most two levels.
- Put shared constants at the top of the file with names, never inline
  magic values in logic.

---

## 5. Bash Rules

- Start every script with `set -euo pipefail`.
- Quote every variable expansion: `"${var}"`.
- Prefer functions over top-level script bodies. Call them from a
  `main` function at the bottom: `main "$@"`.
- Use `local` for all variables inside functions.
- Write global variable names in `UPPER_SNAKE_CASE`:
  `MAX_RETRIES=3`, `CONFIG_PATH="${HOME}/.config/app.conf"`.
  Keep function-local names lowercase. The case alone shows where a
  variable lives, so a reader never searches for its scope.
- Write long commands as an array or split across lines with `\`, one
  logical flag group per line.
- Replace repeated command patterns with a function. Replace fragile
  text parsing (`awk`/`sed` chains) with the smallest clear tool that
  does the job.
- Prefer `[[ ]]` over `[ ]`, and `$( )` over backticks.

---

## 6. Python Rules

- Put one space on each side of `=` in every assignment: `a = 1`,
  never `a=1`.
- Follow PEP 8. Use type hints on every function signature.
- Use f-strings for formatting.
- Handle errors with explicit `try`/`except` around the smallest
  possible block. Catch specific exceptions; name the expected failure
  in the handler.
- Use comprehensions only when they fit on one line and read like
  English. Otherwise write the loop.
- Use `pathlib` for paths, `argparse` for CLIs, and `logging` instead
  of `print` in anything reusable.

---

## 7. Completion Checklist

Before you finish any Bash or Python change, verify each item:

1. Every function has one job, and its name states that job.
2. Every non-trivial expression or condition lives in a named
   constant, variable, or function.
3. No block of logic appears twice; shared logic is extracted.
4. A reader new to the language can follow the file top-to-bottom
   without a comment explaining what a block does.
5. Every remaining comment states a why the code cannot show.
6. Bash scripts use `set -euo pipefail`, quoted expansions, and a
   `main` function.
7. Python functions carry type hints and PEP 8 formatting.
8. The change passes a self-review pass against items 1 to 7.
