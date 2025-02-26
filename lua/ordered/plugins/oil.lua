return {
   'stevearc/oil.nvim',
   ---@module 'oil'
   ---@type oil.SetupOpts
   opts = {
      default_file_explorer = true,
      columns = {
         'icon',
         'mtime',
         -- 'permissions',
         -- 'size',
      },
      view_options = {
         -- Show files and directories that start with "."
         show_hidden = true,
      },
      keymaps = {
         ['g?'] = { 'actions.show_help', mode = 'n' },
         ['<CR>'] = 'actions.select',
         ['<C-s>'] = { 'actions.select', opts = { vertical = true } },
         ['<C-h>'] = { 'actions.select', opts = { horizontal = true } },
         ['<C-t>'] = { 'actions.select', opts = { tab = true } },
         ['<C-p>'] = 'actions.preview',
         ['<C-c>'] = { 'actions.close', mode = 'n' },
         ['<C-l>'] = 'actions.refresh',
         ['-'] = { 'actions.parent', mode = 'n' },
         ['_'] = { 'actions.open_cwd', mode = 'n' },
         ['`'] = { 'actions.cd', mode = 'n' },
         ['~'] = { 'actions.cd', opts = { scope = 'tab' }, mode = 'n' },
         ['gs'] = { 'actions.change_sort', mode = 'n' },
         ['g.'] = { 'actions.toggle_hidden', mode = 'n' },
         ['g\\'] = { 'actions.toggle_trash', mode = 'n' },
      },
      -- Set to false to disable all of the above keymaps
      use_default_keymaps = true,
   },
   -- Optional dependencies
   -- dependencies = { { 'echasnovski/mini.icons', opts = {} } },
   -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
   -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
   lazy = false,
   -- config = function()
   --    print 'Hello :)'
   -- end,
}
