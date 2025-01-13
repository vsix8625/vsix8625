-- This is no longer in use
local M = {}

local signal = require("vsix.popup")

local icons = {
  dir         = "\u{1F5C2}",
  open_file   = "\u{1f4c2}",
  x_mark      = "\u{274c}",
  right_arrow = "\u{27a6}",
  recent      = "\u{21aa} ",
  tornado     = "\u{1f300} ",
  pen         = "\u{1f58b}",
  info        = "\u{2139} ",
  term        = "\u{1f523}",
  tree        = "\u{1f332}",
  new_file    = "\u{1f4c4}",
  magnifier   = "\u{1f50e}",
  wrench      = "\u{1f527}",
  colors      = "\u{1f3a8}",
  sat_disk    = "\u{1f4e1}",
  satelite    = "\u{1f6f0}",
  calendar    = "\u{1f4c6}",
  zzz         = "\u{1f4a4}",
  floppy_disk = "\u{1f4be}",
  mini_disk   = "\u{1f4bd}",
  stop        = "\u{1f6d1}",
  gear        = "\u{2699} ",
  globe       = "\u{1f310}",
  column_bars = "\u{1f4ca}",
  status_ok   = "\u{1f7e2}",
  status_fail = "\u{1f534}",
}

local config_path = vim.fn.stdpath("config")
local init_lua = config_path .. "/init.lua"
local term_settings = "~/.config/kitty/kitty.conf"

local function create_menu_item(icon, text, key)
  local text_width = 51
  local add_spaces = string.rep(" ", text_width - (#text + #key + 2))
  return string.format("%s %s%s%s", icon, text, add_spaces, key)
end

---TODO: Add comments

---hi_opts = hi options table

local function init_menu()
  local bufnr = vim.api.nvim_get_current_buf()
  --  vim.evn.HOME_MENU_BUFNR = bufnr

  vim.cmd("enew")
  local lua_version = _VERSION
  ---@diagnostic disable-next-line: undefined-global
  local jit_v = jit.version
  local nvim_v = { vim.version().major .. ".", vim.version().minor .. ".", vim.version().patch }

  local header = {
    "",
    "",
    "",
    "",
    "",
    "",
    "\t\t\t\t\t███╗   ██╗██╗   ██╗██╗███╗   ███╗",
    "\t\t\t\t\t████╗  ██║██║   ██║██║████╗ ████║",
    "\t\t\t\t\t██╔██╗ ██║██║   ██║██║██╔████╔██║",
    "\t\t\t\t\t██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║",
    "\t\t\t\t\t██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║",
    "\t\t\t\t\t╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝",
    "",
    "",
    "",
    create_menu_item(icons["dir"], "Open workspace", "(R) "),
    create_menu_item(icons["tree"], "Explorer", "(x) "),
    create_menu_item(icons["new_file"], "New", "(n) "),
    create_menu_item(icons["recent"], "Recent ", "(r) "),
    create_menu_item(icons["magnifier"], "Search", "(f) "),
    create_menu_item(icons["colors"], "Themes", "(t) "),
    create_menu_item(icons["gear"], "Config", "(c) "),
    create_menu_item(icons["zzz"], "Lazy Sync", "(s) "),
    create_menu_item(icons["term"], "Kitty Config", "(K) "),
    create_menu_item(icons["x_mark"], "Exit", "(q) "),
    "",
    "",
    "",
    create_menu_item(icons["wrench"], "Nvim: " .. nvim_v[1] .. nvim_v[2] .. nvim_v[3], ""),
    create_menu_item(icons["wrench"], lua_version, " " .. jit_v),
    "",
  }


  local width = vim.o.columns

  local padding = string.rep(" ", math.floor((width - #header) / 3))
  local formatted_header = {}

  for _, line in ipairs(header) do
    table.insert(formatted_header, padding .. line)
  end

  ----------------------------------------------------------------------------------------------------
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, formatted_header)

  for i = 6, 12 do
    local line = i - 1
    local col_start = 0
    local col_end = #formatted_header[i] + vim.fn.col('$')
    vim.api.nvim_buf_add_highlight(bufnr, -1, "String", line, col_start, col_end)
  end
  ----------------------------------------------------------------------------------------------------
  vim.defer_fn(function()
    local keymap = vim.api.nvim_buf_set_keymap
    local opts = { noremap = true, silent = true }

    keymap(bufnr, "n", "R", ":!xdg-open .<CR>", opts)
    keymap(bufnr, "n", "n", ":enew <BAR> startinsert<CR>", opts)
    keymap(bufnr, "n", "r", ":Telescope oldfiles<CR>", opts)
    keymap(bufnr, "n", "f", ":Telescope find_files<CR>", opts)
    keymap(bufnr, "n", "t", ":Telescope colorscheme<CR>", opts)
    keymap(bufnr, "n", "c", ":edit " .. init_lua .. "<CR>", opts)
    vim.keymap.set("n", "x", function()
      vim.cmd("Ex")
    end, { buffer = bufnr, noremap = true, silent = true })
    keymap(bufnr, "n", "s", ":Lazy sync<CR>", opts)
    keymap(bufnr, "n", "K", ":edit " .. term_settings .. "<CR>", opts)
    keymap(bufnr, "n", "q", ":qa<CR>", opts)
  end, 200)

  ----------------------------------------------------------------------------------------------------
  vim.api.nvim_buf_set_option(bufnr, 'filetype', 'homepage')
  vim.bo[bufnr].buftype = 'nofile'
  vim.bo[bufnr].bufhidden = 'hide'
  vim.bo[bufnr].swapfile = false

  local stats = require("lazy").stats()
  vim.defer_fn(function()
    local load_time = string.format([[%.2f]], stats.startuptime)
    local lazy_time = string.format([[%.2f]], stats.times.LazyDone)

    local lazy_float_msg = icons["satelite"] .. "Lazy loaded " ..
        stats.loaded .. "/" .. stats.count .. " plugins in " .. lazy_time .. " ms"

    local load_float_msg = icons["sat_disk"] .. "Load time " .. load_time .. " ms"

    local screen_width = vim.o.columns
    -- local screen_height = vim.o.lines
    local SIZE = 50
    local HEIGHT = 2
    local X = screen_width - SIZE
    local Y = 2
    local DURATION = 8000

    signal.WIN_Destroy(signal.WIN_Create(SIZE, HEIGHT, X, Y, { lazy_float_msg, load_float_msg }), DURATION)


    --    vim.bo[bufnr].readonly = true
    vim.bo[bufnr].modifiable = false
    vim.cmd("normal Mjj")
  end, 200)
end
----------------------------------------------------------------------------------------------------

function M.load()
  init_menu()
end

----------------------------------------------------------------------------------------------------

return M
