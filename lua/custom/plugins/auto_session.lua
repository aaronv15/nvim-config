return {
   'rmagatti/auto-session',
   lazy = false,

   ---enables autocomplete for opts
   ---@module "auto-session"
   ---@type AutoSession.Config
   opts = {
      suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
      auto_create = false,
      auto_save = false,
      auto_restore = true,
   },
}
