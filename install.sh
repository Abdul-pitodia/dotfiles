#!/bin/zsh

set -e

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

echo ""
echo "======================================"
echo "  macOS Developer Dotfiles"
echo "======================================"
echo ""

# ------------------------------------------------------------
# Helpers
# ------------------------------------------------------------

backup_if_exists() {
    local target="$1"

    if [ -e "$target" ] && [ ! -L "$target" ]; then
        local backup="${target}.backup.$(date +%Y%m%d-%H%M%S)"
        echo "Backing up $target -> $backup"
        mv "$target" "$backup"
    fi
}

# ------------------------------------------------------------
# Homebrew
# ------------------------------------------------------------

if ! command -v brew >/dev/null 2>&1; then
    echo "Homebrew is not installed."
    echo "Install Homebrew first from:"
    echo "https://brew.sh"
    exit 1
fi

echo "Installing required packages..."

brew install tmux powerlevel10k

# WezTerm is a GUI application, so install it as a cask.
if ! brew list --cask wezterm >/dev/null 2>&1; then
    brew install --cask wezterm
fi

# ------------------------------------------------------------
# WezTerm
# ------------------------------------------------------------

echo ""
echo "Setting up WezTerm..."

backup_if_exists "$HOME/.wezterm.lua"
ln -sfn "$DOTFILES/wezterm/wezterm.lua" "$HOME/.wezterm.lua"

# ------------------------------------------------------------
# tmux
# ------------------------------------------------------------

echo ""
echo "Setting up tmux..."

backup_if_exists "$HOME/.tmux.conf"
ln -sfn "$DOTFILES/tmux/tmux.conf" "$HOME/.tmux.conf"

# ------------------------------------------------------------
# TPM
# ------------------------------------------------------------

echo ""
echo "Setting up TPM..."

if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm \
        "$HOME/.tmux/plugins/tpm"
else
    echo "TPM already installed."
fi

# Install plugins declared in tmux.conf
"$HOME/.tmux/plugins/tpm/bin/install_plugins"

# ------------------------------------------------------------
# Powerlevel10k
# ------------------------------------------------------------

echo ""
echo "Setting up Powerlevel10k..."

if ! brew list powerlevel10k >/dev/null 2>&1; then
    brew install powerlevel10k
else
    echo "Powerlevel10k already installed."
fi

backup_if_exists "$HOME/.p10k.zsh"
ln -sfn "$DOTFILES/p10k/p10k.zsh" "$HOME/.p10k.zsh"

# ------------------------------------------------------------
# zsh
# ------------------------------------------------------------

echo ""
echo "Setting up zsh..."

if ! grep -Fq "powerlevel10k/share/powerlevel10k/powerlevel10k.zsh-theme" "$HOME/.zshrc" 2>/dev/null; then
    cat >> "$HOME/.zshrc" <<'EOF'

# >>> dotfiles Powerlevel10k >>>
source "$(brew --prefix)/opt/powerlevel10k/share/powerlevel10k/powerlevel10k.zsh-theme"
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# <<< dotfiles Powerlevel10k <<<
EOF

    echo "Added Powerlevel10k to ~/.zshrc"
else
    echo "Powerlevel10k already configured in ~/.zshrc"
fi

# ------------------------------------------------------------
# Done
# ------------------------------------------------------------

echo ""
echo "======================================"
echo "  Installation complete!"
echo "======================================"
echo ""
echo "Restart WezTerm to apply everything."
echo ""
echo "Your configs:"
echo "  WezTerm  -> ~/.wezterm.lua"
echo "  tmux     -> ~/.tmux.conf"
echo "  Powerlevel10k -> ~/.p10k.zsh"
echo ""
echo "Start your work session with:"
echo "  tmux new -s work"
echo ""