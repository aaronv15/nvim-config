return {
   'nvim-treesitter/nvim-treesitter',
   branch = 'master',
   lazy = false,
   build = ':TSUpdate',
   opts = {
      ensure_installed = {
         'bash',
         'c',
         'zig',
         'python',
         'diff',
         'html',
         'lua',
         'luadoc',
         'markdown',
         'markdown_inline',
         'query',
         'vim',
         'vimdoc',
         'go',
         'java',
      },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
         enable = true,

         -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
         --  If you are experiencing weird indenting issues, add the language to
         --  the list of additional_vim_regex_highlighting and disabled languages for indent.
         -- additional_vim_regex_highlighting = false,
         additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
   },
}
