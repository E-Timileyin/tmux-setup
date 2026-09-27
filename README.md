# Tmux Configuration

A well-commented tmux configuration with vim-style keybindings, intuitive splits, and the **Akaza** color palette.

Complete keybinding reference: [KEYS.md](KEYS.md).

**Tmux version:** 3.5a
**Config location:** `~/.config/tmux/tmux.conf`
**Prefix key:** `Ctrl-a`

---

## Table of Contents

- [Basic Commands](#basic-commands)
- [Installation](#installation)
- [Keybindings](#keybindings)
  - [Core](#core)
  - [Sessions](#sessions)
  - [Window Navigation](#window-navigation)
  - [Pane Splits](#pane-splits)
  - [Pane Navigation](#pane-navigation)
  - [Pane Resizing](#pane-resizing)
  - [Copy Mode (Vim-style)](#copy-mode-vim-style)
  - [Alt Key Shortcuts (No Prefix)](#alt-key-shortcuts-no-prefix)
  - [Session Save and Load](#session-save-and-load)
- [Full Key Reference](#full-key-reference)
- [Configuration Sections](#configuration-sections)
- [Theme](#theme)
- [Customization Guide](#customization-guide)

---

## Basic Commands

Essential tmux commands to run from your terminal:

### Starting and Attaching

```bash
# Start a new unnamed session
tmux

# Start a new named session
tmux new -s mysession

# List all running sessions
tmux ls

# Attach to the last session
tmux attach

# Attach to a specific session by name
tmux attach -t mysession

# Attach or create if it doesn't exist
tmux new -A -s mysession
```

### Detaching and Killing

```bash
# Detach from inside tmux (returns to normal terminal)
# Press: Ctrl-a d

# Kill a specific session from outside tmux
tmux kill-session -t mysession

# Kill all sessions
tmux kill-server
```

### Information

```bash
# Show all active sessions
tmux ls

# Show all keybindings
tmux list-keys

# Show all tmux options and their values
tmux show-options -g

# Show tmux version
tmux -V
```

### Sending Commands

```bash
# Reload config from outside tmux
tmux source-file ~/.config/tmux/tmux.conf

# Send keys to a specific session/window/pane
tmux send-keys -t mysession:1.1 "ls -la" Enter
```

---

## Installation

1. Place `tmux.conf` at `~/.config/tmux/tmux.conf` (XDG-compliant location).

2. Reload the config from within tmux:
   ```
   Ctrl-a r
   ```
   Or from the command line:
   ```bash
   tmux source-file ~/.config/tmux/tmux.conf
   ```

3. Start a new tmux session:
   ```bash
   tmux new -s main
   ```

---

## Keybindings

All keybindings use `Ctrl-a` as the prefix unless noted otherwise. Press `Ctrl-a` first, release, then press the key.

### Core

| Keys | Action |
|------|--------|
| `Ctrl-a r` | Reload tmux config |
| `Ctrl-a c` | Create new window (inherits current directory) |
| `Ctrl-a ,` | Rename current window |
| `Ctrl-a &` | Kill current window |
| `Ctrl-a d` | Detach from session |

### Sessions

| Keys | Action |
|------|--------|
| `Ctrl-a N` | Create a new session |
| `Ctrl-a S` | Switch session (interactive tree view) |
| `Ctrl-a $` | Rename current session |
| `Ctrl-a X` | Kill current session (with confirmation) |

### Window Navigation

| Keys | Action |
|------|--------|
| `Ctrl-a n` | Next window |
| `Ctrl-a p` | Previous window |
| `Ctrl-a <` | Swap window one position to the left |
| `Ctrl-a >` | Swap window one position to the right |
| `Alt + 1-9` | Jump directly to window 1-9 (no prefix) |

### Pane Splits

| Keys | Action |
|------|--------|
| `Ctrl-a \|` | Split horizontally (side by side) |
| `Ctrl-a -` | Split vertically (top / bottom) |

Both splits inherit the current pane's working directory.

### Pane Navigation

| Keys | Action |
|------|--------|
| `Ctrl-a h` | Move to left pane |
| `Ctrl-a j` | Move to pane below |
| `Ctrl-a k` | Move to pane above |
| `Ctrl-a l` | Move to right pane |
| `Ctrl + h/j/k/l` | Same as above, no prefix, vim-aware |
| `Alt + h/j/k/l` | Same as above, alternate modifier, vim-aware |

`Ctrl` and `Alt` navigation is vim-aware: if the pane is running nvim, vim, fzf, or view, the key is forwarded so it moves between editor splits instead. Otherwise tmux moves between panes.

`Ctrl-l` now moves right instead of clearing the screen. Use `Ctrl-a Ctrl-l` to clear.

### Pane Resizing

| Keys | Action |
|------|--------|
| `Ctrl-a H` | Resize pane left by 5 cells |
| `Ctrl-a J` | Resize pane down by 5 cells |
| `Ctrl-a K` | Resize pane up by 5 cells |
| `Ctrl-a L` | Resize pane right by 5 cells |
| `Ctrl-a m` | Toggle pane zoom (maximize / restore) |

Resize keys are repeatable: hold prefix once, then press `H/J/K/L` multiple times.

### Copy Mode (Vim-style)

| Keys | Action |
|------|--------|
| `Ctrl-a [` | Enter copy mode |
| `v` | Start selection |
| `Ctrl-v` | Toggle block/rectangle selection |
| `y` | Yank (copy) selection and exit |
| `q` | Exit copy mode without copying |

Mouse drag selects text and copies it automatically on release, same as pressing `y`.

### Alt Key Shortcuts (No Prefix)

These work instantly without pressing the prefix key:

| Keys | Action |
|------|--------|
| `Alt + h/j/k/l` | Switch panes (vim directions) |
| `Alt + 1-9` | Jump to window by number |

### Session Save and Load

Backed by `tmux-resurrect` and `tmux-continuum`. Nothing restores when tmux starts; you choose what to load.

| Keys | Action |
|------|--------|
| `Ctrl-a Ctrl-s` | Save the session tree under a name |
| `Ctrl-a Ctrl-r` | Menu: load a named save, or the latest autosave |
| `Ctrl-a Ctrl-x` | Menu: delete a named save |

Continuum autosaves every 15 minutes as a crash backup and never overwrites named saves, which live in `~/.local/share/tmux/resurrect/named/`.

---

## Full Key Reference

[KEYS.md](KEYS.md) lists every binding, including the stock tmux defaults this config leaves intact, plus the shell commands and the known gotchas.

---

## Configuration Sections

The `tmux.conf` file is organized into clearly labeled sections. Each section starts with a banner comment for easy navigation:

| Section | Description |
|---------|-------------|
| **Terminal & Color Support** | Sets 256-color/true-color (RGB) for popular terminals |
| **Mouse & Clipboard** | Enables mouse support and OSC 52 clipboard integration |
| **Prefix Key** | Remaps prefix from `Ctrl-b` to `Ctrl-a` |
| **General Options** | Escape time, scrollback buffer, focus events, display timers |
| **Window & Pane Indexing** | Base index starts at 1, auto-renumber on close |
| **Config Reload** | `Prefix + r` to reload config with confirmation message |
| **Pane Splits** | `|` and `-` splits that preserve working directory |
| **Pane Navigation** | Vim-style `h/j/k/l` movement |
| **Pane Resizing** | Uppercase `H/J/K/L` for repeatable resizing |
| **Window Navigation** | Swap windows with `<` and `>` |
| **Session Management** | Create, switch, and kill sessions |
| **Seamless nvim to tmux Navigation** | Vim-aware `Ctrl`/`Alt` h/j/k/l movement |
| **Alt Key Shortcuts** | Prefix-free pane and window switching |
| **Copy Mode** | Vim keybindings for copy mode |
| **Theme** | Akaza color palette |
| **Plugins** | Session save and restore via resurrect and continuum |

---

## Theme

The configuration uses the **Akaza** palette (Demon Slayer inspired), defined as `thm_*`
variables at the top of the **THEME** section:

| Variable | Hex | Usage |
|----------|-----|-------|
| `thm_bg` | `default` | Status bar background (transparent, matches terminal) |
| `thm_fg` | `#F1F5F9` | Default status text |
| `thm_white` | `#FFFFFF` | Message text, `C-a` pill |
| `thm_gray` | `#1E2330` | Status segment backgrounds |
| `thm_black` | `#12131A` | Dark backgrounds |
| `thm_cyan` | `#00E5FF` | Active pane border, window index, clock |
| `thm_pink` | `#FF2A8A` | Checkmark, window activity, mode highlight |
| `thm_comment` | `#94A3B8` | Inactive window text |
| `thm_border` | `#2D3242` | Inactive pane border |
| `thm_border_active` | `#00E5FF` | Active pane border |
| `thm_magenta` | `#E6007E` | Defined, unused by default |
| `thm_blue` | `#38BDF8` | Defined, unused by default |
| `thm_yellow` | `#FFD166` | Defined, unused by default |
| `thm_red` | `#F43F5E` | Defined, unused by default |
| `thm_green` | `#34D399` | Defined, unused by default |

### Status Bar Layout

```
LEFT:    (empty)
WINDOWS: index + name + checkmark (active), muted index (inactive)
RIGHT:   [ C-a pill ] [ last 2 path segments ] [ session name ]
```

- The `C-a` pill appears only while the prefix is held.
- The path segment shows the last two directories of the active pane.

---

## Customization Guide

### Changing the Prefix Key

Edit the **PREFIX KEY** section. For example, to use `Ctrl-s`:

```tmux
unbind C-b
set -g prefix C-s
bind-key C-s send-prefix
```

### Changing the Color Theme

All colors are defined as variables at the top of the **THEME** section. Update the `thm_*` variables to match your preferred palette:

```tmux
thm_bg="#1a1b26"      # your background
thm_fg="#a9b1d6"      # your foreground
thm_cyan="#7aa2f7"    # your accent color
# ... etc
```

### Adjusting Pane Resize Step

The default resize step is 5 cells. Change the number in the **PANE RESIZING** section:

```tmux
bind -r H resize-pane -L 10    # resize by 10 instead of 5
```

### Changing Scrollback History

Edit the `history-limit` value in the **GENERAL OPTIONS** section:

```tmux
set -g history-limit 100000    # 100k lines instead of 50k
```

### Adding Terminal RGB Support

If your terminal is not listed, add it to the **TERMINAL & COLOR SUPPORT** section:

```tmux
set -as terminal-features "your-terminal:RGB"
```

### Disabling Mouse Support

Comment out or remove in the **MOUSE & CLIPBOARD** section:

```tmux
# set -g mouse on
```
