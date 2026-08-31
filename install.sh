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

brew install tmux starship

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
# Starship
# ------------------------------------------------------------

echo ""
echo "Setting up Starship..."

mkdir -p "$HOME/.config"

backup_if_exists "$HOME/.config/starship.toml"
ln -sfn \
    "$DOTFILES/starship/starship.toml" \
    "$HOME/.config/starship.toml"

# ------------------------------------------------------------
# zsh
# ------------------------------------------------------------

echo ""
echo "Setting up zsh..."

STARSHIP_LINE='eval "$(starship init zsh)"'

if ! grep -Fxq "$STARSHIP_LINE" "$HOME/.zshrc" 2>/dev/null; then
    echo "" >> "$HOME/.zshrc"
    echo "# Starship prompt" >> "$HOME/.zshrc"
    echo "$STARSHIP_LINE" >> "$HOME/.zshrc"
    echo "Added Starship to ~/.zshrc"
else
    echo "Starship already configured in ~/.zshrc"
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
echo "  Starship -> ~/.config/starship.toml"
echo ""
echo "Start your work session with:"
echo "  tmux new -s work"
echo ""