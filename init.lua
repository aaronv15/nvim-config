vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.mouse = 'a'

vim.opt.showmode = false

vim.opt.breakindent = true
vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = 'yes'

vim.opt.updatetime = 250

vim.opt.timeoutlen = 300

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 8

vim.opt.wrap = true

vim.opt.undodir = os.getenv 'HOME' .. '/.vim/undodir'
vim.opt.undofile = true

-- My options
vim.opt.autochdir = false
vim.opt.colorcolumn = { 88 }
vim.opt.tabstop = 8
vim.opt.shiftwidth = 3
vim.opt.softtabstop = 3
vim.opt.expandtab = true

-- folding
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldcolumn = '0'
vim.opt.foldtext = ''
vim.opt.foldlevel = 99
vim.opt.foldnestmax = 3

-- for saving session
vim.o.sessionoptions =
   'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'

-- My keymaps
vim.keymap.set(
   'n',
   '<leader>pv',
   vim.cmd.Oil,
   { desc = ':Ex (But for oil, so vim.cmd.Oil)' }
)
vim.keymap.set(
   { 'n', 'v' },
   '<leader>cp',
   '"+p',
   { desc = 'Paste from system clipboard' }
)
vim.keymap.set({ 'n', 'v' }, '<leader>cy', '"+y', { desc = 'Copy to system clipboard' })
vim.keymap.set('n', '<leader>1', '1gt', { desc = 'Goto Tab 1' })
vim.keymap.set('n', '<leader>2', '2gt', { desc = 'Goto Tab 2' })
vim.keymap.set('n', '<leader>3', '3gt', { desc = 'Goto Tab 3' })
vim.keymap.set('n', '<leader>4', '4gt', { desc = 'Goto Tab 4' })
vim.keymap.set('n', '<leader>5', '5gt', { desc = 'Goto Tab 5' })
vim.keymap.set('n', '<leader>6', '6gt', { desc = 'Goto Tab 6' })
vim.keymap.set('n', '<leader>7', '7gt', { desc = 'Goto Tab 7' })
vim.keymap.set('n', '<leader>8', '8gt', { desc = 'Goto Tab 8' })
vim.keymap.set('n', '<leader>9', '9gt', { desc = 'Goto Tab 9' })
vim.keymap.set('n', '<leader>0', ':tablast<cr>', { desc = 'Goto last tab' })

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set(
   'n',
   '<leader>q',
   vim.diagnostic.setloclist,
   { desc = 'Open diagnostic [Q]uickfix list' }
)

-- local group = vim.api.nvim_create_augroup('DebugAutoCmd', { clear = false })
--
-- local events = {
--    'CursorHold',
--    'CursorMoved',
-- }
-- vim.api.nvim_create_autocmd(events, {
--    group = group,
--    callback = function(args)
--       print('Autocommand triggered:', args.event, 'File:', args.file or 'N/A')
--    end,
-- })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
   desc = 'Highlight when yanking (copying) text',
   group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
   callback = function()
      vim.highlight.on_yank()
   end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
   local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
   local out = vim.fn.system {
      'git',
      'clone',
      '--filter=blob:none',
      '--branch=stable',
      lazyrepo,
      lazypath,
   }
   if vim.v.shell_error ~= 0 then
      error('Error cloning lazy.nvim:\n' .. out)
   end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
   -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
   'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

   require 'ordered.plugins.whichkey',
   require 'ordered.plugins.telescope',
   require 'ordered.plugins.lazydev',
   require 'ordered.plugins.lspconfig',
   require 'ordered.plugins.autoformat',
   require 'ordered.plugins.autocomplete',
   require 'ordered.plugins.colourscheme',
   require 'ordered.plugins.other',
   require 'ordered.plugins.treesitter',
   require 'ordered.plugins.oil',

   -- The following comments only work if you have downloaded the kickstart repo, not just copy pasted the
   -- init.lua. If you want these files, they are in the repository, so you can just download them and
   -- place them in the correct locations.

   -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
   --
   --  Here are some example plugins that I've included in the Kickstart repository.
   --  Uncomment any of the lines below to enable them (you will need to restart nvim).
   --
   require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps
   require 'kickstart.plugins.autopairs',

   -- no longer using these
   -- require 'kickstart.plugins.debug',
   -- require 'kickstart.plugins.indent_line',
   -- require 'kickstart.plugins.lint',
   -- require 'kickstart.plugins.neo-tree',
   -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
   --    This is the easiest way to modularize your config.
   --
   --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
   { import = 'custom.plugins' },
   --
   -- For additional information with loading, sourcing and examples see `:help lazy.nvim-🔌-plugin-spec`
   -- Or use telescope!
   -- In normal mode type `<space>sh` then write `lazy.nvim-plugin`
   -- you can continue same window with `<space>sr` which resumes last telescope search
}, {
   ui = {
      -- If you are using a Nerd Font: set icons to an empty table which will use the
      -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
      icons = vim.g.have_nerd_font and {} or {
         cmd = '⌘',
         config = '🛠',
         event = '📅',
         ft = '📂',
         init = '⚙',
         keys = '🗝',
         plugin = '🔌',
         runtime = '💻',
         require = '🌙',
         source = '📄',
         start = '🚀',
         task = '📌',
         lazy = '💤 ',
      },
   },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
