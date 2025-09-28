-- Highlight todo, notes, etc in comments
return {
   'folke/todo-comments.nvim',
   event = 'VimEnter',
   dependencies = { 'nvim-lua/plenary.nvim' },
   opts = {
      signs = false,
      keywords = {
         AI = { icon = ' ', color = 'warning' },
      },
      highlight = {
         comments_only = false,
      },
   },
}
