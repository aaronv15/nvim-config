return {
   'windwp/nvim-autopairs',
   event = 'InsertEnter',
   config = function()
      local npairs = require 'nvim-autopairs'
      local cond = require 'nvim-autopairs.conds'
      local ts_conds = require 'nvim-autopairs.ts-conds'
      local Rule = require 'nvim-autopairs.rule'

      npairs.setup { check_ts = true, fast_wrap = {} }

      npairs.add_rules {
         Rule('|', '|', { 'rust' })
            :with_pair(cond.not_before_regex [=[[%w%%%'%[%"%.%`%$]]=])
            :with_move(cond.after_regex '|'),
      }
      npairs.add_rules {
         Rule('>', '>', { 'rust' })
            :with_pair(cond.none()) -- never auto-insert
            :with_move(function(opts)
               -- only allow skipping if next char is '>'
               if opts.next_char ~= '>' then
                  return false
               end

               -- only inside Rust generic type arguments
               return ts_conds.is_ts_node {
                  'type_arguments',
                  'type_parameters',
               }(opts)
            end)
            :with_cr(cond.none())
            :with_del(cond.none()),
      }
      return true
   end,
   -- use opts = {} for passing setup options
   -- this is equivalent to setup({}) function
}
