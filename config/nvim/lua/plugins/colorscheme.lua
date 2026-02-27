-- Colorscheme: tokyonight (modern, well-maintained, works great in terminal)
return {
  {
    "folke/tokyonight.nvim",
    lazy = false,    -- load at startup
    priority = 1000, -- load before other plugins
    config = function()
      require("tokyonight").setup({
        style = "night",
        transparent = false,
        terminal_colors = true,
      })
      vim.cmd("colorscheme tokyonight-night")
    end,
  },
}
