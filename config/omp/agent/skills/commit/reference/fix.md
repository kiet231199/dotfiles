# `fix` commit rules

## Body

The body is mandatory; never skip it. It has two sections with
fixed headings, in this order, separated by a blank line:

```text
Root Cause:
<diagram and explanation of the bug, in STE100 terms>

Solution:
<the changes that correct the issue, target 2 lines>
```

## Diagram

The shared diagram rules in SKILL.md apply. Draw the diagram under
`Root Cause:`: the failure flow against the expected behavior. A
UML sequence diagram fits bugs whose cause is an interleaving of
events. Skip the diagram only when the change is purely mechanical
or formatting work with no behavioral flow to show (a typo fix, a
rename, a dependency bump). If any flow changes, draw it.

## Example

```text
fix: prevent race condition during logout token invalidation

Root Cause:
Thread A reads the session before the revocation write of
Thread B becomes visible:

Thread A           Session Store           Thread B
   |                     |                     |
   |--[1] read session-->|                     |
   |<--[2] valid --------|                     |
   |                     |<-[3] revoke (write)-|
   |                     |    not visible      |
   |                     |    to Thread A      |
   |--[4] process request|                     |
   |    (unauthorized    |                     |
   |     action occurs)  |                     |

Solution:
Add a distributed write-lock before session metadata reads during
revocation. Concurrent operations can then not use an expired
token.

Signed-off-by: Author Name <author@example.com>
```

Replace the sign-off with the real identity from git config. The
example shows a placeholder only.
