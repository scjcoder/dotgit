-- Beancount: syntax highlighting, indentation, and commodity alignment
return {
  {
    "nathangrigg/vim-beancount",
    ft = "beancount",
    init = function()
      -- Point to the root ledger file for account completion via ^X^O
      -- (cmp-beancount handles this for insert-mode, this covers omni fallback)
      vim.g.beancount_root = vim.fn.expand("~/beancount/main.beancount")
    end,
    keys = {
      { "<leader>ba", ":AlignCommodity<CR>", ft = "beancount", desc = "Align commodity columns" },
    },
  },
}
