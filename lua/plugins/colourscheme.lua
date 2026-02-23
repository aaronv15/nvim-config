return {
   -- { 'folke/tokyonight.nvim', lazy = false, priority = 1000 },
   -- { 'catppuccin/nvim', name = 'catppuccin', lazy = false, priority = 1000 },
   { 'navarasu/onedark.nvim', lazy = false, priority = 1000 },
   { 'sainnhe/edge', lazy = false, priority = 1000 },
   {
      -- local plugin, no repo needed
      dir = vim.fn.stdpath 'config' .. '/lua/colorsave',
      name = 'colorsave',
      lazy = false,
      priority = 999,
      config = function()
         require('colorsave').setup {
            light = {
               onedark = function()
                  vim.o.background = 'light'
                  require('onedark').setup { style = 'light' }
                  require('onedark').load()
               end,
               edge = function()
                  vim.o.background = 'light'
               end,
            },
            dark = {
               onedark = function()
                  vim.o.background = 'dark'
                  require('onedark').setup { style = 'dark' }
                  require('onedark').load()
               end,
               edge = function()
                  vim.o.background = 'dark'
               end,
            },
            def = {
               edge = function()
                  vim.o.background = 'dark'
               end,
            },
            def_col = 'edge',
         }
      end,
   },
}
