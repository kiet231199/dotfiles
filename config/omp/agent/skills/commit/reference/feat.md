# `feat` commit rules

## Body

The body is mandatory; never skip it. It has two sections with
fixed headings, in this order, separated by a blank line:

```text
Design:
<diagram and explanation of the design and integration points>

Implementation:
<what was added or modified, target 2 lines>
```

## Diagram

The shared diagram rules in SKILL.md apply. Draw the diagram under
`Design:`: the working flow or the interaction state, as a block
diagram or a UML diagram. Skip the diagram only when the change is
purely mechanical or formatting work with no behavioral flow to
show (a typo fix, a rename, a dependency bump). If any flow
changes, draw it.

## Example

```text
feat: add OAuth2 refresh token rotation mechanism

Design:
+--------+      +-------------+      +--------------+
| Client | ---> | API Gateway | ---> | Auth Service |
+--------+      +-------------+      +--------------+
                                            |
                                            v
                                 +------------------------+
                                 | Token Validation       |
                                 +------------------------+
                                            |
                                            v
                                 +------------------------+
                                 | Rotate Token &         |
                                 | Invalidate Old Token   |
                                 +------------------------+

This feature adds automatic token rotation. It cuts the risk of
token theft. The system invalidates the old refresh token when it
issues a new one.

Implementation:
Add a rotation step to the token refresh endpoint. Store the token
family so reuse of an old token revokes the whole family.

Signed-off-by: Author Name <author@example.com>
```

Replace the sign-off with the real identity from git config. The
example shows a placeholder only.
