return {
   -- Main LSP Configuration
   'neovim/nvim-lspconfig',
   dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
   },
   config = function()
      local lsp_configs = {
         ['basedpyright'] = {
            settings = {
               basedpyright = {
                  analysis = {
                     diagnosticMode = 'workspace',
                  },
               },
            },
         },
         -- ['ty'] = {},
         ['lua-language-server'] = {},
         ['gopls'] = {},
         ['jdtls'] = {},
         ['zls'] = {},
         ['clangd'] = {},
      }

      local ensure_installed = {
         'stylua', -- Lua
         'clang-format', -- C
         'ruff', -- Python
         'golangci-lint', -- Go
         'codespell', -- All
         'prettierd',
      }

      for key, _ in pairs(lsp_configs) do
         table.insert(ensure_installed, key)
      end

      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      -- check number of values in a table
      local table_is_empty = function(t)
         for _ in pairs(t) do
            return false
         end
         return true
      end

      for key, value in pairs(lsp_configs) do
         if not table_is_empty(value) then
            vim.lsp.config(key, value)
         end
      end

      for key, _ in pairs(lsp_configs) do
         vim.lsp.enable(key)
      end

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
