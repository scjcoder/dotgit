# Shell Configuration Guide

## Overview

This document covers the shell configuration and customization options included in the dotfiles setup.

## Directory Structure

```
shell/
├── aliases/           # Shell aliases
│   ├── aws.sh        # AWS-specific aliases
│   └── git.sh        # Git-specific aliases
├── functions/        # Shell functions
│   └── ssh.sh       # SSH-related functions
└── path/            # PATH modifications
```

## Shell Features

### ZSH Configuration

The setup uses ZSH as the primary shell with several enhancements:

1. **Prompt**
   - Starship prompt integration
   - Git status information
   - AWS profile indicator
   - Directory context

2. **Completions**
   - AWS CLI completions
   - Git completions
   - Homebrew completions
   - Custom completions

3. **Navigation**
   - Zoxide integration
   - Directory aliases
   - Jump marks

## Available Tools

### Command Line Tools

1. **Starship**
   - Modern, minimal prompt
   - Contextual information
   - Custom configurations

2. **Zoxide**
   - Smart directory jumping
   - Frecency-based navigation
   - Shell integration

3. **fzf**
   - Fuzzy finding
   - History search
   - File navigation

## Alias Categories

### AWS Aliases

```bash
alias awsp="aws configure list-profiles | fzf"
alias awswho="aws sts get-caller-identity"
alias ec2ls="aws ec2 describe-instances"
```

### Git Aliases

```bash
alias g="git"
alias gst="git status"
alias gco="git checkout"
alias gcp="git cherry-pick"
```

### Navigation Aliases

```bash
alias ..="cd .."
alias ...="cd ../.."
alias ll="ls -la"
alias l="ls -l"
```

## Shell Functions

### AWS Functions

```bash
aws-profile() {
    export AWS_PROFILE="$1"
}

aws-region() {
    export AWS_DEFAULT_REGION="$1"
}
```

### Git Functions

```bash
git-clean-branches() {
    git branch --merged | egrep -v "(^\*|master|main|dev)" | xargs git branch -d
}
```

## Customization

### Adding New Aliases

1. Create new alias file:
   ```bash
   touch shell/aliases/custom.sh
   ```

2. Add aliases:
   ```bash
   alias custom="command"
   ```

### Adding New Functions

1. Create new function file:
   ```bash
   touch shell/functions/custom.sh
   ```

2. Add functions:
   ```bash
   custom() {
       # Function code
   }
   ```

### Modifying PATH

1. Create new path file:
   ```bash
   touch shell/path/custom.sh
   ```

2. Add PATH modifications:
   ```bash
   export PATH="$PATH:/new/path"
   ```

## Integration Features

### AWS Integration

- Profile switching
- Region selection
- Cost monitoring
- Service shortcuts

### Git Integration

- Branch management
- Status information
- Workflow helpers
- Custom commands

### SSH Integration

- Key management
- Agent handling
- Connection testing
- Host configuration

## Performance Optimization

### Lazy Loading

```bash
# Lazy load nvm
lazy_load_nvm() {
    unset -f node npm nvm
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
}

node() {
    lazy_load_nvm
    node "$@"
}
```

### Startup Time

To profile shell startup:
```bash
time zsh -i -c exit
```

## Troubleshooting

### Common Issues

1. **Slow Shell Startup**
   ```bash
   # Enable zsh startup profiling
   zmodload zsh/zprof
   # ... use shell ...
   zprof
   ```

2. **Path Issues**
   ```bash
   # Print PATH
   echo $PATH | tr ':' '\n'
   
   # Check command location
   which command
   ```

3. **Function Conflicts**
   ```bash
   # Check if function exists
   type function_name
   
   # List all functions
   functions
   ```

### Debug Mode

Enable shell debug mode:
```bash
set -x  # Enable debugging
command
set +x  # Disable debugging
```

## Best Practices

1. **Organization**
   - Keep related aliases together
   - Use descriptive function names
   - Comment complex functions
   - Maintain consistent style

2. **Performance**
   - Use lazy loading
   - Minimize startup files
   - Profile regularly
   - Clean unused functions

3. **Security**
   - Check scripts before sourcing
   - Use environment variables
   - Protect sensitive data
   - Regular cleanup
