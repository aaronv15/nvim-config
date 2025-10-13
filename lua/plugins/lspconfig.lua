return {
   -- Main LSP Configuration
   'neovim/nvim-lspconfig',
   dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
   },
   config = function()
      -- I wrote this. For future reference
      ---@type {type: "'lsp'" | "'fmt'", name: string, mason_name: string?, config: table?}[]
      local tool_configs = {
         -- { type = 'lsp', name = 'ty' },
         {
            type = 'lsp',
            name = 'basedpyright',
            config = {
               settings = {
                  basedpyright = { analysis = { diagnosticMode = 'workspace' } },
               },
            },
         },
         { type = 'lsp', name = 'lua_ls', mason_name = 'lua-language-server' },
         { type = 'lsp', name = 'gopls' },
         { type = 'lsp', name = 'jdtls' },
         { type = 'lsp', name = 'zls' },
         { type = 'lsp', name = 'clangd' },
         { type = 'fmt', name = 'stylua' },
         { type = 'fmt', name = 'clang-format' },
         { type = 'fmt', name = 'ruff' },
         { type = 'fmt', name = 'golangci-lint' },
         { type = 'fmt', name = 'codespell' },
         { type = 'fmt', name = 'prettierd' },
      }

      local ensure_installed = {}
      for _, val in ipairs(tool_configs) do
         table.insert(ensure_installed, val.mason_name or val.name)
      end

      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      -- check number of values in a table
      --
      for _, val in ipairs(tool_configs) do
         if val.config then
            vim.lsp.config(val.name, val)
         end
      end

      for _, val in ipairs(tool_configs) do
         if val.type == 'lsp' and not vim.g.lsp_disabled then
            vim.lsp.enable(val.name)
         end
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
