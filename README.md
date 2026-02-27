# dotgit

Sean C. Johnson's dotfiles for macOS. Managed with a standard git repo and symlinks.

Mirrored on [GitLab](https://gitlab.com/scj-configuration-repos/dotgit) and [GitHub](https://github.com/scjcoder/dotgit).

## What's included

- **Shell** — Clean zsh config with Starship prompt, no framework overhead
- **Aliases** — macOS-focused aliases and Terraform shortcuts
- **Neovim** — Lua config with lazy.nvim, LSP, Telescope, Treesitter
- **Git** — Sensible defaults, commit template, useful aliases
- **SSH** — Config with key management and connection multiplexing
- **AWS** — CLI config with region defaults
- **Homebrew** — Brewfile for consistent package installation

## Directory structure

```
dotgit/
├── .aliases              # Shell aliases (sourced by .zshrc)
├── .bash_profile         # Minimal bash config (macOS only)
├── .gitignore_global     # Global git ignores
├── .gitmessage           # Commit message template
├── .zshrc                # Zsh config (Homebrew, Starship, completions)
├── Brewfile              # Homebrew packages and VS Code extensions
├── install.sh            # Symlink installer
├── config/
│   ├── aws/              # AWS CLI config + credentials example
│   ├── git/              # ~/.gitconfig
│   ├── nvim/             # Neovim config (lazy.nvim, Lua)
│   │   └── lua/
│   │       ├── config/   # options.lua, keymaps.lua
│   │       └── plugins/  # one file per plugin group
│   ├── ssh/              # SSH config
│   └── tmux/             # Tmux config
└── docs/                 # Additional documentation
```

## Installation

```bash
git clone git@gitlab.com:scj-configuration-repos/dotgit.git ~/CODE/dotgit
cd ~/CODE/dotgit
./install.sh
```

The installer will:
1. Install Homebrew if missing
2. Run `brew bundle` to install all packages
3. Symlink all dotfiles into `$HOME`
4. Set up Neovim config at `~/.config/nvim`
5. Back up any existing files before overwriting

## Neovim plugins

| Plugin | Purpose | Replaces |
|--------|---------|---------|
| lazy.nvim | Plugin manager | pathogen |
| tokyonight | Colorscheme | solarized |
| nvim-tree | File tree | NERDTree |
| telescope.nvim | Fuzzy finder | command-t |
| lualine | Statusline | vim-airline |
| nvim-lspconfig + mason | LSP + auto-install servers | syntastic |
| nvim-cmp | Autocompletion | — |
| nvim-treesitter | Syntax highlighting | regex-based |
| vim-fugitive | Git integration | vim-fugitive |
| nvim-surround | Surround motions | vim-surround |
| Comment.nvim | Toggle comments | nerdcommenter |
| undotree | Undo history tree | Gundo |

## Key bindings (Neovim)

Leader key is `<Space>`.

| Key | Action |
|-----|--------|
| `<F2>` | Toggle file tree |
| `<F5>` | Toggle undo tree |
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | Find buffers |
| `<leader>gs` | Git status |
| `<leader>rn` | Rename symbol (LSP) |
| `K` | Hover docs (LSP) |
| `gd` | Go to definition (LSP) |

## Updating

```bash
cd ~/CODE/dotgit
git pull
brew bundle
```

Neovim plugins update via `:Lazy update`. LSP servers update via `:MasonUpdate`.

## License

MIT
