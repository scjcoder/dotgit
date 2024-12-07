# Modern Dotfiles

A modern, organized dotfiles setup for macOS development environment.

## Features

- 🚀 Modern shell setup with Starship prompt
- 📦 Automated package installation with Homebrew
- 🔒 Secure credential management
- 🛠 Development tools preconfigured
- 🎨 Clean and organized configuration structure

## Installation

```bash
# Clone this repository
git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# Run the installer
./install.sh
```

## What's Included

- **Shell**: Modern setup with Starship prompt and useful aliases
- **Package Management**: Brewfile for consistent tool installation
- **Git**: Sensible defaults and aliases
- **Terminal**: Alacritty configuration with modern features
- **Development**: Neovim, VS Code, and various development tools
- **Security**: GPG and SSH configurations

## Directory Structure

```
.
├── bin/               # Custom scripts
├── config/            # Application configurations
│   ├── git/          # Git configuration
│   ├── nvim/         # Neovim configuration
│   └── tmux/         # Tmux configuration
├── shell/            # Shell configurations
│   ├── aliases/      # Shell aliases
│   ├── functions/    # Shell functions
│   └── path/         # PATH modifications
├── Brewfile          # Homebrew dependencies
├── install.sh        # Installation script
└── README.md         # Documentation
```

## Updating

To update all tools and configurations:

```bash
cd ~/.dotfiles
brew bundle
./install.sh
```

## Contributing

Feel free to fork and contribute to this project. Pull requests are welcome!

## License

MIT License - feel free to use and modify as you see fit.
