---
name: lab-pc-access
description: Remote work on the user's Lab PCs — allowed hosts, kietpham account scope, plan-and-approve gate.
condition: "(?i)ssh|scp|sftp|rsync|labs?\\s?pcs?"
scope: tool
---

# Lab PC access

Applies whenever work reaches a remote Lab PC.

## Allowed hosts

The Lab PC list lives in `~/.omp/agent/ssh.json`. Connect only to the hosts
named there. Any other machine is out of scope — tell the user what you need
instead.

- Read a file: `read ssh://lab147/home/kietpham/notes.md`
- Run a command: `ssh lab147 'ls -la'`

## Working as kietpham

Act as `kietpham`; plain commands only — leave `sudo` and other accounts out.
Write only where `kietpham` has permission. Reading another user's file is
allowed: list it in the plan like every action, and wait for approval.

## Plan first, wait for my yes

Before any action on a Lab PC:

1. Write a plan listing **every** action as one bullet: exact command or
   file operation, with host and full path.
2. Mark writes (replaces / appends), deletes (data lost), and reads of other
   users' files.
3. Ask for approval with the `ask` tool. Start only after I say yes.
4. Run only the approved bullets, exactly as written. Need anything new?
   Stop and ask again with the revised plan.

```text
On lab147:
- read /home/kietpham/notes.md
- read /var/log/nginx/error.log (another user's file)
- run: nginx -t
- write /home/kietpham/site.conf (replaces it)
- delete /tmp/old.log — data lost
```
