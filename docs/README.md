# Dotfiles Documentation

## Overview

Welcome to the dotfiles documentation! This documentation set provides comprehensive information about the dotfiles management system, its components, and how to use them effectively.

## Table of Contents

1. [Getting Started](../README.md)
   - Installation
   - Quick Start
   - Basic Usage

2. [AWS Configuration](AWS.md)
   - Profile Management
   - Aliases and Functions
   - Security Best Practices
   - Troubleshooting

3. [SSH Configuration](SSH.md)
   - Key Management
   - Host Configurations
   - Security Settings
   - Common Tasks

4. [Shell Configuration](Shell.md)
   - ZSH Setup
   - Aliases and Functions
   - Performance Optimization
   - Customization

## Quick Links

- [Installation Script](../install.sh)
- [Homebrew Packages](../Brewfile)
- [Shell Configuration](../shell/)
- [AWS Configuration](../config/aws/)
- [SSH Configuration](../config/ssh/)

## Common Tasks

### First-Time Setup

```bash
git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

### Updating

```bash
cd ~/.dotfiles
git pull
./install.sh
```

### Adding Custom Configuration

1. Shell Aliases:
   ```bash
   vim shell/aliases/custom.sh
   ```

2. Shell Functions:
   ```bash
   vim shell/functions/custom.sh
   ```

3. SSH Configuration:
   ```bash
   vim config/ssh/config
   ```

## Getting Help

1. Check the relevant documentation section
2. Look for troubleshooting guides
3. Create an issue on GitHub

## Contributing

1. Fork the repository
2. Create your feature branch
3. Update documentation
4. Create a pull request

## Version History

- v1.0.0 - Initial release
  - Basic dotfiles management
  - AWS and SSH configuration
  - Shell customization

- v1.1.0 - Current version
  - Enhanced backup system
  - Improved documentation
  - Additional utilities

## License

This project is licensed under the MIT License - see the [LICENSE](../LICENSE) file for details.
