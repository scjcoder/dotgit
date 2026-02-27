-- Key mappings
-- Mirrors useful bindings from old vimrc, updated for Neovim idioms

local map = vim.keymap.set

-- Leader key (set before plugins load in init.lua)
vim.g.mapleader      = " "
vim.g.maplocalleader = " "

-- Clear search highlight (replaces old <C-L> mapping)
map("n", "<leader>h", ":nohls<CR>", { desc = "Clear search highlight" })

-- Space toggles fold (from old vimrc)
map("n", "<Space>", "@=(foldlevel('.')?'za':\"\\<Space>\")<CR>", { silent = true, desc = "Toggle fold" })

-- Make Y consistent with C and D (from old vimrc)
map("n", "Y", "y$", { desc = "Yank to end of line" })

-- Better window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Buffer navigation
map("n", "<leader>bn", ":bnext<CR>",     { desc = "Next buffer" })
map("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })
map("n", "<leader>bd", ":bdelete<CR>",   { desc = "Delete buffer" })

-- Save / quit shortcuts
map("n", "<leader>w", ":write<CR>",  { desc = "Save file" })
map("n", "<leader>q", ":quit<CR>",   { desc = "Quit" })

-- Indent without losing selection in visual mode
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Jump to last cursor position when opening a file (from old vimrc SetCursorPosition)
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local ft = vim.bo.filetype
    if ft ~= "svn" and ft:lower() ~= "commit" then
      local mark = vim.api.nvim_buf_get_mark(0, '"')
      local line_count = vim.api.nvim_buf_line_count(0)
      if mark[1] > 0 and mark[1] <= line_count then
        vim.api.nvim_win_set_cursor(0, mark)
        vim.cmd("normal! zz")
      end
    end
  end,
})

-- Spell check in commit messages (from old vimrc)
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "svn", "gitcommit" },
  callback = function()
    vim.opt_local.spell = true
  end,
})
