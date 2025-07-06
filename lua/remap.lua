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
