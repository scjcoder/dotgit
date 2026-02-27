# macOS zsh configuration
# Replaces oh-my-zsh boilerplate with a clean, fast setup

# ── Homebrew ──────────────────────────────────────────────────────────────────
eval "$(/opt/homebrew/bin/brew shellenv)"

# ── Path ──────────────────────────────────────────────────────────────────────
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# ── History ───────────────────────────────────────────────────────────────────
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
setopt APPEND_HISTORY

# ── Completion ────────────────────────────────────────────────────────────────
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'  # case-insensitive

# ── Editor ────────────────────────────────────────────────────────────────────
export EDITOR='nvim'
export VISUAL='nvim'

# ── AWS ───────────────────────────────────────────────────────────────────────
export AWS_DEFAULT_REGION="us-east-1"
export AWS_PAGER=""
complete -C "$(brew --prefix)/bin/aws_completer" aws 2>/dev/null

# ── Terraform ─────────────────────────────────────────────────────────────────
complete -C "$(brew --prefix)/bin/terraform" terraform 2>/dev/null

# ── SSH agent ─────────────────────────────────────────────────────────────────
if [ -z "$SSH_AUTH_SOCK" ]; then
  eval "$(ssh-agent -s)" > /dev/null
  ssh-add --apple-use-keychain ~/.ssh/keys/* 2>/dev/null
fi

# ── Aliases ───────────────────────────────────────────────────────────────────
[ -f "$HOME/.aliases" ] && source "$HOME/.aliases"

# ── Starship prompt ───────────────────────────────────────────────────────────
eval "$(starship init zsh)"
