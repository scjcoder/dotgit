#!/usr/bin/env bash
# install.sh — symlink dotfiles into place
# Usage: ./install.sh

set -e

RED=$(tput setaf 1); GREEN=$(tput setaf 2)
BLUE=$(tput setaf 4); YELLOW=$(tput setaf 3); RESET=$(tput sgr0)

info()    { echo "${BLUE}$1${RESET}"; }
success() { echo "${GREEN}$1${RESET}"; }
error()   { echo "${RED}$1${RESET}"; }
warn()    { echo "${YELLOW}$1${RESET}"; }

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BACKUP_DIR="$HOME/.dotfiles.backup.$(date +%Y%m%d%H%M%S)"

command_exists() { command -v "$1" >/dev/null 2>&1; }

backup_if_exists() {
    local file="$1"
    [ -e "$file" ] || return 0
    local dest="$BACKUP_DIR$(dirname "$file")"
    mkdir -p "$dest"
    mv "$file" "$dest/"
    success "Backed up $file"
}

create_symlink() {
    local src="$1" tgt="$2"
    if [ ! -e "$src" ]; then
        error "Source missing: $src"
        return 1
    fi
    if [ -L "$tgt" ] && [ "$(readlink "$tgt")" = "$src" ]; then
        info "Already linked: $tgt"
        return 0
    fi
    [ -e "$tgt" ] && backup_if_exists "$tgt"
    mkdir -p "$(dirname "$tgt")"
    ln -sf "$src" "$tgt"
    success "Linked: $tgt -> $src"
}

setup_homebrew() {
    if ! command_exists brew; then
        info "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    eval "$(/opt/homebrew/bin/brew shellenv)"
}

install_packages() {
    info "Installing packages from Brewfile..."
    brew bundle --file="$DOTFILES_DIR/Brewfile"
}

setup_shell() {
    info "Setting up shell config..."
    # Root-level dotfiles
    create_symlink "$DOTFILES_DIR/.zshrc"         "$HOME/.zshrc"
    create_symlink "$DOTFILES_DIR/.bash_profile"  "$HOME/.bash_profile"
    create_symlink "$DOTFILES_DIR/.aliases"       "$HOME/.aliases"
    create_symlink "$DOTFILES_DIR/.gitmessage"    "$HOME/.gitmessage"
    create_symlink "$DOTFILES_DIR/.gitignore_global" "$HOME/.gitignore_global"
}

setup_git() {
    info "Setting up git config..."
    create_symlink "$DOTFILES_DIR/config/git/config" "$HOME/.gitconfig"
}

setup_aws() {
    info "Setting up AWS config..."
    create_symlink "$DOTFILES_DIR/config/aws/config" "$HOME/.aws/config"
    if [ ! -f "$HOME/.aws/credentials" ]; then
        mkdir -p "$HOME/.aws"
        cp "$DOTFILES_DIR/config/aws/credentials.example" "$HOME/.aws/credentials"
        chmod 600 "$HOME/.aws/credentials"
        warn "Created ~/.aws/credentials from example — update with real credentials"
    fi
}

setup_ssh() {
    info "Setting up SSH config..."
    mkdir -p "$HOME/.ssh/control" "$HOME/.ssh/keys"
    chmod 700 "$HOME/.ssh" "$HOME/.ssh/control" "$HOME/.ssh/keys"
    create_symlink "$DOTFILES_DIR/config/ssh/config" "$HOME/.ssh/config"
    chmod 600 "$HOME/.ssh/config"
}

setup_nvim() {
    info "Setting up Neovim config..."
    create_symlink "$DOTFILES_DIR/config/nvim" "$HOME/.config/nvim"
}

setup_starship() {
    info "Setting up Starship config..."
    create_symlink "$DOTFILES_DIR/.config/starship.toml" "$HOME/.config/starship.toml"
}

main() {
    info "Starting dotfiles install from $DOTFILES_DIR"
    mkdir -p "$BACKUP_DIR"

    setup_homebrew
    install_packages
    setup_shell
    setup_git
    setup_aws
    setup_ssh
    setup_nvim
    setup_starship

    if [ -n "$(ls -A "$BACKUP_DIR" 2>/dev/null)" ]; then
        warn "Backups saved to: $BACKUP_DIR"
    else
        rmdir "$BACKUP_DIR"
    fi

    success "Done! Restart your shell or run: source ~/.zshrc"
}

main "$@"
