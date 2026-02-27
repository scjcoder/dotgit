-- Editing utilities: the "feels like vim but better" plugins
-- Mirrors: fugitive, surround, nerdcommenter, tabular, delimitMate, repeat
return {
  -- Git integration (same plugin as old fugitive — still the best)
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "Gdiffsplit", "Gread", "Gwrite", "Glog" },
    keys = {
      { "<leader>gs", ":Git<CR>",          desc = "Git status" },
      { "<leader>gc", ":Git commit<CR>",   desc = "Git commit" },
      { "<leader>gp", ":Git push<CR>",     desc = "Git push" },
      { "<leader>gl", ":Git log --oneline<CR>", desc = "Git log" },
      { "<leader>gd", ":Gdiffsplit<CR>",   desc = "Git diff" },
    },
  },

  -- Git signs in the gutter
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup({
        signs = {
          add    = { text = "▎" },
          change = { text = "▎" },
          delete = { text = "" },
        },
      })
    end,
  },

  -- Surround: cs"' to change surrounding quotes, ds" to delete, ysiw) to add
  -- Modern rewrite of old vim-surround
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = true,
  },

  -- Comments: gcc to toggle line, gc in visual mode (replaces nerdcommenter)
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    config = true,
  },

  -- Auto-close brackets/quotes (replaces delimitMate)
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },

  -- Alignment (replaces tabular)
  -- :EasyAlign <delimiter>  e.g. gaip= to align paragraph on =
  {
    "junegunn/vim-easy-align",
    keys = {
      { "ga", "<Plug>(EasyAlign)", mode = { "n", "x" }, desc = "Easy align" },
    },
  },

  -- Repeat: makes . work with plugin commands (replaces vim-repeat)
  { "tpope/vim-repeat", event = "VeryLazy" },

  -- Unimpaired: ]b ]q [b [q navigation (replaces vim-unimpaired)
  { "tpope/vim-unimpaired", event = "VeryLazy" },

  -- Better undo history visualization (replaces Gundo)
  {
    "mbbill/undotree",
    keys = {
      { "<F5>", ":UndotreeToggle<CR>", desc = "Toggle undo tree" },
    },
  },
}
