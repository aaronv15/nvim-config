return {
   'nvim-telescope/telescope.nvim',
   tag = '0.1.8',
   dependencies = {
      'nvim-lua/plenary.nvim',
      -- Nice file icons in search
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
   },
   config = function()
      -- Why do we do this? I have no clue. Go look at this: https://www.youtube.com/watch?v=xdXE1tOT-qg
      -- By TJ
      require('telescope').setup {
         pickers = {
            -- live_grep = {theme = "ivy"},
            -- grep_string = {theme = "cursor"},
            -- find_files = {theme = "dropdown"},
         },
      }

      local map = function(keys, func, desc, mode)
         mode = mode or 'n'
         vim.keymap.set(mode, keys, func, { desc = desc .. ' (Telescope)' })
      end

      local builtin = require 'telescope.builtin'
      map('<leader>sf', builtin.find_files, '[S]earch [F]iles')
      map('<leader>sg', builtin.live_grep, '[S]earch by [G]rep')
      map('<leader>sb', builtin.buffers, '[S]earch [B]uffers')
      map('<leader>sh', builtin.help_tags, '[S]earch [H]elp')
      map('<leader>sw', builtin.grep_string, '[S]earch current [W]ord')
      map('<leader>sc', builtin.colorscheme, '[S]earch [C]olorscheme')
      -- This hooks in to the nvim lsp. 'bufnr' specifies that it is only searching the current buffer
      map('<leader>sd', function()
         builtin.diagnostics { bufnr = 0 }
      end, 'Telescope [S]earch [D]iagnostics')

      map('<leader>sr', builtin.lsp_references, 'Telescope [S]earch [R]eferences')

      -- These I believe are now builtin as gd, and gD respectively
      -- Adding to this later: They are not. I think they are in-file only
      map('<leader>gd', builtin.lsp_definitions, '[G]oto [D]efinition')
      map('<leader>gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

      -- map('<leader>sk', builtin.keymaps, '[S]earch [K]eymaps')
      -- map('<leader>ss', builtin.builtin, '[S]earch [S]elect Telescope')
      -- map('<leader>sd', builtin.diagnostics, '[S]earch [D]iagnostics')
      -- map('<leader>sr', builtin.resume, '[S]earch [R]esume')
      -- map('<leader>s.', builtin.oldfiles, '[S]earch Recent Files ("." for repeat)')
   end,
}
