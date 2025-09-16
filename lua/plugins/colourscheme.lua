return {
   'navarasu/onedark.nvim',
   -- "folke/tokyonight.nvim",
   lazy = false,
   priority = 1000,
   config = function()
      vim.cmd.colorscheme 'onedark'
   end,
}
