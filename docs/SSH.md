# SSH Configuration Guide

## Overview

This document covers the SSH configuration and utilities included in the dotfiles setup.

## Directory Structure

```
config/ssh/
├── config              # SSH configuration
└── keys/              # SSH keys directory
    └── README.md      # Key management documentation
```

## Configuration Features

### Global Settings

```ssh-config
Host *
    AddKeysToAgent yes
    UseKeychain yes
    IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
    ServerAliveInterval 60
    ServerAliveCountMax 30
    HashKnownHosts yes
```

- `AddKeysToAgent`: Automatically adds keys to SSH agent
- `UseKeychain`: Integrates with macOS keychain
- `IdentityAgent`: Uses 1Password SSH agent
- `ServerAliveInterval`: Keeps connections alive
- `HashKnownHosts`: Enhances security of known_hosts file

### Connection Multiplexing

```ssh-config
Host *
    ControlMaster auto
    ControlPath ~/.ssh/control/%r@%h:%p
    ControlPersist 600
```

- Reuses existing connections
- Improves connection speed
- Reduces authentication prompts

## Utility Functions

### Key Generation

```bash
ssh-keygen-secure github "your.email@example.com"
```

Features:
- Uses Ed25519 keys
- Applies secure key generation parameters
- Sets appropriate permissions
- Organizes keys in ~/.ssh/keys/

### Key Management

```bash
ssh-key-copy github     # Copy public key to clipboard
ssh-keys-list          # List all SSH keys
ssh-key-add github     # Add key to SSH agent
ssh-test hostname      # Test SSH connection
```

## Host Configurations

### GitHub Setup

```ssh-config
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/keys/github
    PreferredAuthentications publickey
```

### AWS EC2

```ssh-config
Host aws-*
    User ec2-user
    IdentityFile ~/.ssh/aws-%h
    StrictHostKeyChecking no
    UserKnownHostsFile /dev/null
```

### Development Servers

```ssh-config
Host dev
    HostName dev.example.com
    User developer
    IdentityFile ~/.ssh/keys/dev
    ForwardAgent yes
```

## Security Best Practices

1. **Key Management**
   - Use unique keys per service
   - Store private keys securely
   - Regular key rotation
   - Use strong key types (Ed25519)

2. **Agent Forwarding**
   - Only enable when needed
   - Disable for production servers
   - Use `ForwardAgent yes` selectively

3. **Known Hosts**
   - Keep known_hosts file
   - Use hashed hostnames
   - Verify new host fingerprints

## Common Tasks

### Creating a New Key

1. Generate the key:
   ```bash
   ssh-keygen-secure service "comment"
   ```

2. Add to SSH agent:
   ```bash
   ssh-key-add service
   ```

3. Copy public key:
   ```bash
   ssh-key-copy service
   ```

### Adding a New Host

1. Edit SSH config:
   ```bash
   vim ~/.ssh/config
   ```

2. Add host configuration:
   ```ssh-config
   Host alias
       HostName hostname
       User username
       IdentityFile ~/.ssh/keys/keyname
   ```

### Testing Connections

```bash
# Test specific host
ssh-test hostname

# Debug connection issues
ssh -vv hostname
```

## Troubleshooting

### Common Issues

1. **Permission Problems**
   ```bash
   chmod 700 ~/.ssh
   chmod 600 ~/.ssh/config
   chmod 600 ~/.ssh/keys/*
   ```

2. **Agent Issues**
   ```bash
   ssh-add -l  # List keys in agent
   ssh-add -D  # Clear all keys
   ```

3. **Connection Problems**
   ```bash
   # Enable verbose output
   ssh -vv hostname
   
   # Check known_hosts
   ssh-keygen -F hostname
   
   # Clear known_hosts entry
   ssh-keygen -R hostname
   ```

### Debug Mode

For detailed connection information:
```bash
ssh -vv hostname
```

## Integration with 1Password

1. **Setup**
   - Install 1Password SSH agent
   - Configure IdentityAgent in SSH config
   - Add keys to 1Password

2. **Usage**
   ```bash
   # Add key to 1Password
   op item create --category sshkey --title "Key Name"
   
   # Use key from 1Password
   ssh -i op://vault/item/field hostname
   ```
