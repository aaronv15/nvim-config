return {
   'saghen/blink.cmp',
   -- optional: provides snippets for the snippet source
   dependencies = { 'rafamadriz/friendly-snippets' },

   -- use a release tag to download pre-built binaries
   version = '1.*',
   -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
   -- build = 'cargo build --release',
   -- If you use nix, you can build from source using latest nightly rust with:
   -- build = 'nix run .#build-plugin',

   ---@module 'blink.cmp'
   ---@type blink.cmp.Config
   opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = {
         preset = 'default',
         ['<tab>'] = { 'accept', 'fallback' },
         ['<C-d>'] = { 'show_signature', 'hide_signature', 'fallback' },
         ['<C-k>'] = { 'scroll_documentation_up', 'fallback' },
         ['<C-j>'] = { 'scroll_documentation_down', 'fallback' },
      },

      appearance = {
         -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
         -- Adjusts spacing to ensure icons are aligned
         nerd_font_variant = 'mono',
      },

      -- (Default) Only show the documentation popup when manually triggered
      completion = {
         ghost_text = { enabled = false },
         documentation = { auto_show = true },
         trigger = {
            -- When true, will prefetch the completion items when entering insert mode
            prefetch_on_insert = false,

            -- When false, will not show the completion window automatically when in a snippet
            show_in_snippet = false,

            -- When true, will show completion window after backspacing
            -- NOTE: show_on_backspace = false,

            -- When true, will show completion window after backspacing into a keyword
            -- NOTE: show_on_backspace_in_keyword = false,

            -- When true, will show the completion window after accepting a completion and then backspacing into a keyword
            -- NOTE: show_on_backspace_after_accept = true,

            -- When true, will show the completion window after entering insert mode and backspacing into keyword
            show_on_backspace_after_insert_enter = false,

            -- When true, will show the completion window after typing any of alphanumerics, `-` or `_`
            show_on_keyword = false,

            -- When true, will show the completion window after typing a trigger character
            show_on_trigger_character = false,

            -- When true, will show the completion window after entering insert mode
            -- NOTE: show_on_insert = false,

            -- LSPs can indicate when to show the completion window via trigger characters
            -- however, some LSPs (i.e. tsserver) return characters that would essentially
            -- always show the window. We block these by default.
            -- NOTE: show_on_blocked_trigger_characters = { ' ', '\n', '\t' },

            -- You can also block per filetype with a function:
            -- show_on_blocked_trigger_characters = function(ctx)
            --   if vim.bo.filetype == 'markdown' then return { ' ', '\n', '\t', '.', '/', '(', '[' } end
            --   return { ' ', '\n', '\t' }
            -- end,

            -- When both this and show_on_trigger_character are true, will show the completion window
            -- when the cursor comes after a trigger character after accepting an item
            show_on_accept_on_trigger_character = false,

            -- When both this and show_on_trigger_character are true, will show the completion window
            -- when the cursor comes after a trigger character when entering insert mode
            show_on_insert_on_trigger_character = false,

            -- List of trigger characters (on top of `show_on_blocked_trigger_characters`) that won't trigger
            -- the completion window when the cursor comes after a trigger character when
            -- entering insert mode/accepting an item
            -- NOTE: show_on_x_blocked_trigger_characters = { "'", '"', '(' },
            -- or a function, similar to show_on_blocked_trigger_character
         },
      },

      -- Experimental signature help
      signature = { enabled = true },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
         default = { 'lsp', 'path', 'snippets', 'buffer', 'lazydev' },
         providers = {
            lazydev = {
               name = 'LazyDev',
               module = 'lazydev.integrations.blink',
               -- make lazydev completions top priority (see `:h blink.cmp`)
               score_offset = 100,
            },
         },
      },

      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = 'prefer_rust_with_warning' },
   },
   opts_extend = { 'sources.default' },
}
