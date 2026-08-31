# macOS Developer Dotfiles

My personal macOS terminal setup for development.

## Stack

- WezTerm — terminal emulator
- zsh — shell
- tmux — terminal workspace manager
- tmux-resurrect — save and restore tmux sessions
- tmux-continuum — automatically save tmux sessions
- Starship — minimal shell prompt

## Structure

```text
dotfiles/
├── wezterm/
│   └── wezterm.lua
├── tmux/
│   └── tmux.conf
├── starship/
│   └── starship.toml
├── shortcuts.md
└── README.md
```

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

### Sessions

Use sessions for completely separate environments.

Example:

```text
work
personal
```

### Windows

Think of windows as browser tabs.

Example:

```text
work
├── 1: claude
├── 2: dev
└── 3: debug
```

### Panes

Use panes when you want multiple terminals visible at the same time.

## Current Setup

The setup intentionally stays minimal.

More tools such as fzf and zoxide will be added only when they provide a useful workflow improvement.

## Installation

### Requirements

- macOS
- Homebrew
- Git

### Install

Clone the repository:

```bash
git clone git@github.com:YOUR_USERNAME/dotfiles.git ~/dotfiles