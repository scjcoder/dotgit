-- UI: statusline, file tree, icons, which-key popup
return {
  -- Statusline (replaces vim-airline)
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "tokyonight",
          component_separators = "|",
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { { "filename", path = 1 } },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      })
    end,
  },

  -- File tree (replaces NERDTree)
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<F2>", ":NvimTreeToggle<CR>", desc = "Toggle file tree" },
      { "<leader>e", ":NvimTreeFocus<CR>", desc = "Focus file tree" },
    },
    config = function()
      -- Disable netrw (nvim-tree replaces it)
      vim.g.loaded_netrw       = 1
      vim.g.loaded_netrwPlugin = 1
      require("nvim-tree").setup({
        view = { width = 40 },  -- matches old NERDTreeWinSize = 40
        renderer = { group_empty = true },
        filters = { dotfiles = false },
      })
    end,
  },

  -- Shows available keybindings in popup (very helpful when relearning)
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup()
    end,
  },

  -- Buffer tabs (replaces vim-bufferline/vim-airline tabline)
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("bufferline").setup()
    end,
  },
}
