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

vim.api.nvim_create_autocmd('TextYankPost', {
   desc = 'Highlight when yanking (copying) text',
   group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
   callback = function()
      vim.highlight.on_yank()
   end,
})
