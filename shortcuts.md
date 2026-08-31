# Terminal Shortcuts

## Mental Model

```text
WezTerm
  └── tmux
       └── session
            ├── window = tab
            │    ├── pane
            │    └── pane
            ├── window
            └── window
```

---

# WezTerm

| Shortcut | Action |
|---|---|
| `Cmd + T` | New WezTerm tab |
| `Cmd + W` | Close WezTerm tab |
| `Cmd + K` | Clear current terminal/tmux pane |
| `Cmd + F` | Search terminal output |
| `Cmd + +` | Increase font size |
| `Cmd + -` | Decrease font size |
| `Cmd + 0` | Reset font size |

Normal mouse drag inside tmux:

**Select → automatically copied to macOS clipboard**

No `Cmd-C` required.

---

# tmux

## Prefix

```text
Ctrl + A
```

Press `Ctrl-A`, release, then press the next key.

## Sessions

| Shortcut / Command | Action |
|---|---|
| `Ctrl-A s` | Switch session |
| `Ctrl-A d` | Detach |
| `tmux ls` | List sessions |
| `tmux new -s work` | Create `work` session |
| `tmux attach -t work` | Attach to `work` |

## Windows

Windows are like browser tabs.

| Shortcut | Action |
|---|---|
| `Ctrl-A c` | New window |
| `Ctrl-A n` | Next window |
| `Ctrl-A p` | Previous window |
| `Ctrl-A 1` | Go to window 1 |
| `Ctrl-A 2` | Go to window 2 |
| `Ctrl-A ,` | Rename current window |

## Panes

| Shortcut | Action |
|---|---|
| `Ctrl-A %` | Vertical split |
| `Ctrl-A "` | Horizontal split |
| Mouse click | Switch pane |
| Mouse drag | Resize pane |

## Copy

Normal mouse drag:

**Select → automatically copied to macOS clipboard**

Then:

`Cmd + V`

## Persistence

| Shortcut | Action |
|---|---|
| `Ctrl-A Ctrl-S` | Resurrect: save environment |
| `Ctrl-A Ctrl-R` | Resurrect: restore environment |

Continuum automatically saves the tmux environment periodically.

---

# Useful Commands

```bash
tmux ls
```

List tmux sessions.

```bash
tmux attach -t work
```

Attach to the `work` session.

```bash
tmux source-file ~/.tmux.conf
```

Reload tmux configuration.

```bash
echo $TMUX
```

Check whether you are inside tmux.