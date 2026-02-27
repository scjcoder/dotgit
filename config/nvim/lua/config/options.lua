-- Core editor options
-- Translated and modernized from vimrc (pathogen/vimscript era)

local opt = vim.opt

-- Line numbers
opt.number         = true
opt.relativenumber = true   -- relative line numbers for fast j/k jumps

-- Indentation (matches old shiftwidth=4, softtabstop=4, expandtab)
opt.shiftwidth     = 4
opt.softtabstop    = 4
opt.tabstop        = 4
opt.expandtab      = true
opt.autoindent     = true
opt.smartindent    = true

-- Search
opt.incsearch      = true   -- search as you type
opt.hlsearch       = true   -- highlight matches
opt.ignorecase     = true   -- case-insensitive search...
opt.smartcase      = true   -- ...unless uppercase is used

-- Wrapping
opt.wrap           = true
opt.linebreak      = true   -- wrap at word boundaries
opt.showbreak      = "↪ "  -- matches old showbreak setting

-- Scrolling (matches old scrolloff/sidescrolloff)
opt.scrolloff      = 8
opt.sidescrolloff  = 8

-- Command completion (matches old wildmode)
opt.wildmode       = "list:longest"
opt.wildmenu       = true

-- Buffers and files
opt.hidden         = true   -- hide buffers instead of closing
opt.backup         = false
opt.swapfile       = false
opt.undofile       = true   -- persistent undo (replaces old undodir setting)
opt.undodir        = vim.fn.stdpath("data") .. "/undo"

-- UI
opt.termguicolors  = true
opt.signcolumn     = "yes"  -- always show sign column (prevents layout shift)
opt.colorcolumn    = "120"  -- soft line length guide
opt.laststatus     = 3      -- global statusline (lualine handles this)
opt.splitbelow     = true   -- new horizontal splits go below
opt.splitright     = true   -- new vertical splits go right
opt.cursorline     = true   -- highlight current line

-- Performance
opt.updatetime     = 250    -- faster CursorHold events
opt.timeoutlen     = 500    -- faster which-key popup

-- Mouse
opt.mouse          = "a"

-- Misc
opt.formatoptions:remove("o")  -- don't continue comments on o/O
opt.history        = 1000
