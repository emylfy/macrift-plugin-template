# macrift-plugin-template

> Copy-and-fill skeleton for [macrift](https://github.com/emylfy/macrift) plugins. Click **Use this template** at the top of this repo to start your own.

## What you get

A working (but stub-content) plugin in four files:

```
your-plugin/
├── plugin.json           # the manifest — name, version, menu metadata
├── menu.sh               # entry point — defines the function plugin.json names
├── handlers/example.sh   # where your real logic goes
├── config/               # static files you ship (delete if unused)
├── README.md             # tell users what your plugin does
├── LICENSE               # MIT by default — change as you prefer
└── .gitignore
```

## 1. Use this template

Click the green **Use this template → Create a new repository** button at the top of GitHub. Pick a name (lowercase, kebab-case, will become your plugin's `name`).

Then locally:

```sh
git clone https://github.com/your-handle/your-plugin-name
cd your-plugin-name
```

## 2. Rename the placeholders

Find-and-replace these placeholder strings across the repo:

| Placeholder           | Replace with                       |
|:----------------------|:-----------------------------------|
| `your-plugin-name`    | The plugin's name (kebab-case)     |
| `your-github-handle`  | Your GitHub handle                 |
| `your_plugin_menu`    | The bash function name             |
| `Your plugin`         | The user-visible menu label        |

Quick one-liner:

```sh
PLUGIN=your-plugin-name HANDLE=your-handle FN=your_plugin_menu LABEL="Your plugin"
LC_ALL=C find . -type f \( -name '*.sh' -o -name '*.json' -o -name '*.md' \) \
  -not -path './.git/*' -exec sed -i.bak \
    -e "s/your-plugin-name/$PLUGIN/g" \
    -e "s/your-github-handle/$HANDLE/g" \
    -e "s/your_plugin_menu/$FN/g" \
    -e "s/Your plugin/$LABEL/g" {} \;
find . -name '*.bak' -delete
```

## 3. Write your logic

Open `handlers/example.sh` and replace the stubs. The public API (helpers macrift gives you) is in [PLUGINS.md → Public API](https://github.com/emylfy/macrift/blob/main/PLUGINS.md#public-api). Highlights:

- `show_menu` / `show_multiselect` / `confirm` / `wait_enter` — UI
- `log_info` / `log_ok` / `log_err` / `log_warn` / `log_skip` / `log_hint` — output
- `audit_default <domain> <key> <type> <value>` + `apply_audited_defaults` — journaled `defaults write` (so `macrift undo` can revert)
- `copy_config <src> <dst>` — copy with automatic backup
- `_journal_append_*` — record dotfile / launchd / marker-block changes

**Do not** use raw `defaults write`, raw `launchctl bootstrap`, or `curl | bash` — `macrift plugin lint` will flag those and the journal can't undo them. See [PLUGINS.md → What plugins must not do](https://github.com/emylfy/macrift/blob/main/PLUGINS.md#what-plugins-must-not-do).

## 4. Test locally without publishing

```sh
mkdir -p ~/.macrift/plugins
ln -s "$(pwd)" ~/.macrift/plugins/your-plugin-name
macrift            # your entry appears under its declared section
macrift plugin list
macrift plugin lint your-plugin-name   # verify against do-not-do rules
```

## 5. Publish

```sh
git add -A && git commit -m "Initial release v0.1.0"
git tag v0.1.0
git push --tags
```

Then any user can install with:

```sh
macrift plugin add github.com/your-handle/your-plugin-name@v0.1.0
```

## See also

- [macrift](https://github.com/emylfy/macrift) — the host project
- [PLUGINS.md](https://github.com/emylfy/macrift/blob/main/PLUGINS.md) — full author contract
- [SECURITY.md](https://github.com/emylfy/macrift/blob/main/SECURITY.md) — trust model (plugins run with user privileges)
- [claudemac](https://github.com/emylfy/claudemac) — flagship plugin as a real-world reference (Claude Code config + Telegram bridge)
