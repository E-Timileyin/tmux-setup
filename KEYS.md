# tmux Key Reference

Complete keybinding reference for this configuration.

**Prefix:** `Ctrl-a` (replaces tmux's default `Ctrl-b`)
**Config:** `~/.config/tmux/tmux.conf`
**tmux:** 3.5a

Every key marked `prefix` means: press `Ctrl-a`, release, then press the key.
The status bar shows a `C-a` pill on the right while the prefix is held, so you can tell when tmux is waiting for the next key.

---

## Panes

Panes are splits inside a single window. This is the section most people actually want.

| Keys | Action |
|------|--------|
| `prefix` `\|` | Split side by side (new pane on the right) |
| `prefix` `-` | Split top and bottom (new pane below) |
| `prefix` `h` `j` `k` `l` | Move to pane left / down / up / right |
| `prefix` `H` `J` `K` `L` | Resize pane by 5 cells (repeatable) |
| `prefix` `m` | Zoom pane to full window, or restore |
| `prefix` `z` | Same as `m` |
| `prefix` `x` | Kill pane (asks for confirmation) |
| `prefix` `o` | Cycle to the next pane |
| `prefix` `;` | Jump to the previously active pane |
| `prefix` `q` | Flash pane numbers for direct selection |
| `prefix` `Space` | Cycle through pane layouts |
| `prefix` `{` `}` | Move pane backward / forward in the layout |
| `prefix` `!` | Break pane out into its own window |
| `prefix` `M` | Mark pane (used by `swap-pane`) |
| `prefix` `*` | New pane (tmux 3.5 default) |

New panes inherit the current pane's working directory.

### Resizing

`H` `J` `K` `L` are repeatable. Press `Ctrl-a` once, then hold or repeat the shift key without pressing the prefix again.
The step is 5 cells, set in the **PANE RESIZING** section of `tmux.conf`.

---

## Windows

A window is a full-screen view inside a session. It holds panes.

| Keys | Action |
|------|--------|
| `prefix` `c` | New window (inherits current directory) |
| `prefix` `n` | Next window |
| `prefix` `p` | Previous window |
| `prefix` `,` | Rename current window |
| `prefix` `&` | Kill current window (asks for confirmation) |
| `prefix` `f` | Find window by name |
| `prefix` `w` | List windows, pick one |
| `prefix` `<` | Swap window one position left (repeatable) |
| `prefix` `>` | Swap window one position right (repeatable) |
| `prefix` `0` to `9` | Jump to window by index |
| `prefix` `E` | Spread panes into an even layout |
| `prefix` `C-o` | Rotate panes in the window |

Window and pane indexes start at **1**, not 0, and renumber automatically when one closes.

---

## Sessions

| Keys | Action |
|------|--------|
| `prefix` `N` | New session |
| `prefix` `S` | Switch session (interactive tree view) |
| `prefix` `s` | Switch session and window (tree view) |
| `prefix` `$` | Rename current session |
| `prefix` `X` | Kill current session (asks for confirmation) |
| `prefix` `d` | Detach from session |
| `prefix` `D` | Pick a client to detach |
| `prefix` `(` `)` | Switch to previous / next session |
| `prefix` `C-z` | Suspend tmux to the background |

`prefix` `N` was previously `Ctrl-c`. It moved because `Ctrl-c` is SIGINT, and one slip from `prefix` `c` (new window) created stray sessions by accident.

---

## Navigation Without the Prefix

These work instantly, no prefix required.

| Keys | Action |
|------|--------|
| `Ctrl` `h` `j` `k` `l` | Move left / down / up / right |
| `Alt` `h` `j` `k` `l` | Same, alternate modifier |
| `Alt` `1` to `9` | Jump directly to window 1 to 9 |

`Ctrl` and `Alt` navigation is **vim-aware**. If the current pane runs nvim, vim, fzf, or view, the key is forwarded to that program so it moves between editor splits instead. Otherwise tmux moves between panes.
This gives one keybinding that works correctly in both layers, which is what the `vim-tmux-navigator` setup in `tmux.conf` exists to do.

The same four keys also navigate while in copy mode.

### Trade-off

`Ctrl-l` normally clears the shell. Under this config it moves right instead.
To clear the screen, use `prefix` `Ctrl-l`.

---

## Copy Mode

Vim-style keys, enabled by `mode-keys vi`.

| Keys | Action |
|------|--------|
| `prefix` `[` | Enter copy mode |
| `v` | Start selection |
| `Ctrl-v` | Toggle block (rectangle) selection |
| `y` | Yank selection and exit copy mode |
| `q` | Exit copy mode without copying |
| `Ctrl` `h` `j` `k` `l` | Move around panes while scrolling |

Mouse drag selects text and copies it on release, the same as pressing `y`.

---

## Session Save and Restore

Backed by `tmux-resurrect` and `tmux-continuum`, with a wrapper script at `~/.config/tmux/scripts/sessions.sh`.

| Keys | Action |
|------|--------|
| `prefix` `Ctrl-s` | Save the whole session tree under a name |
| `prefix` `Ctrl-r` | Menu: load a named save, or the latest autosave |
| `prefix` `Ctrl-x` | Menu: delete a named save |
| `prefix` `M-s` | Raw resurrect save |
| `prefix` `M-r` | Raw resurrect restore |

Nothing restores when tmux starts. Continuum autosaves every 15 minutes as a crash backup and never overwrites named saves, which live in `~/.local/share/tmux/resurrect/named/`.

Plugin management, from `tpm`:

| Keys | Action |
|------|--------|
| `prefix` `I` | Install plugins |
| `prefix` `U` | Update plugins |

---

## Miscellaneous

| Keys | Action |
|------|--------|
| `prefix` `r` | Reload this config |
| `prefix` `:` | Open the tmux command prompt |
| `prefix` `?` | List all active keybindings |
| `prefix` `t` | Clock |
| `prefix` `i` | Window information |
| `prefix` `]` | Paste most recent buffer |
| `prefix` `#` | List paste buffers |
| `prefix` `=` | Choose a paste buffer |
| `prefix` `~` | Show messages |
| `prefix` `PPage` | Enter copy mode and page up |
| `prefix` `M-n` `M-p` | Next / previous window |
| `prefix` `M-o` | Rotate panes |
| `prefix` `M-1` to `M-7` | Preset pane layouts |

Anything not listed here keeps its stock tmux default. To see the live, complete table:

```bash
tmux list-keys                    # everything
tmux list-keys -T prefix          # only prefix keys
tmux list-keys -T root            # only prefix-free keys
tmux -f /dev/null list-keys       # stock defaults, for comparison
```

---

## From the Shell

| Command | Purpose |
|---------|---------|
| `tmux` | Start a new unnamed session |
| `tmux new -s work` | Start a named session |
| `tmux new -A -s work` | Attach to `work`, or create it |
| `tmux ls` | List sessions |
| `tmux attach -t work` | Attach to a session by name |
| `tmux kill-session -t work` | Kill a session |
| `tmux kill-server` | Kill everything |
| `tmux source-file ~/.config/tmux/tmux.conf` | Reload config from outside tmux |
| `tmux -V` | Show tmux version |

---

## Gotchas

Things worth knowing before they cost you a session.

**`Ctrl-c` is not a tmux key.** Plain `Ctrl-c` goes to whatever is running in the pane, as SIGINT. It never reaches tmux.
Only `Ctrl-a` then `Ctrl-s`, `Ctrl-r`, `Ctrl-x`, or `Ctrl-l` are tmux keys.

**Removing a binding needs an explicit `unbind`.** `tmux source-file` re-applies bindings but never removes ones deleted from `tmux.conf`.
Without an `unbind` line, a server that already had the old binding keeps it forever and the config silently disagrees with tmux.
This is why the session section contains `unbind C-c` next to `bind N new-session`.

**Detaching is `prefix` `d`.** A clean screen with a fresh prompt usually means a new window (`prefix` `c`) or a new session (`prefix` `N`), not a detach.
Check the window list in the status bar before assuming the session is gone.

**`m` and `M` are different keys.** `prefix` `m` zooms the pane. `prefix` `M` marks it. `prefix` `M-s` is a resurrect save, which is a third thing again.

**Mouse is on.** Scrolling, clicking a pane, and dragging a border to resize all work. Use the scroll wheel for history instead of entering copy mode.
