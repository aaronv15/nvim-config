local function get_rust_bin()
   vim.fn.system 'cargo build --target debug'
   -- get cargo metadata
   local metadata = vim.fn.system 'cargo metadata --no-deps --format-version 1'
   local ok, decoded = pcall(vim.json.decode, metadata)

   if not ok then
      error 'Failed to parse cargo metadata'
   end

   local bins = {}

   for _, pkg in ipairs(decoded.packages) do
      for _, target in ipairs(pkg.targets) do
         if vim.tbl_contains(target.kind, 'bin') then
            table.insert(bins, target.name)
         end
      end
   end

   if #bins == 0 then
      error 'No binary targets found'
   end

   -- if only one binary, use it directly
   if #bins == 1 then
      return vim.fn.getcwd() .. '/target/debug/' .. bins[1]
   end

   -- otherwise prompt
   return vim.fn.getcwd()
      .. '/target/debug/'
      .. vim.fn.inputlist(vim.tbl_flatten { 'Select binary:', bins })
end

if false then
   return {}
else
   return {
      'rcarriga/nvim-dap-ui',
      dependencies = {
         'nvim-neotest/nvim-nio',
         {
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
               {
                  'theHamsta/nvim-dap-virtual-text',
                  opts = {
                     enabled = true, -- enable this plugin (the default)
                     enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
                     highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
                     highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
                     show_stop_reason = true, -- show stop reason when stopped for exceptions
                     commented = false, -- prefix virtual text with comment string
                     only_first_definition = false, -- only show virtual text at first definition (if there are multiple)
                     all_references = false, -- show virtual text on all all references of the variable (not only definitions)
                     clear_on_continue = false, -- clear virtual text on "continue" (might cause flickering when stepping)
                     --- A callback that determines how a variable is displayed or whether it should be omitted
                     display_callback = function(
                        variable,
                        buf,
                        stackframe,
                        node,
                        options
                     )
                        if options.virt_text_pos == 'inline' then
                           return ' = ' .. variable.value
                        else
                           return variable.name .. ' = ' .. variable.value
                        end
                     end,
                     -- virt_text_pos = vim.fn.has("nvim-0.10") == 1 and "inline" or "eol",
                     virt_text_pos = 'eol',

                     -- experimental features:
                     all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
                     virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
                     virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
                     -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
                  },
               },
            },
            config = function()
               local dap = require 'dap'

               dap.configurations.rust = {
                  {
                     name = 'Launch',
                     type = 'codelldb',
                     request = 'launch',
                     program = get_rust_bin,
                     cwd = vim.fn.getcwd(),
                     stopOnEntry = false,
                  },
               }
            end,
            keys = {
               {
                  '<leader>dc',
                  function()
                     require('dap').continue()
                  end,
                  desc = 'DAP [c]ontinue',
               },
               {
                  '<leader>db',
                  function()
                     require('dap').toggle_breakpoint()
                  end,
                  desc = 'DAP toggle [b]reakpoint',
               },
               {
                  '<leader>dB',
                  function()
                     require('dap').set_breakpoint(
                        vim.fn.input 'Breakpoint condition: '
                     )
                  end,
                  desc = 'DAP set [b]reakpoint',
               },
               {
                  '<leader>do',
                  function()
                     require('dap').step_over()
                  end,
                  desc = 'DAP step [o]ver',
               },
               {
                  '<Down>',
                  function()
                     require('dap').step_over()
                  end,
                  desc = 'DAP step over',
               },
               {
                  '<leader>di',
                  function()
                     require('dap').step_into()
                  end,
                  desc = 'DAP step [i]n',
               },
               {
                  '<Right>',
                  function()
                     require('dap').step_into()
                  end,
                  desc = 'DAP step in',
               },
               {
                  '<leader>du',
                  function()
                     require('dap').step_out()
                  end,
                  desc = 'DAP step out ([u]p)',
               },
               {
                  '<Up>',
                  function()
                     require('dap').step_out()
                  end,
                  desc = 'DAP step out',
               },
               {
                  '<leader>dr',
                  function()
                     require('dap').repl.toggle()
                  end,
                  desc = 'DAP repl',
               },
            },
         },
      },
      opts = {},
      -- config = function()
      --    -- require('nvim-dap-virtual-text').setup()
      --    local dapui = require 'dapui'
      --    dapui.setup()
      --
      --    -- local dap = require 'dap'
      --    --
      --    -- dap.listeners.after.event_initialized['dapui_config'] = function()
      --    --    dapui.open()
      --    -- end
      --    -- dap.listeners.before.event_terminated['dapui_config'] = function()
      --    --    dapui.close()
      --    -- end
      --    -- dap.listeners.before.event_exited['dapui_config'] = function()
      --    --    dapui.close()
      --    -- end
      --    -- dap.listeners.before.attach.dapui_config = function()
      --    --    dapui.open()
      --    -- end
      --    -- dap.listeners.before.launch.dapui_config = function()
      --    --    dapui.open()
      --    -- end
      --    -- dap.listeners.before.event_terminated.dapui_config = function()
      --    --    dapui.close()
      --    -- end
      --    -- dap.listeners.before.event_exited.dapui_config = function()
      --    --    dapui.close()
      --    -- end
      -- end,
      keys = {
         {
            '<leader>as',
            function()
               require('dapui').open()
            end,
            desc = 'DapUI toggle',
         },
         {
            '<leader>at',
            function()
               require('dapui').toggle()
            end,
            desc = 'DapUI toggle',
         },
         {
            '<leader>ae',
            function()
               require('dapui').eval { enter = true }
            end,
            desc = 'DapUI eval',
            mode = { 'n', 'v' },
         },
      },
   }
end
