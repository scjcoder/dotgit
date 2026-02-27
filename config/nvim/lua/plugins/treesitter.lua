-- Treesitter: modern syntax highlighting and code understanding
-- Replaces old regex-based syntax highlighting
return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua", "vim", "vimdoc",
          "bash", "python", "javascript", "typescript",
          "json", "yaml", "toml", "markdown", "markdown_inline",
          "html", "css",
        },
        auto_install  = true,
        highlight     = { enable = true },
        indent        = { enable = true },
      })
    end,
  },
}
