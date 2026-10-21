---
name: commit
description: Analyze git diffs, split the changes into atomic commits by type, review the changes, and create descriptive commit messages. Use when generating git commits, splitting diffs, or running commit workflows.
hide: false
---

# Commit Workflow

Follow the steps in order. Each step ends when its completion
criterion is met.

## Step 1: Analyze the diffs

Run `git status` and `git diff` (plus `git diff --staged` when
something is staged). Read every hunk. Review the changes for
correctness and intent, not only for what the lines say.

Done when: you can state what each distinct change does and why.

## Step 2: Split the changes

Group the diff into atomic commits:

- One commit carries one kind of change in one area. Keep business
  logic, test code, and configuration/tooling changes in separate
  commits. Judge which category a file belongs to from the
  project's actual layout; directory names differ per project.
- Order by dependency: domain logic first, test suites second,
  documentation/configuration third.
- Lockfiles and generated files ride with the commit that needs
  them; they never form a commit of their own.
- Ask the user for approval before you commit lockfiles or hidden
  files (dotfiles). Commit them only after the user approves.
- Stage each group with `git add -p` or path-based staging, as you
  judge best.

Done when: every changed hunk belongs to exactly one planned commit
and the commit order is fixed.

## Step 3: Classify each commit type

Assign each planned commit exactly one type:

| Type | Use for |
|------|---------|
| `feat` | A new feature or capability. |
| `fix` | A bug fix. |
| `refactor` | Restructuring only, no behavior change. |
| `style` | Whitespace, formatting, or lint fixes only, no logic change. |
| `docs` | Documentation changes only. The type is `docs`, never `doc`. |
| `test` | Adding missing tests or correcting existing tests. |
| `perf` | Performance improvement with no behavior change. |
| `build` | Build system, dependencies, or tooling. |
| `revert` | Reverting a prior commit. |
| `chore` | Maintenance work that fits no other type. |

Done when: every planned commit has exactly one type.

## Step 4: Write the commit messages

For each commit, read `reference/<type>.md` in this skill directory
first (for example `reference/fix.md`). Draft the message following
the type rules and these shared rules. A diff that meets the
Small-change exception below takes the short body form instead.

### Title

```text
<type>: <summary>
```

Summary in imperative mood, without a trailing period.

### Shared body rules

- Every commit gets a body. The Small-change exception below
  defines the short form for a small diff.
- For `fix`, `feat`, and `perf`, the body follows the section
  format in the type's `reference/<type>.md`. For every other
  type, the body is a plain explanation: 1 to 2 short sentences.
- Write in ASD-STE100 Simplified Technical English. Short
  sentences. One idea per sentence. Active voice. No idioms or
  unnecessary jargon.
- Wrap text lines at 80 characters maximum. Diagram lines may run
  up to 120 characters.
- Paragraphs are 1 to 4 lines. Longer only when unavoidable. Never
  pad a paragraph. Separate paragraphs with exactly one blank line.
- When multiple distinct items change, use a bulleted list
  (`- <item>`). Each bullet is one line of at most 80 characters.
  A bullet block counts as 1 to 2 lines of paragraph budget.
- Factual accuracy and clarity override all limits.

### Small-change exception

- Trigger: the commit's diff changes at most 10 lines, added and
  removed counted together.
- Form: the body is a plain description of 1 to 3 lines. It
  replaces the body rules above: the type section format, the
  plain-explanation rule, and the bullet rule.
- Scope: the exception applies to every type, including `fix`,
  `feat`, and `perf`. It skips the required sections and the
  required diagram in `reference/<type>.md`.
- Still required: STE100 wording, the 80-character wrap, and the
  sign-off.

### Diagram rules

- Draw diagrams in block diagram style or UML style (sequence,
  activity, or component diagrams).
- Any ASCII character is allowed.
- Hard cap: 120 columns per diagram line.
- A section that contains a diagram is exempt from the 4-line
  paragraph cap; give full technical depth. The prose around the
  diagram still obeys STE100.
- Each type's `reference/<type>.md` states when a diagram is
  required and what it must show.

### Sign-off

- Commit with `git commit -s` so git reads the identity from
  `git config user.name` and `git config user.email`. The message
  ends with a `Signed-off-by:` trailer.
- If `user.name` or `user.email` is not set, stop and ask the user.
  Never guess an identity.

Done when: every planned commit has a full draft message.

## Step 5: Recheck and rewrite

Check every draft message against this checklist:

1. Title uses `<type>: <summary>`; type is one of the ten values;
   summary is imperative with no trailing period.
2. Body present. A commit that matches the Small-change
   exception uses the 1 to 3 line plain form; every other
   commit uses the full body form for its type.
3. Text complies with ASD-STE100: short sentences, active voice,
   one idea per sentence.
4. Text lines are at most 80 characters; diagram lines at most
   120.
5. Paragraphs are 1 to 4 lines (longer only when unavoidable), no
   padding, exactly one blank line between paragraphs.
6. Multi-item changes use bullets; each bullet is one line of at
   most 80 characters; the block stays within 1 to 2 lines.
   Small-change exception bodies are exempt.
7. Every rule in the commit's `reference/<type>.md` is met
   (sections, diagram, type-specific content), unless the
   Small-change exception applies.
8. No section headings (`Root Cause:`, `Solution:`, `Design:`,
   `Implementation:`) appear in a commit whose type is not `fix`,
   `feat`, or `perf`.
9. The commit is atomic: no mix of logic, tests, and config;
   lockfiles and generated files ride with their dependent commit;
   lockfiles and hidden files have the user's approval.
10. The `Signed-off-by:` trailer is present, produced by
    `git commit -s`.

If any item fails, rewrite the message and check it again. Repeat
until every item passes for every draft.

Done when: all drafts pass all checklist items.

## Step 6: Commit

Stage each group and run `git commit -s` in the dependency order
from Step 2. Execute `git commit` only; run `git push` only when
the user specifically asks for it.

Done when: `git log` shows every planned commit, in order.
