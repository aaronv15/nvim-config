local M = {}

local datafile = vim.fn.stdpath 'data' .. '/colorsave.json'

--- @alias ColorConfig {[string]: fun()}
--- @alias UserConfig {
--- light: (ColorConfig | fun())?,
--- dark: (ColorConfig | fun())?,
--- def: (ColorConfig | fun())?,
--- def_col: string? }
--- @alias Modes "dark" | "light" | "def"
--- @alias Ctx {dark: string?, light: string?, def: string?, activate: Modes?}

--- @return Ctx
local function read_store()
   local f = io.open(datafile, 'r')
   if not f then
      return {}
   end
   local content = f:read '*a'
   f:close()

   local ok, decoded = pcall(vim.json.decode, content)
   if ok and type(decoded) == 'table' then
      return decoded
   end
   return {}
end

--- @param tbl Ctx
local function write_store(tbl)
   local f = assert(io.open(datafile, 'w'))
   f:write(vim.json.encode(tbl))
   f:close()
end

--- @param name string
--- @return boolean
local function apply_colorscheme(name)
   local ok, err = pcall(vim.cmd.colorscheme, name)
   if not ok then
      vim.notify(
         'Failed to load colorscheme: ' .. name .. '\n' .. err,
         vim.log.levels.ERROR
      )
   end
   return ok
end

--- @param name string
local function colorscheme_exists(name)
   return vim.tbl_contains(vim.fn.getcompletion('', 'color'), name)
end

--- @param user_config UserConfig
--- @param mode Modes
--- @param arg string
--- @param store Ctx?
local function handle(user_config, mode, arg, store)
   if not store then
      store = read_store()
   end

   -- '?' → query
   if arg == '?' then
      local val = store[mode]
      if val then
         vim.notify(mode .. ' colorscheme: ' .. val)
      else
         vim.notify('No colorscheme stored for ' .. mode)
      end
      return
   end

   local val
   if arg and arg ~= '' then
      val = arg
   else
      val = store[mode]
   end
   if val then
      if not colorscheme_exists(val) then
         vim.notify('Failed to find colorscheme: ' .. val .. '\n', vim.log.levels.ERROR)
         return
      end

      --- @type (ColorConfig | fun())?
      local color_config = user_config[mode]
      local func
      if type(color_config) == 'table' then
         func = color_config[val]
      else
         func = color_config
      end

      if func then
         func()
      end

      local ok = apply_colorscheme(val)
      if not ok then
         return
      end

      if arg and arg ~= '' then
         store[mode] = arg
         vim.notify('Saved ' .. mode .. ' colorscheme: ' .. arg)
      end

      store.activate = mode
      write_store(store)
   else
      vim.notify('No colorscheme stored for ' .. mode)
   end
end

--- @param config_opts UserConfig
function M.setup(config_opts)
   vim.api.nvim_create_user_command('Clight', function(opts)
      handle(config_opts, 'light', opts.args)
   end, { nargs = '?', complete = 'color' })

   vim.api.nvim_create_user_command('Cdark', function(opts)
      handle(config_opts, 'dark', opts.args)
   end, { nargs = '?', complete = 'color' })

   local store = read_store()
   if store.activate then
      local colour = store[store.activate]
      if colour then
         handle(config_opts, store.activate, '', store)
      end
   elseif config_opts.def_col then
      store.def = config_opts.def_col
      handle(config_opts, 'def', '', store)
   end
end

return M
