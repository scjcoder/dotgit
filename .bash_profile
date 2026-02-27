# macOS bash profile — minimal, defers to zsh
# Only used when bash is explicitly invoked (e.g. scripts, CI)

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Path
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# Editor
export EDITOR='nvim'
export VISUAL='nvim'

# Source aliases if present
[ -f "$HOME/.aliases" ] && source "$HOME/.aliases"
