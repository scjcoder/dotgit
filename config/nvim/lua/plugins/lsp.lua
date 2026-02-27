-- LSP: Language Server Protocol support
-- Provides go-to-definition, hover docs, diagnostics, formatting
-- Uses native vim.lsp.config API (nvim 0.11+), no lspconfig framework needed
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
      { "j-hui/fidget.nvim", opts = {} },
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",   -- Lua (for editing this config)
          "bashls",   -- Bash/shell scripts
          "pyright",  -- Python
          "ts_ls",    -- TypeScript/JavaScript
        },
      })

      -- Keymaps applied when any LSP attaches to a buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end
          map("gd",         vim.lsp.buf.definition,                              "Go to definition")
          map("gD",         vim.lsp.buf.declaration,                             "Go to declaration")
          map("gr",         vim.lsp.buf.references,                              "References")
          map("K",          vim.lsp.buf.hover,                                   "Hover docs")
          map("<leader>rn", vim.lsp.buf.rename,                                  "Rename symbol")
          map("<leader>ca", vim.lsp.buf.code_action,                             "Code action")
          map("<leader>f",  function() vim.lsp.buf.format({ async = true }) end, "Format file")
        end,
      })

      -- Configure and enable each server using native nvim 0.11 API
      local servers = { "lua_ls", "bashls", "pyright", "ts_ls" }
      for _, server in ipairs(servers) do
        vim.lsp.config(server, {
          capabilities = vim.lsp.protocol.make_client_capabilities(),
        })
        vim.lsp.enable(server)
      end
    end,
  },
}
