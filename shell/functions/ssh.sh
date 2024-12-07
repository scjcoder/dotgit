#!/usr/bin/env bash

# Generate a new SSH key with best practices
ssh-keygen-secure() {
    local name="$1"
    local comment="$2"
    
    if [ -z "$name" ] || [ -z "$comment" ]; then
        echo "Usage: ssh-keygen-secure <key-name> <comment/email>"
        return 1
    fi
    
    ssh-keygen -t ed25519 -C "$comment" -f "$HOME/.ssh/keys/$name" -a 100
    chmod 600 "$HOME/.ssh/keys/$name"
    chmod 644 "$HOME/.ssh/keys/$name.pub"
    
    echo "Key pair generated:"
    echo "Private key: $HOME/.ssh/keys/$name"
    echo "Public key:  $HOME/.ssh/keys/$name.pub"
}

# Copy SSH public key to clipboard
ssh-key-copy() {
    local key="$1"
    
    if [ -z "$key" ]; then
        echo "Usage: ssh-key-copy <key-name>"
        return 1
    fi
    
    if [ -f "$HOME/.ssh/keys/$key.pub" ]; then
        pbcopy < "$HOME/.ssh/keys/$key.pub"
        echo "Public key copied to clipboard"
    else
        echo "Key not found: $HOME/.ssh/keys/$key.pub"
        return 1
    fi
}

# List all SSH keys
ssh-keys-list() {
    echo "Available SSH keys:"
    for key in "$HOME/.ssh/keys"/*.pub; do
        if [ -f "$key" ]; then
            local keyname=$(basename "$key" .pub)
            local keytype=$(ssh-keygen -l -f "$key" | cut -d' ' -f2)
            local comment=$(ssh-keygen -l -f "$key" | cut -d' ' -f3-)
            printf "%-20s %-10s %s\n" "$keyname" "$keytype" "$comment"
        fi
    done
}

# Add key to SSH agent
ssh-key-add() {
    local key="$1"
    
    if [ -z "$key" ]; then
        echo "Usage: ssh-key-add <key-name>"
        return 1
    fi
    
    if [ -f "$HOME/.ssh/keys/$key" ]; then
        ssh-add --apple-use-keychain "$HOME/.ssh/keys/$key"
        echo "Key added to SSH agent with keychain integration"
    else
        echo "Key not found: $HOME/.ssh/keys/$key"
        return 1
    fi
}

# Test SSH connection
ssh-test() {
    local host="$1"
    
    if [ -z "$host" ]; then
        echo "Usage: ssh-test <hostname>"
        return 1
    fi
    
    echo "Testing SSH connection to $host..."
    ssh -T -o ConnectTimeout=5 -o BatchMode=yes "$host" 2>&1 || true
}
