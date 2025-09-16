return {
   -- Main LSP Configuration
   'neovim/nvim-lspconfig',
   dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
   },
   config = function()
      local ensure_installed = {
         ['basedpyright'] = {},
         -- ['ty'] = {},
         ['lua_ls'] = {},
         ['gopls'] = {},
         ['jdtls'] = {},
         ['zls'] = {},
         ['clangd'] = {},
      }

      for key, _ in pairs(ensure_installed) do
         vim.lsp.enable(key)
      end

      vim.list_extend(ensure_installed, {
         'stylua', -- Lua
         'clang-format', -- C
         'ruff', -- Python
         'golangci-lint', -- Go
         'codespell', -- All
      })

      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      vim.diagnostic.config {
         severity_sort = true,
         float = { border = 'rounded', source = 'if_many' },
         underline = { severity = vim.diagnostic.severity.ERROR },
         signs = vim.g.have_nerd_font and {
            text = {
               [vim.diagnostic.severity.ERROR] = '󰅚 ',
               [vim.diagnostic.severity.WARN] = '󰀪 ',
               [vim.diagnostic.severity.INFO] = '󰋽 ',
               [vim.diagnostic.severity.HINT] = '󰌶 ',
            },
            3 or {},
            virtual_text = {
               source = 'if_many',
               spacing = 2,
               format = function(diagnostic)
                  local diagnostic_message = {
                     [vim.diagnostic.severity.ERROR] = diagnostic.message,
                     [vim.diagnostic.severity.WARN] = diagnostic.message,
                     [vim.diagnostic.severity.INFO] = diagnostic.message,
                     [vim.diagnostic.severity.HINT] = diagnostic.message,
                  }
                  return diagnostic_message[diagnostic.severity]
               end,
            },
         },
      }
   end,
}
