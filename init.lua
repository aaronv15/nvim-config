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

-- Rebind Commands

vim.api.nvim_create_user_command(
   'Sessave',
   ':SessionSave',
   { desc = "Same as ':SessionSave'", force = false }
)
vim.api.nvim_create_user_command(
   'Sesres',
   ':SessionRestore',
   { desc = "Same as ':SessionRestore'", force = false }
)

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

require 'config.lazy'
