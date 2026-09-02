#!/bin/zsh

set -e

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

echo "Installing dotfiles..."

# Homebrew
if ! command -v brew >/dev/null 2>&1; then
    echo "Homebrew is not installed."
    echo "Install it from https://brew.sh"
    exit 1
fi

# Packages
brew install tmux fzf

# fzf shell integration
if ! grep -Fq '# >>> dotfiles fzf >>>' "$HOME/.zshrc" 2>/dev/null; then
    cat >> "$HOME/.zshrc" <<'EOF'

# >>> dotfiles fzf >>>
source "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh"
source "$(brew --prefix)/opt/fzf/shell/completion.zsh"
# <<< dotfiles fzf <<<
EOF
fi

# tmux config
if [ -e "$HOME/.tmux.conf" ] && [ ! -L "$HOME/.tmux.conf" ]; then
    mv "$HOME/.tmux.conf" "$HOME/.tmux.conf.backup.$(date +%Y%m%d-%H%M%S)"
fi

ln -sfn "$DOTFILES/tmux/tmux.conf" "$HOME/.tmux.conf"

# TPM
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm \
        "$HOME/.tmux/plugins/tpm"
fi

# Install tmux plugins
"$HOME/.tmux/plugins/tpm/bin/install_plugins"

echo ""
echo "Done."
echo ""
echo "Restart your terminal, then start tmux with:"
echo "  tmux new -s work"
echo ""