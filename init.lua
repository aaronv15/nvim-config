-- Set to disable lsp's
-- vim.g.lsp_disabled

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

vim.opt.timeout = false

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
vim.opt.fillchars = { fold = '-', foldopen = 'v', foldsep = '|', foldclose = '>' }

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
-- Treesitter based folding
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldcolumn = '1'
vim.opt.foldtext = ''
vim.opt.foldlevel = 99
vim.opt.foldnestmax = 3

-- for saving session
vim.o.sessionoptions = 'tabpages,curdir,options'

-- set winborder
vim.o.winborder = 'rounded'

-- My keymaps
local map_opts_oil = { desc = ':Ex (But for oil, so vim.cmd.Oil)' }
local map_opts_paste = { desc = '[P]aste from system [C]lipboard' }
local map_opts_yank = { desc = '[Y]ank to system [C]lipboard' }

vim.keymap.set('n', '<leader>v', vim.cmd.Oil, map_opts_oil)
vim.keymap.set({ 'n', 'v' }, '<leader>cp', '"+p', map_opts_paste)
vim.keymap.set({ 'n', 'v' }, '<leader>cP', '"+P', map_opts_paste)
vim.keymap.set({ 'n', 'v' }, '<leader>cy', '"+y', map_opts_yank)
vim.keymap.set({ 'n', 'v' }, '<leader>cY', '"+y$', map_opts_yank)
vim.keymap.set('n', '<leader>1', '1gt', { desc = 'Goto Tab [1]' })
vim.keymap.set('n', '<leader>2', '2gt', { desc = 'Goto Tab [2]' })
vim.keymap.set('n', '<leader>3', '3gt', { desc = 'Goto Tab [3]' })
vim.keymap.set('n', '<leader>4', '4gt', { desc = 'Goto Tab [4]' })
vim.keymap.set('n', '<leader>5', '5gt', { desc = 'Goto Tab [5]' })
vim.keymap.set('n', '<leader>6', '6gt', { desc = 'Goto Tab [6]' })
vim.keymap.set('n', '<leader>7', '7gt', { desc = 'Goto Tab [7]' })
vim.keymap.set('n', '<leader>8', '8gt', { desc = 'Goto Tab [8]' })
vim.keymap.set('n', '<leader>9', '9gt', { desc = 'Goto Tab [9]' })
vim.keymap.set('n', '<leader>0', '<cmd>tablast<CR>', { desc = 'Goto last tab' })

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set(
   'n',
   '<leader>q',
   vim.diagnostic.setloclist,
   { desc = 'Open diagnostic [Q]uickfix list' }
)

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Rebind Commands

vim.api.nvim_create_user_command(
   'Ssave',
   'AutoSession save',
   { desc = "Same as 'AutoSession save", force = false }
)

vim.api.nvim_create_user_command('Wsave', function()
   vim.cmd 'AutoSession save'
   vim.cmd 'wqa'
end, { desc = "Same as 'AutoSession save", force = false })

vim.api.nvim_create_user_command(
   'Sres',
   'AutoSession restore',
   { desc = "Same as 'AutoSession restore'", force = false }
)

vim.api.nvim_create_autocmd('TextYankPost', {
   desc = 'Highlight when yanking (copying) text',
   group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
   callback = function()
      vim.hl.on_yank()
   end,
})

-- Enable spellchecking
vim.api.nvim_create_user_command(
   'Spell',
   'set spell spelllang=en_us',
   { desc = 'set spellcheck on', force = false }
)
vim.api.nvim_create_user_command(
   'Spellnt',
   'set spell!',
   { desc = 'set spellcheck off', force = false }
)

-- Open new tab and search for a file
vim.api.nvim_create_user_command('Ntab', function()
   vim.cmd 'tabnew'
   vim.cmd 'Telescope find_files'
end, {
   desc = 'create a new tab, and then open the Telescope find_files picker',
   force = false,
})

-- Set various configs
vim.diagnostic.config {
   virtual_text = true,
   signs = true,
   underline = true,
   update_in_insert = false,
   severity_sort = true,
}

-- Autocommands
vim.api.nvim_create_autocmd('LspAttach', {
   callback = function(args) -- Prefer LSP folding if client supports it
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client:supports_method 'textDocument/foldingRange' then
         local win = vim.api.nvim_get_current_win()
         vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
      end
   end,
})

-- Bootstrap lazy.nvim
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
      vim.api.nvim_echo({
         { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
         { out, 'WarningMsg' },
         { '\nPress any key to exit...' },
      }, true, {})
      vim.fn.getchar()
      os.exit(1)
   end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require('lazy').setup {
   opts = require 'config.lazy',
   spec = {
      -- import your plugins
      { import = 'plugins' },
   },
   change_detection = { notify = false },
   -- Configure any other settings here. See the documentation for more details.
   -- colorscheme that will be used when installing plugins.
   -- install = { colorscheme = { 'blue' } },
   -- automatically check for plugin updates
   -- checker = { enabled = true },
}

-- Disable some messages

-- Disable the deprecated telescope 'goto definition'
-- Silence the specific position encoding message
local notify_original = vim.notify
vim.notify = function(msg, ...)
   if
      msg
      and (
         msg:match 'position_encoding param is required'
         or msg:match 'Defaulting to position encoding of the first client'
         or msg:match 'multiple different client offset_encodings'
      )
   then
      return
   end
   return notify_original(msg, ...)
end

-- vim: ts=2 sts=2 sw=2 et
