# dotfiles

> Managed with GNU Stow — my personal development and desktop environment configuration.

## Overview

This repository contains my personalised configuration files (dotfiles) for a wide range of command-line tools, desktop environments, window managers, and development tools. Everything is organised as GNU Stow packages under one root.

### Stow Convention

- Packages **without** a leading `_` in their directory name are **installed** automatically by `install.sh` via:
  ```sh
  stow --dotfiles -vS -t "$HOME" <package>
  ```
- Packages **with** a leading `_` are **un-stowed** (i.e. not symlinked to `$HOME`). Their files are copied or referenced individually, typically to avoid conflicts with other tools.
- Each package subdirectory uses the `dot-*` prefix convention so that stow's `--dotfiles` option maps `dot-X` → `.X` at the target.

## Quick Start

### Bootstrap a new Artix Linux machine
```sh
curl -L https://git.io/JtJ7M | bash
```
(`bootstrap.sh` pulls the repo and runs `install.sh`)

### Manual install
```sh
./install.sh
```

### Post-install
```sh
# Update tmux plugins via TPM
just update
# Or manually
git submodule update --init
tmux/dot-config/tmux/plugins/tpm/bin/install_plugins
```

## Package Index

| Package / Tool | Description | Status |
|---|---|---|
| `_alacritty` | Alacritty terminal emulator — Catppuccin Mocha theme | ✓ Active |
| `atuin` | Shell history sync daemon | ✓ Active |
| `bat` | `cat` replacement with syntax highlighting | ✓ Active |
| `_bottom` | `btm` system monitor (Catppuccin Mocha colours) | ✓ Active |
| `_broot` | `br` directory tree navigator | ✓ Active |
| `_btop` | `btop` resource monitor | ✓ Active |
| `direnv` | Environment-load-on-cd with Poetry layout helper | ✓ Active |
| `dunst` | Notification daemon (launch script + Catppuccin Mocha) | ✓ Active |
| `dwm` | Dynamic Window Manager scripts/polybar scripts | ✓ Active |
| `_foot` | Foot terminal emulator — Catppuccin Mocha colours | ✓ Active |
| `git` | Global gitconfig, delta diff viewer, attributes, ignore | ✓ Active |
| `gitui` | TUI git client — Catppuccin Mocha theme, custom keybinds | ✓ Active |
| `_htop` | htop configuration (copied, not stowed) | ✓ Active |
| `hyprland` | Hyprland compositor config + mocha colours, idle, lock, paper | ✓ Active |
| `imv` | Image viewer — Catppuccin Mocha background | ✓ Active |
| `lf` | Terminal file manager — preview, open, icons | ✓ Active |
| `mpv` | Video player config + vim-like keybindings | ✓ Active |
| `nix` | Nix package manager config (flakes + nix-command) | ✓ Active |
| `npm` | npm config (XDG dirs + Zscaler CA) | ✓ Active |
| `paru` | AUR helper config | ✓ Active |
| `polybar` | Polybar config — workspaces, weather, bluetooth, updates, etc. | ✓ Active |
| `presenterm` | Terminal presentation tool | ✓ Active |
| `python` | Python REPL startup (history via XDG_STATE) | ✓ Active |
| `_qutebrowser` | Qutebrowser browser — Catppuccin Mocha, YouTube ad filter | ✓ Active |
| `_ranger` | Ranger file manager — devicons, previews, scope script | ✓ Active |
| `rofi` | Application launcher — Catppuccin Mocha, fuzzy matching | ✓ Active |
| `ruff` | Python linter/formatter config (all rules) | ✓ Active |
| `sheldon` | Zsh plugin manager config | ✓ Active |
| `shell` | Shared shell env, aliases, functions, keybindings, fzf | ✓ Active |
| `starship` | Starship prompt — Catppuccin Mocha palette | ✓ Active |
| `stylua` | Lua formatter config | ✓ Active |
| `swappy` | Screenshot annotation tool | ✓ Active |
| `swhkd` | SWHKD hotkey daemon config | ✓ Active |
| `tmux` | Tmux config — Catppuccin Mocha, vim keys, plugins | ✓ Active |
| `topgrade` | System-wide upgrade tool | ✓ Active |
| `_user-dirs` | XDG user directories config | ✓ Active |
| `_vifm` | Vifm file manager config | ✓ Active |
| `waybar` | Waybar status bar — Catppuccin Mocha CSS | ✓ Active |
| `wezterm` | Wezterm terminal emulator — Lua config, vim keys | ✓ Active |
| `X11` | X11 Xresources (Gruvbox) + xinitrc | ✓ Active |
| `xplr` | Xplr file manager — Lua config, plugins | ✓ Active |
| `xsuspender` | X11 window suspender config | ✓ Active |
| `yazi` | Yazi file manager — Catppuccin Mocha flavor, plugins | ✓ Active |
| `ytfzf` | YouTube search/play from terminal | ✓ Active |
| `zathura` | PDF viewer — Catppuccin Mocha, vim keys | ✓ Active |
| `zellij` | Zellij multiplexer — Catppuccin Mocha, custom keybinds | ✓ Active |
| `zsh` | Zsh shell — .zshenv, .zprofile, .zshrc | ✓ Active |

## Detailed Review and Recommendations

### `_alacritty` — Alacritty

**Files:** `alacritty.toml`, `catppuccin-mocha.toml`, `gruvbox_dark_theme.yaml`

**Issues:**
1. **Typo in font family:** `bold_italic.family = "FiraCode NerdFont"` (missing space) — should be `"FiraCode Nerd Font"` for consistency.
2. **Orphaned theme file:** `gruvbox_dark_theme.yaml` (YAML format, not TOML) is never referenced — Alacritty expects `.toml`. Either remove it or convert and add an import.
3. **Empty `[env]` section:** Only sets `TERM = "xterm-256color"` which is fine, but could be documented or removed if relying on system default.

**Recommendations:**
- Fix the font name typo in `bold_italic.family`.
- Remove `gruvbox_dark_theme.yaml` (unused) or convert to TOML.

---

### `atuin` — Atuin (history sync)

**Files:** `config.toml`

**Issues:**
1. **Self-hosted sync address:** `sync_address = "http://atuin.riemer.page:8888"` — hardcoded hostname. If that host is not always reachable or the DNS name changes, the config breaks silently.
2. **Excessive commented defaults:** The file is ~90% comments with only ~6 active lines. This makes real settings hard to find.
3. **`enter_accept = false`:** Consider whether you want this — `true` is the modern default and reduces keystrokes.

**Recommendations:**
- Trim all default-commented lines to the 6-8 active settings for clarity.
- Consider making the sync address configurable via environment variable.

---

### `bat` — Bat

**Files:** `config`, `themes/*.tmTheme`

**Issues:**
1. **`--paging=always`:** This is set, but the custom `--pager` only applies when paging is needed. `--paging=always` means `bat` always pipes through `less` even for single-line output. Consider `--paging=auto`.

**Recommendations:**
- Change `--paging=always` to `--paging=auto` for shorter outputs.
- The Catppuccin themes look correct; no changes needed.

---

### `_bottom` — Bottom (btm)

**Files:** `bottom.toml`

**Issues:**
1. **Very slow update rate:** `rate = 10000` (10 seconds) and `default_time_value = 600000` (10 minutes) — the default widget time span is extremely long, making graphs mostly flat lines.
2. **Both `hide_table_gap = true` and `table_header_color` set** — the Catppuccin Mocha colours look good.

**Recommendations:**
- Reduce `rate` to `2000` (2 seconds) for smoother CPU/memory updates.
- Reduce `default_time_value` to `120000` (2 minutes) for more useful graphs.

---

### `_broot` — Broot

**Files:** `conf.toml`

**Issues:**
1. **No custom skin/colours:** The config only defines a few verbs (`edit`, `create`, `view`, quit on `ctrl-c`). No colour scheme is set; all skin lines are commented out.

**Recommendations:**
- Add a Catppuccin Mocha-inspired skin or at least a dark theme so it visually matches the rest of the system.

---

### `_btop` — Btop

**Files:** `btop.conf`

**Issues:**
1. **`color_theme = "/usr/share/btop/themes/gruvbox_dark.theme"`:** References a system path that may not exist on all installations. Theme is Gruvbox, not Catppuccin Mocha, unlike most other tools.
2. **`update_ms = 5000`** is reasonable.
3. **`proc_mem_bytes = True`** — shows memory in bytes; this can be hard to read for large processes.

**Recommendations:**
- Either install a Catppuccin Mocha btop theme or keep Gruvbox if that is the intended look. Whichever is chosen, document the expectation.
- Consider `proc_mem_bytes = False` for human-readable percentages.

---

### `direnv` — Direnv

**Files:** `direnvrc`

**Issues:**
1. **Single-purpose layout:** Only provides `layout_poetry()` — no `layout_python`, `layout_venv`, or other common layouts. This is fine if Poetry is the only use case.

**Recommendations:**
- Add a `layout_uv()` function for the newer `uv` Python tool since `env.sh` already exports `UV_LINK_MODE=copy`.

---

### `dunst` — Dunst

**Files:** `dunstrc`, `launch.sh`, `normal.png`, `critical.png`

**Issues:**
1. **All urgency levels have `timeout = 0`:** Notifications never auto-dismiss. This is deliberate but may cause clutter.
2. **`transparency = 20`:** Deprecated in newer dunst — use `background transparency` or per-urgency alpha settings.
3. **`browser = brave --new-tab`:** Hardcoded browser.
4. **Old commented Gruvbox theme block:** Leftover from a previous configuration.

**Recommendations:**
- Consider setting `timeout = 5` for low urgency, `timeout = 10` for normal, and keep 0 only for critical.
- Remove the old commented-out urgency section.
- Clean up the commented Gruvbox entries.

---

### `dwm` — DWM scripts

**Files:** Various status bar scripts (`clock`, `cpu`, `disk`, etc.), `autostart.sh`, `startdwm.sh`

**Issues:**
1. **`xrdb` called twice in `autostart.sh`** (lines 6-7): `xrdb -merge` then `xrdb` — the second call overwrites the first merged result.
2. **`polybar launch` called twice if `DISPLAY` is empty** (lines 33 & 35): Both inside the `if [[ -z "${DISPLAY}" ]]` block.
3. **`$HOST` variable:** The block for "work" is heavily commented out — consider cleaning up dead code.
4. **Hardcoded hostname checks:** `if [ "$HOST" == "work" ]` — fragile; environment variables or condition files are more maintainable.
5. **`xfce4-power-manager`** is launched even though the session uses DWM/Hyprland, not XFCE.

**Recommendations:**
- Remove duplicate `xrdb` call (keep only line 6 or 7).
- Fix duplicate `polybar launch` — likely meant one for the host-specific bar and one generic.
- Clean up the heavily commented VirtualBox block.
- Consider `xfce4-power-manager` removal in favour of `tlp` or just the kernel's power management.

---

### `_foot` — Foot terminal

**Files:** `foot.ini`

**Issues:**
1. **Most of the file is commented-out defaults:** Only `[colors]` is active. The file is ~237 lines with ~17 lines of actual config.
2. **Font is hardcoded to `FiraCodeNerdFont:size=10`:** No fallback.
3. **All keybindings are commented out:** Fine if defaults are acceptable, but you may want custom shortcuts.

**Recommendations:**
- Strip commented defaults to a minimal file for readability.
- Add a fallback font or use `font=monospace` as base.

---

### `git` — Git config

**Files:** `config`, `ignore`, `attributes`, `catppuccin.gitconfig`

**Issues:**
1. **Delta features reference `catppuccin-frappe` as default** (line 23) but `catppuccin.gitconfig` provides Latte, Frappe, Macchiato, Mocha. If you use Mocha everywhere else, consider changing the default to `catppuccin-mocha`.
2. **`diff "preview.sh"`** (line 132-134) — binary diff driver referencing `lf/preview.sh` — this may be slow for large binaries.
3. **`diff "dyff"` has a duplicate `command`** (lines 130-131): The first is commented out by the second; only the second takes effect.
4. **`http.sslVerify = false` at the end** (line 220): This overrides line 1-2 `[https] sslverify = true` for all HTTP remotes. If this was intended only for a specific host, it should be scoped to `[http "https://specific.host"]`.
5. **`difftool "difftastic"`** uses `difft` (not `difftastic` or `difft` alias). Check which binary is actually installed.
6. **`gpg.format = ssh`** (line 175) together with `gpg.defaultKeyCommand` — works well but requires `allowedSignersFile`.

**Recommendations:**
- Consider changing default delta features to `catppuccin-mocha`.
- Remove duplicate dyff command.
- Scope `http.sslVerify = false` to specific hosts if possible.
- Clean up the `ignore` file — there are duplicate entries (`*.yang.uml`, `*.yang.yin`, `Cargo.lock`, `*.ccls-cache/`, `doc/tags-te`, etc.).

---

### `gitui` — GitUI

**Files:** `theme.ron`, `key_config.ron`, `mocha.ron`, `frappe.ron`, `macchiato.ron`, `latte.ron`

**Issues:**
1. **`theme.ron` is an empty/null theme** — it overrides all values to `None`, which means gitui uses its built-in default theme. This may hide the Catppuccin themes.
2. **Default shell alias (`alias gitui='gitui -t mocha.ron'`)** — ensures the Mocha theme is loaded, which compensates for the null theme file.
3. **`key_config.ron` is fully specified** with layered keybindings — good, but very long.

**Recommendations:**
- Either remove `theme.ron` (let gitui use defaults) or populate it with `mocha.ron` contents. An empty theme file is misleading.
- Clean up `.ron.old` files if they are no longer needed.

---

### `_htop` — htop

**Files:** `htoprc`

**Issues:**
1. **Auto-generated format:** The comment warns "Beware! This file is rewritten by htop when settings are changed" — but the file is stow-copied, not stowed. Any change in htop's UI will overwrite it if the file is writable.
2. **`delay=70`** (centiseconds = 0.7s) — quite fast; fine for desktop use.
3. **Screen tabs are disabled** (`screen_tabs=0`) — only the main screen is configured.

**Recommendations:**
- Consider making the file read-only after install since htop will rewrite it.
- Add a second I/O screen tab if desired (the `I/O` screen is already defined).

---

### `hyprland` — Hyprland compositor

**Files:** `hyprland.conf`, `mocha.conf`, `hyprlock.conf`, `hypridle.conf`, `battery_notif.sh`, `cleanup_after_start.sh`, `hyprpaper.conf`, `hyprsuspender.toml`, `opacity.sh`, `xdg-portal-hyprland`

**Issues:**
1. **`cleanup_after_start.sh` has a `sleep 10`** before resetting window rules — fragile; window classes may not be ready.
2. **`battery_notif.sh`** uses `upower` which is deprecated on some systems — consider `acpi` or `sysfs` directly.
3. **`xdg-portal-hyprland` script:** `killall` is race-prone — the portal may start between the kill and the new launch. A more robust approach uses `pkill -0` checks and retries.
4. **`hyprpaper.conf` references a wallpaper file** (`~/.config/wallpapers/VC7Z0339.jpg`) — this path is not part of the repo and will error on a fresh install.
5. **`cleanup_after_start.sh` window rules are hardcoded** with `sleep 10` — if applications start slowly, this may have no effect. Consider using Hyprland's `windowrule` directly in the config with workspace assignments.
6. **`$locker=swaylock`** is set but `hyprlock` is also installed — unused variable.
7. **`opacity.sh`** uses `hyprctl setprop` which works but the regex for extracting `WID` may break with different locale settings.

**Recommendations:**
- Replace `sleep 10` in `cleanup_after_start.sh` with a loop that polls for window existence.
- Add the single wallpaper used to the repo or create a placeholder script.
- Fix race conditions in `xdg-portal-hyprland` with PID checking.
- Remove unused `$locker` variable.

---

### `imv` — Image viewer

**Files:** `config`

**Issues:**
1. **Minimal config:** Only sets background, overlay text/background colours. Fine for basic use.

**Recommendations:**
- None (it does its job correctly).

---

### `lf` — Terminal file manager

**Files:** `lfrc`, `open.sh`, `preview.sh`

**Issues:**
1. **`preview.sh` — duplicate pattern branches:** `*.jpg`, `*.jpeg` etc. appear twice (lines 33 and 40), once with `chafa` commented out and once with `viu`. Only the second wins.
2. **`open.sh` — hardcoded image viewer:** Uses `sxiv` even though the system may prefer `imv` or `swayimg`.
3. **`preview.sh` — typo on line 40:** `| .git | *.GIF` — should be `*.gif | *.GIF` (pipe in wrong position).
4. **`open.sh` — background processes:** Uses `setsid ... >/dev/null 2>&1 &` but doesn't `disown`, so the shell may get SIGHUP.
5. **`open.sh` — `case` statements are sequential, not exclusive:** The archive mount block (lines 24-35) runs first, then the mime-type block runs on the same file. For zip files, both branches may execute.
6. **`preview.sh` — line 69:** Missing `exit 0` or `exit 1` after processing — if none of the cases match, it falls through to `bat --color always` for everything.

**Recommendations:**
- Remove the duplicate image handler in `preview.sh` (keep `viu`, remove the commented `chafa` line).
- Fix typo on line 40 (`.git` → `*.gif`).
- Add `disown` after `setsid` in `open.sh`.
- Restructure `open.sh` to use `elif` so only one branch runs.
- Add `exit 0` at end of `preview.sh` or handle the unary case.

---

### `mpv` — Video player

**Files:** `mpv.conf`, `input.conf`

**Issues:**
1. **Limited config:** Most settings are commented out. Only `osd-font-size=20` and screenshot directory are set.
2. **`screenshot-directory`** uses a non-XDG path (`~/dl/mpvscreenshots`).
3. **Most keyboard shortcuts in `input.conf`** are standard mpv defaults and may not need explicit definition.

**Recommendations:**
- Consider using XDG paths for screenshots: `$XDG_PICTURES_DIR/screenshots`.
- Clean up commented-out settings.

---

### `nix` — Nix

**Files:** `nix.conf`

**Issues:**
1. **Single line:** Only enables `nix-command` and `flakes`. This is correct for minimal usage but will use the system `nix` config as base.

**Recommendations:**
- Consider adding `auto-optimise-store`, `experimental-features = nix-command flakes`, and `substituters` if you use binary caches.

---

### `npm` — npm

**Files:** `npmrc`

**Issues:**
1. **Hardcoded CA path:** `cafile=/home/heiko/.zscaler-certs/ca-bundle-with-zscaler.pem` — this is user-specific and may not exist. If the CA file is missing, npm will fail on HTTPS.
2. **`tmp` uses `${XDG_RUNTIME_DIR}`** which is typically session-specific and may be cleaned on logout — npm may lose temporary files mid-operation.

**Recommendations:**
- Make the CA file check conditional: only set if the file exists.
- Consider using `$HOME/.tmp` for npm temp instead of XDG_RUNTIME_DIR.

---

### `paru` — AUR helper

**Files:** `paru.conf`

**Issues:**
1. **`RemoveMake` appears twice** (lines 17 and 24) — harmless but redundant.
2. **`FileManager = lf`** — works but only if `lf` is installed. Paru may fall back silently.
3. **`BottomUp` is commented out** — if you want the package list on top, enable it.

**Recommendations:**
- Remove duplicate `RemoveMake`.
- Consider adding `SkipReview` if you trust AUR packages (reduces interaction).

---

### `polybar` — Polybar

**Files:** `config.ini`, `launch.sh`, `updates-arch.sh`, `weather.sh`, `polybar-bluetoothctl.sh`

**Issues:**
1. **Two separate colour blocks** (lines 19-48 and 50-55) — the first block is all commented-out/inactive and the second is active. This is confusing.
2. **`modules-right`** for the base bar (line 90) includes both `pulseaudio` and no `temperature` on `artix` (line 110) but the `work` bar (line 114) has no bluetoothctl — inconsistency between bar variants.
3. **`font-size` set to `pixelsize=8`** — very small on high-DPI displays.
4. **Duplicated `bluetoothctl` module** — it has its own custom script module (line 125-132) and is also listed in `modules-right`.
5. **`launch.sh`** uses `HOST` hostname as bar name — expects a bar section named exactly `[bar/<hostname>]`.
6. **`weather.sh`** likely calls an external API rate-limited to 3600s — if it fails, the bar shows nothing.

**Recommendations:**
- Consolidate into one colour section.
- Add a fallback in `weather.sh` to return a static string on failure.
- Improve font size for HiDPI (e.g. `pixelsize=12` or `pixelsize=14`).
- Clean up unused `[module/alsa]` (pulseaudio is used instead).

---

### `presenterm` — Terminal presentation tool

**Files:** `config.yaml`

**Issues:**
1. **No issues found** — the config is comprehensive and well-structured.

**Recommendations:**
- None (clean config).

---

### `python` — Python startup

**Files:** `pythonrc`

**Issues:**
1. **`is_vanilla()` checks for `__IPYTHON__` and `bpython`** — but the function checks `__builtins__` which may not have the attribute in all Python versions. Safer: `__IPYTHON__` is a module-level global, not a builtin.
2. **No tab completion** is enabled.

**Recommendations:**
- Add `readline.parse_and_bind('tab: complete')` for basic tab completion.
- Fix the `__IPYTHON__` check to look at `__builtins__` as a dict or module depending on Python version.

---

### `_qutebrowser` — Qutebrowser

**Files:** `config.py`, `autoconfig.yml`, `catppuccin/setup.py`

**Issues:**
1. **`filter_yt` blocks ALL YouTube requests** (line 20-21) — after the ad block on line 19, there's an unconditional `info.block()` for all YouTube URLs. This breaks YouTube entirely in qutebrowser!
2. **`c.url.searchengines['DEFAULT']`** points to a local IP `http://10.7.7.2:9010/search?q={}` — this only works on the local network.
3. **`c.editor.command`** uses `os.environ['EDITOR']` which may not be set at import time — safer to use `config.source`.

**Recommendations:**
- **Critical fix:** Remove the unconditional `info.block()` on line 20-21, or change it to only block ads (`/get_video_info` with `&adformat=`).
- Make search engine configurable or provide a fallback.
- Use `config.get_editor_command()` or check for `EDITOR` at runtime.

---

### `_ranger` — Ranger

**Files:** `rc.conf`, `commands.py`, `devicons.py`, `scope.sh`, `plugins/`

**Issues:**
1. **`preview_images_method w3m`:** w3m is Linux-specific and may not work in all terminals (e.g. tmux, wezterm). Consider `kitty` or `iterm2` if your terminal supports it.
2. **`default_linemode devicons`** requires `devicons.py` plugin — confirmed present.
3. **Large, comprehensive config** with many vim-like bindings copied from defaults.

**Recommendations:**
- Test if `ueberzug` or `chafa` preview method works better with your terminal stack.
- Consider removing the default rc.conf copy if it duplicates built-in defaults (ranger loads default rc if not suppressed via `RANGER_LOAD_DEFAULT_RC=FALSE`).

---

### `rofi` — Rofi

**Files:** `config.rasi`, `catppuccin-mocha.rasi`

**Issues:**
1. **`selected-col` is same as `bg-col` (both `#1e1e2e`):** The selected item background is identical to the normal background, making selection invisible (line 5 vs line 2).
2. **`element selected text-color` uses `fg-col2` (`#f38ba8` red):** The selected foreground is red on black — readable but unconventional. Most themes use a highlighted background.
3. **`columns: 3` and `lines: 15`** — can look grid-like; may work better with `lines` set higher and `columns: 1` for a list.
4. **`icon-theme: "Reversal"`** — only works if that icon theme is installed.

**Recommendations:**
- Change `selected-col` to a lighter surface colour like `#45475a` (surface1) for visible selection.
- Clean up commented-out `@theme` lines.

---

### `ruff` — Python linter

**Files:** `pyproject.toml`

**Issues:**
1. **`select = ["ALL"]` in addition to `extend-select`:** This enables all rules globally, and `extend-select` adds nothing on top. Just `select = ["ALL"]` with `ignore` is cleaner.
2. **`fixable = ["ALL"]`** — be aware that some "fixes" may change semantics (e.g. `PLC` rules).
3. **`ignore` includes `COM812`, `ISC001`** which are formatting-related — these usually conflict with the formatter. Good to exclude them.

**Recommendations:**
- Remove `extend-select` since `select = ["ALL"]` already covers everything.
- Consider adding `unsafe-fixes = true` if you want maximum auto-fix.

---

### `sheldon` — Zsh plugin manager

**Files:** `plugins.toml`

**Issues:**
1. **`zsh-autocomplete` (marlonrichert) can conflict with `zsh-autosuggestions`:** Both try to control the completion UI. Autocomplete may override suggestions.
2. **`emoji-cli`** is a niche plugin — verify it still works with newer Zsh versions.

**Recommendations:**
- Either remove `zsh-autocomplete` or `zsh-autosuggestions` to avoid conflict.
- Consider adding `zsh-history-substring-search` for `ctrl-r` style search.

---

### `shell` — Shared shell config

**Files:** `alias.sh`, `env.sh`, `functions.sh`, `keybinding.sh`, `fuzzy_functions.sh`, `ssh_agent.sh`, `themes.sh`

This is the largest and most complex package.

**Issues:**

`env.sh`:
1. **`$BROWSER` is set to `elinks` by default** (line 56), then switched to `qutebrowser` if `$DISPLAY` is set — but only `qutebrowser` is handled. `brave` is commented out.
2. **`FIREFOX_PROFILE`** (line 37) — hardcodes `.mozilla/firefox` which may be overridden by XDG env.
3. **`ICEAUTHORITY` and `TERMINFO`** use broken curly-brace syntax: `{$XDG_CACHE_HOME:-$HOME/.cache}` (lines 162-165). The braces should wrap the whole default expression: `${XDG_CACHE_HOME:-$HOME/.cache}`.
4. **`$EDITOR`** fallback chain: `vim` → `nvim` (lines 52-53). Good.
5. **`$OPENER`** fallback: `xdg-open` → `mimeopen` (lines 61-64). Good.
6. **`LF_ICONS`** is extremely long (lines 336-406) — makes `env.sh` hard to navigate. Consider moving to a separate file.

`alias.sh`:
7. **`ls` aliases conflict** — if both `lsd` and `eza` are installed, the `lsd` aliases on lines 5-6 run but are overwritten by the `eza` block on lines 7-24. The `lsd` block is dead code on systems with `eza`.
8. **`alias gitui='gitui -t mocha.ron'`** — hardcoded path; works only if `mocha.ron` is in the gitui config dir.
9. **`alias top='htop'`** — if `btop` is also installed, this may not be the monitor you want.
10. **`alias X="startx"`** — likely a typo; lowercase `x` might be intended.

`keybinding.sh`:
11. **`bindkey '^[[A' fzf-history-widget`** maps `Up` arrow to `fzf-history-widget` — this replaces the default `up-line-or-history` for all uses, not just the history menu. Consider binding to `^R` instead.
12. **`bindkey -s '^[x' 'fconf\n'`** — uses `-s` (string) which may interfere with other plugins.

`functions.sh`:
13. **`supported_colors()`** uses a bare `NONE` variable that is never defined.
14. **`explain_command()`** reads `whatis` for a random command — this may fail silently or produce "nothing appropriate".
15. **`ggs()`** modifies files in `/home/heiko/.cache/git-global/` — fragile to hardcoded paths.
16. **`public_ip()`** calls `ipinfo.io` without HTTPS.

`fuzzy_functions.sh`:
17. **`fja` and `fj`** reference `JiraIssueCache*.issues` files in `$XDG_CACHE_HOME` — if these files don't exist, the functions fail silently.
18. **`fdc` and `fdi`** (Docker fzf functions) — `echo $images` and `echo $iid` on lines 511-512 output debug info that should probably be removed.
19. **`fgi()`** has a `--bind 'enter:become(...)'` on line 194 — but `--expect` is also used on line 193. Fzf doesn't support both simultaneously for the same key; `--expect` wins for `enter`, and `become` never runs.

**Recommendations:**
- Fix the brace syntax in `ICEAUTHORITY` and `TERMINFO` variables.
- Move `LF_ICONS` or other large data into separate files sourced on demand.
- Resolve `ls` alias conflicts (lsd vs eza).
- Fix `public_ip()` to use HTTPS.
- Fix `fgi()` enter binding conflict.
- Remove debug `echo` lines from `fdi`.

---

### `starship` — Starship prompt

**Files:** `starship.toml`

**Issues:**
1. **Git status shows `staged = " $count"`** but the format doesn't include the `$staged` variable explicitly. It's included via `$all_status` in `format`, so this may work.
2. **`username` always shown** with `show_always = true` — may be redundant if the prompt already has `hostname`.
3. **`shell` module disabled by default** — fine, but some users may want to see the current shell indicator.

**Recommendations:**
- No major issues; the config is well-structured with a beautiful Catppuccin Mocha palette.

---

### `stylua` — Lua formatter

**Files:** `stylua.toml`

**Issues:**
1. **Simple config:** 160 column width, Unix line endings, 4-space indent, single quotes, no call parentheses. All good.

---

### `swappy` — Screenshot annotation

**Files:** `config`

**Issues:**
1. **`save_dir=$HOME/media/pix/screenshots`** — uses `$HOME` which is not expanded at config parse time by swappy. Depending on the version, this may use the literal `$HOME` string as the directory name.

**Recommendations:**
- Verify that `$HOME` is expanded — if not, use an absolute path like `/home/heiko/media/pix/screenshots`.

---

### `swhkd` — SWHKD hotkey daemon

**Files:** `swhkdrc`

**Issues:**
1. **BSPWM-specific keybinds** (lines 13-14, 22-23, 28) — uses `bspc node` commands. This file is misplaced — it belongs with the BSPWM stow package, not as a standalone. On non-BSPWM systems these keys do nothing.
2. **Deprecated `scrot` usage** (line 5) — `scrot` is unmaintained. Consider `maim`, `grim` (Wayland), or just `import` from ImageMagick.
3. **Hardware-specific keybinds** — `XF86LaunchA`, `XF86LaunchB` may not exist on all keyboards.

**Recommendations:**
- Rename the package to `_swhkd` to indicate it's not auto-stowed, or move the BSPWM-specific parts into a dedicated package.
- Replace `scrot` with `maim` or make it conditional.

---

### `tmux` — Tmux

**Files:** `tmux.conf`, `plugins/vim-tmux-navigator` (submodule)

**Issues:**
1. **`set -g default-terminal "${TERM}"`** (line 20) — This evaluates `$TERM` at config load time. Inside tmux, `TERM` is set to `tmux-256color` or `screen-256color`, but the quoted value may be empty if loaded early. Prefer a literal.
2. **`default-terminal`** is not set to a concrete value like `tmux-256color` — the terminfo database lookup may fail if `TERM` wasn't set.
3. **Standalone `run-shell`** for `tmux-thumbs` (line 110) — usually handled by TPM, but it runs twice (once via `run-shell`, once via TPM's automatic run). Check for duplicate plugin initialisation.
4. **`@thumbs-reqexp-2` typo:** `reqexp` instead of `regexp` (line 193) — this option is silently ignored, so URL matching falls back to defaults.
5. **`@continuum-restore 'on'`** appears twice (lines 100 and 154) — the first is commented out but the second is active. With `@resurrect-strategy-nvim 'session'` enabled, ensure `tmux-resurrect` and `tmux-continuum` plugins are also loaded (they are commented out on lines 99-100).
6. **No explicit `set -g default-terminal "tmux-256color"`** set for true color support — relies entirely on terminal-overrides.

**Recommendations:**
- Fix typo `@thumbs-reqexp-2` → `@thumbs-regexp-2`.
- Set `default-terminal` to `"tmux-256color"` explicitly.
- Remove the duplicate `run-shell` line if TPM manages thumbs.
- Verify `continuum-restore` is paired with an active plugin load (uncomment lines 99-100).

---

### `topgrade` — System upgrade tool

**Files:** `topgrade.toml`

**Issues:**
1. **`remote_topgrade_path`** hardcoded to `/home/heiko/.nix-profile/bin/topgrade` — only valid if Nix is installed on that specific path.
2. **`repos`** list only contains personal repos — no `pull_predefined` config, meaning Topgrade will not pull the default set of repos. That's fine if intentional.
3. **`skip_notify = true`** — no notification of completion. If you want a summary, consider setting to `false`.

**Recommendations:**
- None critical; config is clean.

---

### `_user-dirs` — XDG user directories

**Files:** `user-dirs.dirs`, `user-dirs.locale`

**Issues:**
1. **Mismatch with `env.sh`:** `XDG_PICTURES_DIR` is `$HOME/pix` in this file (line 15), but `$HOME/media/pix` in `env.sh` (line 22). These should be consistent.
2. **`XDG_TEMPLATES_DIR`** is `$HOME/media/temp` — unusual; normally it would point to a Templates directory.
3. **This file is generated by `xdg-user-dirs-update`** and may be overwritten if that utility runs.

**Recommendations:**
- Align `user-dirs.dirs` with the values in `env.sh` for consistency.

---

### `_vifm` — Vifm file manager

**Files:** `vifmrc`, `scripts/README`

**Issues:**
1. **`vifmrc` not inspected in detail** — only a `scripts/README` exists beyond the main `vifmrc`.

**Recommendations:**
- Consider adding a colour scheme to match Catppuccin Mocha.

---

### `waybar` — Waybar status bar

**Files:** `config.jsonc`, `style.css`, `mocha.css`

**Issues:**
1. **Hardcoded `width: 1920`** (line 5) — this won't work on non-1080p monitors or multiple monitors. Set it to 100% or remove for auto-width.
2. **`on-click` actions hardcode `st -e`** (lines 51, 74) — `st` may not be installed; consider using the `$TERMINAL` variable.
3. **`backlight` module uses `light -T`** (lines 91-92) — the `light` utility may not be installed. Consider `brightnessctl` as used in Hyprland bindings.
4. **No styling for selected workspace** — the `#workspaces button.active` in `style.css` uses generic colours (`#64727D`), not Catppuccin Mocha palette variables.
5. **`style.css` imports `mocha.css`** (line 1) but doesn't use the CSS variables from it for most module background colours — many modules have hardcoded hex colours.

**Recommendations:**
- Change `width` to `100%` or remove it.
- Replace `st -e` with `$TERMINAL -e` or a generic launcher.
- Use Catppuccin Mocha CSS variables (from `mocha.css`) throughout `style.css` instead of hardcoded colours.
- Switch backlight to `brightnessctl` for Wayland compatibility.

---

### `wezterm` — Wezterm terminal

**Files:** `wezterm.lua`

**Issues:**
1. **`window_background_opacity` set twice** (lines 27 and 98) — the second value (`0.90` vs `0.9`) overrides the first. Remove the duplicate.
2. **`animation_fps = 1`** (line 87) — very low; cursor blink will be sluggish. The default (60) is fine.
3. **`cursor_blink_rate = 600`** (line 92) at `animation_fps = 1` means the cursor only changes state once per second.
4. **`config.font`** uses `font_with_fallback` with three fonts — good practice. Consider adding `Noto Color Emoji` as the last fallback for emoji support.
5. **Split keybindings** use `LEADER` + `|` for vertical split and `-` for horizontal — these are reversed vs. tmux conventions (`-` for horizontal, `|` for vertical). Verify this is intentional.

**Recommendations:**
- Remove duplicate `window_background_opacity`.
- Increase `animation_fps` to 60 or remove it (default).
- Split semantic: swap `|` (vertical) and `-` (horizontal) if they don't match your muscle memory.
- Add emoji fallback font.

---

### `X11` — X11 config

**Files:** `Xresources`, `xinitrc`

**Issues:**
1. **Gruvbox colours only** — no Catppuccin Mocha. This is fine for X11 sessions, but the theme mismatch with the rest of the system is notable.
2. **`xinitrc` loads `Xresources` twice** (lines 22-24 and 34-37) — once unconditionally at the start, and once after checking for `sysresources`. This is a no-op but confusing.
3. **`xinitrc` is a complex shell script** — the `get_session()` function duplicates the session launching logic that `~/.xinitrc` normally delegates to a display manager.
4. **`Xresources` has duplicate color definitions** — lines 17-23 set `*background`, `*foreground`, etc., then lines 78-80 set `*.background`, `*.foreground` again with the same values.
5. **`Xresources` line 43** — `*color12` is `#835a98` (a pinkish-purple) instead of the correct Gruvbox blue `#83a598` — this looks like a typo (`835a` vs `83a5`).

**Recommendations:**
- Fix the `*color12` typo on line 43 (`#835a98` → `#83a598`).
- Remove duplicate colour definitions in `Xresources`.
- Simplify `xinitrc` or consider using a display manager.
- Consider adding a Catppuccin Mocha Xresources variant.

---

### `xplr` — File manager

**Files:** `init.lua`

**Issues:**
1. **`git clone` in `init.lua`** (line 9) — cloning external repos from within a config file is unusual and raises security concerns. Prefer a plugin manager or manual install.
2. **Version pinned to `0.21.2`** (line 1) — may be outdated; newer xplr versions may have breaking changes.
3. **Fzf plugin key conflicts** — `ctrl-f` (line 43) but line 32 also binds fzf in several places. Check for overlaps.

**Recommendations:**
- Instead of cloning in `init.lua`, use `install.sh` to set up xplr plugins.
- Update the version constraint.

---

### `xsuspender` — Window suspender

**Files:** `xsuspender.conf`

**Issues:**
1. **`Default` section is identical** to `hyprsuspender.toml` — but this is for X11 (`xsuspender`) whereas `hyprland/hyprsuspender.toml` is for Wayland (`hyprsuspender`). Both are maintained separately, which is good.
2. **`resume_every = 57` and `resume_for = 3`** — windows resume for 3 seconds every ~1 minute. This is minimal but works.

**Recommendations:**
- None critical.

---

### `yazi` — File manager

**Files:** `init.lua`, `theme.toml`, `keymap.toml`, `package.toml`, `package.toml.orig`, `flavors/catppuccin-mocha.yazi`, `plugins/`

**Issues:**
1. **`package.toml.orig`** — an orphaned backup file; should be removed.
2. **Key `z` is used twice** in `keymap.toml`: once for `jump zoxide` (line 101) and once for `plugin mermaid -- toggle-mode` (line 304) in the prepend section. The prepend keymap takes priority, so `z` toggles mermaid instead of zoxide.
3. **`init.lua`** only references `eza-preview` and `duckdb` — but the plugins listed in `package.toml` (via install.sh) include `git`, `diff`, `chmod`, etc. Many plugins are installed but not configured in `init.lua`.
4. **Key `L` is used twice:** once for `plugin bypass` (tab manager prepend line 33) and once for `plugin duckdb +1` (line 287-290). The prepend keymap block on line 283 overrides the one on line 33 for `L`.

**Recommendations:**
- Remove `package.toml.orig`.
- Resolve the key conflict for `z` and `L`.
- Add configuration for the installed-but-unconfigured plugins (`git`, `chmod`, `diff`, `mount`, etc.).

---

### `ytfzf` — YouTube TUI

**Files:** `conf.sh`

**Issues:**
1. **`thumb_disp_method="ueberzug"`** — ueberzug is unmaintained. Consider `chafa`, `catimg`, or `viu`.
2. **`history_file`** uses `$cache_dir` without the variable being sourced first — `cache_dir` is defined in `conf.sh` (line 41), so it works within the file scope. OK.
3. **`is_download` defined twice** (lines 135 and 161) — the second overrides the first; harmless but redundant.
4. **`external_menu`** (line 62-65) calls `dmenu` explicitly inside the function — `dmenu` may not handle the 40-line menu height on all setups.

**Recommendations:**
- Replace `ueberzug` with `chafa` or `viu`.
- Remove duplicate `is_download`.
- Consider rofi as alternative external menu.

---

### `zathura` — PDF viewer

**Files:** `zathurarc`, `catppuccin-mocha`

**Issues:**
1. **`set sandbox none`** (line 19) — disables zathura's sandbox for following links. This is a security trade-off (necessary for `synctex` links). Document this.
2. **`map g goto top`** (line 22) — overrides the scroll-to-top key. OK.
3. **`recolor` enabled** (line 49) — inverts PDF colours for dark mode. This may break PDFs with alpha transparency.
4. **`window-width` and `window-height`** — set to 768x1024, fixed. Consider not setting these for auto-sizing.

**Recommendations:**
- Add a comment explaining why `sandbox none` is needed.
- Set `window-width` and `window-height` dynamically or remove them.

---

### `zellij` — Terminal multiplexer

**Files:** `config.kdl`

**Issues:**
1. **`keybinds clear-defaults=true`** — this wipes all default keybinds and redefines everything from scratch. This is powerful but means any new Zellij feature won't have a keybind until manually added.
2. **`theme "catppuccin-mocha"`** (line 249) — uses a built-in Zellij theme name. Verify this matches an installed theme; Zellij 0.40+ ships with `catppuccin-mocha`.
3. **`pane_frames false`** (line 217) — hides pane borders for a cleaner look. Fine.
4. **The locked mode only has one key (`Ctrl g`)** to unlock — if you forget this, you're locked out until you restart the session.
5. **`Ctrl b` appears in both `pane` and `shared_except "tmux"`** (lines 33, 46, 181) — `Ctrl b` in pane mode (line 33) switches to Normal mode, but in the shared tmux section (line 181) `Ctrl b` switches to Tmux mode. The `clear-defaults=true` means they won't conflict.

**Recommendations:**
- Add more keybinds to `locked` mode (e.g., a short hint).
- Consider not clearing all defaults — use individual `unbind` statements instead, so new Zellij features get automatic keybinds.

---

### `zsh` — Zsh configuration

**Files:** `.zshenv`, `dot-config/zsh/zprofile`, `dot-config/zsh/zshrc`

**Issues:**
1. **`zprofile` sources `zshrc`** (line 2) — this means every login shell also loads the `zshrc` which contains interactive-only settings (prompt, keybinds, completions). This may break non-interactive SSH commands or scripts.
2. **`.zshenv` sources both `env.sh` and `zshrc`** (lines 2-3) — same problem: `zshrc` (with prompt, keybinds, completions) is loaded for every shell, even non-interactive ones. The `[[ $- == *i* ]]` check at the top of `zshrc` (line 2) mitigates this, but sourcing `fzf` keybindings in non-interactive shells is unnecessary.
3. **`HISTORY_IGNORE`** (line 15) — only works with the `hist_ignore_all_dups` option set. Currently only `HIST_EXPIRE_DUPS_FIRST` is enabled (line 16). History ignore will not work without both.
4. **`bindkey -v`** (line 68) enables vi-mode, but `KEYTIMEOUT=1` (line 69) is extremely short (10ms) — may cause Esc to not register properly on slow terminals.
5. **`$PROMPT_COMMAND`** sets the terminal title (lines 22-29) — `PROMPT_COMMAND` is a bash construct; in Zsh the equivalent is `precmd()`. This should be a `precmd` hook, not `PROMPT_COMMAND`.
6. **VBoxClient** checks (lines 32-39) — only relevant inside a VirtualBox VM. This clutters every shell startup on bare metal.
7. **`aichat` integration** (lines 41-53) — nice feature, but `aichat -e` is called synchronously and blocks the shell prompt while generating.

**Recommendations:**
- Move interactive-only sourcing (fzf, sheldon, starship, etc.) to `zshrc` only (which already happens), but fix `zprofile` to **not** source `zshrc`.
- Fix `HISTORY_IGNORE` by adding `setopt HIST_IGNORE_ALL_DUPS` or `setopt HIST_IGNORE_SPACE`.
- Replace `PROMPT_COMMAND` with a Zsh `precmd` hook: `autoload -Uz add-zsh-hook; add-zsh-hook precmd '...'`.
- Move VirtualBox checks to a separate script sourced only when needed.
- Consider making `aichat` async or adding a timeout.

---

### `install.sh` — Bootstrap installer

**Issues:**
1. **XDG variable exports** duplicate the definitions in `env.sh` (lines 6-18) — if `env.sh` changes, `install.sh` may become inconsistent.
2. **`fd` used for stow operations** (lines 37-39) — requires `fd` to be installed before running. Consider a fallback to `find`.
3. **`mkdir -p "$XDG_MUSIC_DIR" 3>/dev/null`** (line 27) — typo: `3>/dev/null` should be `2>/dev/null` for stderr redirection.
4. **`cd ~/opt` then `cd -`** (lines 45, 52) — if `~/opt` does not exist, `cd ~/opt` fails, and the rest of the block is skipped. The `||` guard on the second cd is good.
5. **`sheldon lock --update`** (line 69) — runs before any stow operations finish, which may be fine but could conflict if sheldon is still being set up.
6. **Age key generation** (lines 107-131) — generates two age keys with different methods. The second key (`${USER}@$(cat /etc/hostname).age`) is encrypted with a password and may not be auto-detected by `SOPS_AGE_KEY_FILE`.

### `bootstrap.sh` — Full system bootstrap

**Issues:**
1. **`run_as_root` function** installs specific package list — assumes `artix-archlinux-support` is desired. On vanilla Arch this breaks.
2. **`read -r -p`** on lines 38, 57 — missing prompt string argument for `-p`. This causes a syntax error on some shells.
3. **Network config** (lines 39-42) — hardcoded to `192.168.1.x` subnet. Not portable.
4. **`newgrp docker`** (line 45) — opens a new shell as the `docker` group, which interrupts the script execution. The rest of the script won't run.

### `Justfile` — Just command runner

**Issues:**
1. **The `update` recipe** does `git fetch...rebase` and then `git pull` — redundant. `pull` will fetch again and try to merge the already-rebased HEAD. It should just be `git pull --rebase --recurse-submodules`.
2. **`$just --list`** (line 3) uses `$just` which is an infinite recursion if invoked as `just`.

## License

This repository is licensed under the MIT License. See `LICENSE` for details.

---

*Generated and maintained by [Heiko Riemer](https://eheiko.net)*