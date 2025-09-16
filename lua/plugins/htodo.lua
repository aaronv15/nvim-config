-- Highlight todo, notes, etc in comments
return 1 and {}
   or {
      'folke/todo-comments.nvim',
      event = 'VimEnter',
      dependencies = { 'nvim-lua/plenary.nvim' },
      opts = { signs = false },
   }
