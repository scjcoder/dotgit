-- LSP: Language Server Protocol support
-- Provides go-to-definition, hover docs, diagnostics, formatting
return {
  -- LSP config manager
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSP servers
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
      -- Shows LSP loading status
      { "j-hui/fidget.nvim", opts = {} },
    },
    config = function()
      -- Setup mason first
      require("mason").setup()
      require("mason-lspconfig").setup({
        -- Auto-install these LSP servers (add more as needed)
        ensure_installed = {
          "lua_ls",    -- Lua (for editing this config)
          "bashls",    -- Bash/shell scripts
          "pyright",   -- Python
          "ts_ls",     -- TypeScript/JavaScript
        },
      })

      -- Shared on_attach: runs when LSP attaches to a buffer
      local on_attach = function(_, bufnr)
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
        end
        map("gd",  vim.lsp.buf.definition,      "Go to definition")
        map("gD",  vim.lsp.buf.declaration,     "Go to declaration")
        map("gr",  vim.lsp.buf.references,      "References")
        map("K",   vim.lsp.buf.hover,           "Hover docs")
        map("<leader>rn", vim.lsp.buf.rename,   "Rename symbol")
        map("<leader>ca", vim.lsp.buf.code_action, "Code action")
        map("<leader>f",  function() vim.lsp.buf.format({ async = true }) end, "Format file")
      end

      local capabilities = vim.lsp.protocol.make_client_capabilities()

      local servers = { "lua_ls", "bashls", "pyright", "ts_ls" }
      for _, server in ipairs(servers) do
        require("lspconfig")[server].setup({
          on_attach    = on_attach,
          capabilities = capabilities,
        })
      end
    end,
  },
}
