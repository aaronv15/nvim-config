return {
   -- Main LSP Configuration
   'neovim/nvim-lspconfig',
   dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
   },
   config = function()
      -- I wrote this. For future reference
      ---@type { install: boolean, type: "'lsp'" | "'fmt'", name: string, mason_name: string?, config: vim.lsp.Config?}[]
      local tool_configs = {
         -- { type = 'lsp', name = 'ty' },
         {
            install = true,
            type = 'lsp',
            name = 'basedpyright',
            config = {
               settings = {
                  basedpyright = { analysis = { diagnosticMode = 'workspace' } },
               },
            },
         },
         {
            install = true,
            type = 'lsp',
            name = 'lua_ls',
            mason_name = 'lua-language-server',
         },
         { install = false, type = 'lsp', name = 'hls' },
         { install = false, type = 'lsp', name = 'rust_analyzer' },
         { install = true, type = 'lsp', name = 'gopls' },
         { install = true, type = 'lsp', name = 'jdtls' },
         { install = true, type = 'lsp', name = 'zls' },
         { install = true, type = 'lsp', name = 'clangd' },
         { install = true, type = 'fmt', name = 'stylua' },
         { install = true, type = 'fmt', name = 'clang-format' },
         { install = true, type = 'fmt', name = 'ruff' },
         { install = true, type = 'fmt', name = 'golangci-lint' },
         { install = true, type = 'fmt', name = 'codespell' },
         { install = true, type = 'fmt', name = 'prettierd' },
      }

      local ensure_installed = {}
      for _, val in ipairs(tool_configs) do
         if val.install then
            table.insert(ensure_installed, val.mason_name or val.name)
         end
      end

      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      -- check number of values in a table
      --
      for _, val in ipairs(tool_configs) do
         if val.config then
            vim.lsp.config(val.name, val.config)
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
