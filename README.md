# Tmux Configuration

A clean, well-commented tmux configuration with vim-style keybindings, intuitive splits, and the **TokyoNight Moon** color scheme.

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
| `Ctrl-a Ctrl-c` | Create a new session |
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
| `Alt + h/j/k/l` | Same as above, no prefix needed |

### Pane Resizing

| Keys | Action |
|------|--------|
| `Ctrl-a H` | Resize pane left by 5 cells |
| `Ctrl-a J` | Resize pane down by 5 cells |
| `Ctrl-a K` | Resize pane up by 5 cells |
| `Ctrl-a L` | Resize pane right by 5 cells |
| `Ctrl-a m` | Toggle pane zoom (maximize / restore) |

Resize keys are repeatable -- hold prefix once, then press `H/J/K/L` multiple times.

### Copy Mode (Vim-style)

| Keys | Action |
|------|--------|
| `Ctrl-a [` | Enter copy mode |
| `v` | Start selection |
| `Ctrl-v` | Toggle block/rectangle selection |
| `y` | Yank (copy) selection and exit |
| `q` | Exit copy mode without copying |

Mouse drag selects text but does **not** auto-copy. You must press `y` to yank.

### Alt Key Shortcuts (No Prefix)

These work instantly without pressing the prefix key:

| Keys | Action |
|------|--------|
| `Alt + h/j/k/l` | Switch panes (vim directions) |
| `Alt + 1-9` | Jump to window by number |

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
| **Alt Key Shortcuts** | Prefix-free pane and window switching |
| **Copy Mode** | Vim keybindings for copy mode |
| **Theme** | TokyoNight Moon color palette and status bar |

---

## Theme

The configuration uses the **TokyoNight Moon** color palette:

| Color | Hex | Usage |
|-------|-----|-------|
| Background | `#222436` | Status bar, window backgrounds |
| Foreground | `#c8d3f5` | Default text |
| Blue | `#82aaff` | Active pane border, window index, clock |
| Cyan | `#86e1fc` | Active window path, prefix-off indicator |
| Magenta | `#c099ff` | Checkmark icon, prefix-on indicator |
| Green | `#c3e88d` | Available for customization |
| Yellow | `#ffc777` | Available for customization |
| Red/Pink | `#ff757f` | Available for customization |
| Orange | `#ff9e64` | Available for customization |
| Gray | `#3a3f5a` | Inactive pane borders, status segments |
| Black | `#1b1d2b` | Dark backgrounds |

### Status Bar Layout

```
LEFT:  (empty — minimal look)
RIGHT: [ window name ] [ prefix indicator ] [ session name ]
```

- The prefix indicator changes color when `Ctrl-a` is pressed (cyan -> magenta).
- The active window shows its index, a checkmark, and the last two directories of the pane's path.

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
thm_blue="#7aa2f7"    # your accent color
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
