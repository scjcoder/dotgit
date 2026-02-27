#!/usr/bin/env bash

set -e

# Colors for output
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
BLUE=$(tput setaf 4)
YELLOW=$(tput setaf 3)
RESET=$(tput sgr0)

# Print with color
info() { echo "${BLUE}$1${RESET}"; }
success() { echo "${GREEN}$1${RESET}"; }
error() { echo "${RED}$1${RESET}"; }
warn() { echo "${YELLOW}$1${RESET}"; }

# Backup directory
BACKUP_DIR="$HOME/.dotfiles.backup.$(date +%Y%m%d%H%M%S)"
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Backup a file or directory
backup_if_exists() {
    local file="$1"
    if [ -e "$file" ]; then
        local backup_path="$BACKUP_DIR$(dirname "$file")"
        mkdir -p "$backup_path"
        mv "$file" "$backup_path/"
        success "Backed up $file to $backup_path/"
        return 0
    fi
    return 1
}

# Create symbolic link
create_symlink() {
    local source="$1"
    local target="$2"
    
    # Check if the source file exists
    if [ ! -e "$source" ]; then
        error "Source file $source does not exist"
        return 1
    fi
    
    # If target already exists and is a symlink
    if [ -L "$target" ]; then
        local current_source=$(readlink "$target")
        if [ "$current_source" = "$source" ]; then
            info "Link already exists: $target -> $source"
            return 0
        else
            backup_if_exists "$target"
        fi
    # If target exists as a regular file or directory
    elif [ -e "$target" ]; then
        warn "Existing file found: $target"
        backup_if_exists "$target"
    fi
    
    # Create parent directory if it doesn't exist
    mkdir -p "$(dirname "$target")"
    
    # Create the symlink
    ln -sf "$source" "$target"
    success "Created symlink: $target -> $source"
}

# Install Homebrew if not installed
setup_homebrew() {
    if ! command_exists brew; then
        info "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        info "Homebrew already installed"
    fi
}

# Install packages from Brewfile
install_packages() {
    info "Installing packages from Brewfile..."
    if [ -f "$DOTFILES_DIR/Brewfile" ]; then
        brew bundle --file="$DOTFILES_DIR/Brewfile"
    else
        error "Brewfile not found"
        return 1
    fi
}

# Setup shell configuration
setup_shell() {
    info "Setting up shell configuration..."
    
    # Backup existing shell configs
    backup_if_exists "$HOME/.zshrc"
    backup_if_exists "$HOME/.bashrc"
    backup_if_exists "$HOME/.bash_profile"
    
    # Create symlinks for shell configs
    create_symlink "$DOTFILES_DIR/shell/zshrc" "$HOME/.zshrc"
    
    # Source shell config in bash files if they don't exist
    for file in ".bashrc" ".bash_profile"; do
        if [ ! -f "$HOME/$file" ]; then
            echo "[ -f ~/.zshrc ] && source ~/.zshrc" > "$HOME/$file"
        fi
    done
}

# Setup AWS CLI configuration
setup_aws() {
    info "Setting up AWS CLI configuration..."
    
    # Backup existing AWS configs
    backup_if_exists "$HOME/.aws/config"
    
    # Create symlink for AWS config
    create_symlink "$DOTFILES_DIR/config/aws/config" "$HOME/.aws/config"
    
    # Handle credentials file specially
    if [ ! -f "$HOME/.aws/credentials" ]; then
        mkdir -p "$HOME/.aws"
        if [ -f "$DOTFILES_DIR/config/aws/credentials.example" ]; then
            cp "$DOTFILES_DIR/config/aws/credentials.example" "$HOME/.aws/credentials"
            chmod 600 "$HOME/.aws/credentials"
            warn "Created AWS credentials template at ~/.aws/credentials"
            warn "Please update with your actual credentials"
        fi
    else
        warn "AWS credentials file already exists at ~/.aws/credentials"
        warn "Please manually update if needed"
    fi
}

# Setup SSH configuration
setup_ssh() {
    info "Setting up SSH configuration..."
    
    # Create SSH directories with proper permissions
    mkdir -p "$HOME/.ssh/control"
    mkdir -p "$HOME/.ssh/keys"
    chmod 700 "$HOME/.ssh"
    chmod 700 "$HOME/.ssh/control"
    chmod 700 "$HOME/.ssh/keys"
    
    # Backup existing SSH config
    backup_if_exists "$HOME/.ssh/config"
    
    # Create symlink for SSH config
    create_symlink "$DOTFILES_DIR/config/ssh/config" "$HOME/.ssh/config"
    chmod 600 "$HOME/.ssh/config"
}

# Main installation
main() {
    info "Starting dotfiles installation..."
    
    # Create backup directory
    if [ ! -d "$BACKUP_DIR" ]; then
        mkdir -p "$BACKUP_DIR"
        info "Created backup directory: $BACKUP_DIR"
    fi
    
    # Run installation steps
    setup_homebrew
    install_packages
    setup_shell
    setup_aws
    setup_ssh
    
    # Check if we made any backups
    if [ -n "$(ls -A "$BACKUP_DIR" 2>/dev/null)" ]; then
        success "Installation complete! "
        warn "Existing configs were backed up to: $BACKUP_DIR"
        info "Review the backups and delete them if you don't need them:"
        info "  rm -rf $BACKUP_DIR"
    else
        success "Installation complete! "
        rmdir "$BACKUP_DIR"
    fi
    
    info "Please restart your shell or run: source ~/.zshrc"
}

# Run main installation
main "$@"
