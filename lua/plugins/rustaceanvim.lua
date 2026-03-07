if true then
   return {}
else
   return {
      'mrcjkb/rustaceanvim',
      dependencies = {
         'mfussenegger/nvim-dap',
         dependencies = {
            {
               'jay-babu/mason-nvim-dap.nvim',
               dependencies = { 'mason-org/mason.nvim' },
               opts = {
                  ensure_installed = { 'codelldb' },
                  automatic_installation = true,
                  handlers = {},
               },
            },
         },
      },
      version = '^8', -- Recommended
      lazy = false, -- This plugin is already lazy
   }
end
