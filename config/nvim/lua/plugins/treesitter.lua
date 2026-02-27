-- Treesitter: syntax highlighting using native nvim 0.11 API
-- nvim-treesitter dropped the .configs module; use vim.treesitter directly
return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local parsers = {
        "lua", "vim", "vimdoc",
        "bash", "python", "javascript", "typescript",
        "json", "yaml", "toml", "markdown", "markdown_inline",
        "html", "css",
      }

      -- Install missing parsers
      local install = require("nvim-treesitter.install")
      install.prefer_git = true
      for _, lang in ipairs(parsers) do
        pcall(function()
          require("nvim-treesitter.install").ensure_installed = parsers
        end)
      end

      -- Enable highlighting per filetype via autocommand
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(ev)
          pcall(vim.treesitter.start, ev.buf)
        end,
      })
    end,
  },
}
