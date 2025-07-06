return {
   'folke/tokyonight.nvim',
   lazy = false,
   priority = 1000, -- Make sure to load this before all the other start plugins.
   config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('tokyonight').setup {
         style = 'night',
         styles = {
            comments = { italic = true }, -- Disable italics in comments
            keywords = { italic = false },
            sidebars = 'dark', -- style for sidebars, see below
            floats = 'darker', -- style for floating windows
         },
      }

      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.

      vim.cmd.colorscheme 'tokyonight-night'
   end,
}
