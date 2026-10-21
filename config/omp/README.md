# omp configuration backup

User configuration from oh-my-pi (`~/.omp`). Runtime data and caches are not
included. The tree mirrors `~/.omp`; copy only the items you need.

About keybindings, remember to update .json file of Terminal about the Shift+Enter and Ctrl+Enter

## Restore

Run these on the new machine. Install `omp` first. Each command replaces the
target file.

### Settings, prompt, keys, rules

```sh
mkdir -p ~/.omp/agent/rules
cp ~/omp/agent/config.yml ~/omp/agent/APPEND_SYSTEM.md \
   ~/omp/agent/keybindings.yml ~/.omp/agent/
cp ~/omp/agent/rules/*.md ~/.omp/agent/rules/
```

### Models, MCP servers, SSH hosts

```sh
cp ~/omp/agent/models.yml ~/omp/agent/mcp.json ~/omp/agent/ssh.json ~/.omp/agent/
chmod 600 ~/.omp/agent/models.yml ~/.omp/agent/ssh.json
```

### Skills

`commit` is a local skill, not a registry package. Copy it:

```sh
mkdir -p ~/.omp/agent/skills
cp -a ~/omp/agent/skills/. ~/.omp/agent/skills/
```

For a Skillshare registry skill, use this form instead:

```sh
omp skill install -g @owner/skill-name
```

### Plugins

The plugin cache and manifests are not copied. Reinstall from the marketplace:

```sh
omp plugin marketplace add mattpocock/skills
omp plugin install mattpocock-skills@mattpocock
```

This installs the plugin and its skills. If the marketplace is already added,
run this first:

```sh
omp plugin marketplace update mattpocock
```

### Check

```sh
omp config get theme.dark       # dark-tokyo-night
omp plugin list                 # mattpocock-skills@mattpocock
omp skill list                  # commit and the plugin skills
```

## Contents

| Path | Purpose |
| --- | --- |
| `agent/config.yml` | Settings: theme, status line, model roles, tools, compaction, TUI, thinking, MCP. |
| `agent/APPEND_SYSTEM.md` | System prompt append text. |
| `agent/PERSONALITY.md` | Not present in the source. Copy it if you add one. |
| `agent/SYSTEM.md`, `agent/SYSTEM_TEMPLATE.md` | Not present in the source. They override the default prompt. |
| `agent/TITLE_SYSTEM.md` | Not present in the source. Custom session-title prompt. |
| `agent/keybindings.yml` | Key bindings. |
| `agent/mcp.json` | MCP servers (codegraph). |
| `agent/models.yml` | Custom providers and models, with API keys. |
| `agent/ssh.json` | ssh:// host list. |
| `agent/rules/` | Rulebook files (`lab-pc-access.md`). |
| `agent/skills/` | User skills (`commit`). |
| `marketplaces.json` | Record of the marketplace registry. The restore steps add it again. |
| `plugins/installed_plugins.json` | Record of installed plugins. The restore steps reinstall them. |
| `plugins/omp-plugins.lock.json` | Record of plugin enable and feature state. |

## Not included

These paths are runtime state or derived data:

`agent/*.db*`, `agent/blobs/`, `agent/cache/`, `agent/sessions/`,
`agent/terminal-sessions/`, `agent/custom-session-files/`, `agent/predict/`,
`agent/last-changelog-version`, `logs/`, `cache/`, `natives/`, `puppeteer/`,
`run/`, `ssh-control/`, `remote-host/`, `install-id`, `gpu_cache.json`,
`stats.db*`, `autoqa.db`, `plugins/cache/`, `plugins/node_modules/`.

`install-id` is the machine identity. Do not copy it.

## Machine-specific values

- **Secrets:** `agent/models.yml` has plaintext API keys. `agent/ssh.json` has
  private IP addresses. Both files are mode 600. Do not put this directory in a
  public repository.
- **`/home/kietpham` paths:** `agent/mcp.json` and the plugin records contain
  absolute paths. A different user name needs an edit.
- **codegraph:** `agent/mcp.json` starts `/home/kietpham/.local/bin/codegraph`.
  Install codegraph on the new machine, or edit this path.
- **Private endpoints:** `models.yml` `baseUrl` values point to
  `10.231.19.178` and `api.ai-box.vn`. They need network access to that network.
- `marketplaces.json` `catalogPath` and `installed_plugins.json` `installPath`
  point into `plugins/cache`. The plugin commands recreate that cache.

## Refresh this backup

```sh
cd ~/.omp
cp agent/config.yml agent/APPEND_SYSTEM.md agent/keybindings.yml \
  agent/mcp.json agent/models.yml agent/ssh.json ~/omp/agent/
cp agent/rules/*.md ~/omp/agent/rules/
cp -a agent/skills/. ~/omp/agent/skills/
cp marketplaces.json ~/omp/
cp plugins/installed_plugins.json plugins/omp-plugins.lock.json ~/omp/plugins/
chmod 600 ~/omp/agent/models.yml ~/omp/agent/ssh.json
```
