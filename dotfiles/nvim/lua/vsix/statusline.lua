local M = {}

local theme_icon = {
  eyes           = " \u{1f440} ",
  sun            = " \u{1f31e} ",
  neovimo        = " \u{2115} ",
  neovimo_modern = " \u{2115} ",
  fallout        = " \u{2622} ",
  zeus           = " \u{26a1} ",
  ares           = " \u{2694} ",
  poseidon       = " \u{1F531} ",
  spectral       = " \u{1F4AB} ",
  void           = " \u{1f573} ",
  nebula         = " \u{1f30c} ",
  supernova      = " \u{1f4a5} ",
}

local icons = {  
  dir         = " \u{1F5C2}",
  saved       = " \u{1f7e2} ",
  unsaved     = " \u{1f534} ",
  open_file   = " \u{1f4c2}",
  right_arrow = " \u{27a6}",
  top_arrow   = "\u{1f51d}",
  pen         = " \u{1f58b}",
  calendar    = "\u{1f4c6}",
  ruler       = " \u{1f4cf}",
  wrench      = " \u{1f527}",
  colors      = " \u{1f3a8}",
  floppy_disk = " \u{1f4be}",
  stop        = " \u{1f6d1}",
  column_bars = " \u{1f4ca}",
  status_ok   = " \u{1f7e2} ",
  status_fail = " \u{1f534} ",
  red_x       = "\u{274c} ",
  red_ex      = "\u{2757}",
}

local clock = {
  "\u{1f550}", "\u{1f551}",
  "\u{1f552}", "\u{1f553}",
  "\u{1f554}", "\u{1f555}",
  "\u{1f556}", "\u{1f557}",
  "\u{1f558}", "\u{1f559}",
  "\u{1f55a}", "\u{1f55b}",
  "\u{1f55c}", "\u{1f55d}",
  "\u{1f55e}", "\u{1f55f}",
  "\u{1f560}", "\u{1f561}",
  "\u{1f562}", "\u{1f563}",
  "\u{1f564}", "\u{1f565}",
  "\u{1f566}", "\u{1f567}",
}

local api = vim.api
local hl = api.nvim_set_hl

local function sync_colors()
  local hl_back = api.nvim_get_hl_by_name("normal", true)
  local normal_bg = hl_back.background

  local hl_string = api.nvim_get_hl_by_name("string", true)
  local fg_string = hl_string.foreground
  local string_fg_color = string.format("#%06x", fg_string or 0)

  local hl_linenr = api.nvim_get_hl_by_name("linenr", true)
  local bg_linenr = hl_linenr.background
  local linenr_bg_color = string.format("#%06x", bg_linenr or 0)

  if not normal_bg then
    hl(0, "modeNormal", { fg = string_fg_color, bg = "none" })
  else
    hl(0, "modeNormal", { fg = string_fg_color, bg = linenr_bg_color })
  end
end

----------------------------------------------------------------------------------------------------
-- LSP

local function get_lsp_diagnostics()
  local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
  local warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
  local info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
  local hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
  local diagnostics = icons["status_ok"]

  vim.g.is_lsp_error = false

  if errors > 0 then
    diagnostics = icons["status_fail"] .. " (" .. icons["red_x"] .. errors .. ") "
    vim.g.is_lsp_error = true
  end

  if warnings > 0 then
    diagnostics = diagnostics .. "(" .. icons["red_ex"] .. warnings .. ") "
    vim.g.is_lsp_error = true
  end

  if hints > 0 then
    diagnostics = diagnostics .. "(H " .. hints .. ") "
    vim.g.is_lsp_error = true
  end

  if info > 0 then
    diagnostics = diagnostics .. "(I " .. info .. ") "
    vim.g.is_lsp_error = true
  end

  return diagnostics
end

----------------------------------------------------------------------------------------------------
--get the system info

local os_info = vim.uv.os_uname()
local sys_information
if os_info.sysname == "Windows_NT" then
  sys_information = " \u{1f5a5} Windows "
elseif os_info.sysname == "Linux" then
  sys_information = " \u{1F427} Linux "
else
  sys_information = " \u{1f34e} MacOS "
end


----------------------------------------------------------------------------------------------------

local hour_n = 1
function MyWinbar()
  local winbar
  local colorscheme_icon = theme_icon[vim.g.colors_name]
  local is_changed = vim.bo.modified

  local time = os.date(" %H:%M:%S")
  local date = os.date("%d/%m/%y")
  hour_n = hour_n + 1
  if hour_n >= 24 then
    hour_n = 1
  end
  local date_time = string.format([[%s%s %s%s]], icons["calendar"], date, clock[hour_n], time)

  sync_colors()

  if colorscheme_icon == nil then
    colorscheme_icon = theme_icon["eyes"]
  end

  -- hides the theme name and icon if vim.g.show_theme_name is set to false
  local theme_name_icon = colorscheme_icon .. "[" .. vim.g.colors_name .. "]"
  if not vim.g.show_theme_name then
    theme_name_icon = " "
  end

  ----------------------------------------------------------------------------------------------------

  -- the main winbar
  winbar = "%#modeNormal#" ..
      icons["right_arrow"] .. icons["open_file"] .. " %t [%#linenr#%n%#modeNormal#] %=" ..
      theme_name_icon .. "%=" .. sys_information

  ----------------------------------------------------------------------------------------------------

  if is_changed then
    winbar = "%#errormsg#" .. icons["dir"] .. " %F " .. icons["floppy_disk"] ..
        "%=Diagnostics: " .. get_lsp_diagnostics()
  end
  ----------------------------------------------------------------------------------------------------

  if vim.bo.filetype == "homepage" then
    winbar = "Home[%n] %=" .. date_time
  end

  return winbar
end

----------------------------------------------------------------------------------------------------

function MyStatusline()
  local statusline
  local mode = vim.fn.mode()
  local is_changed = vim.bo.modified
  local line = vim.fn.getline('.')
  local col = vim.fn.col('.')

  sync_colors()

  local filetype = vim.bo.filetype

  if filetype == " " then
    filetype = " "
  end

  local buffer_info = "%=%#modeNormal#" ..
      "  %#linenr#%c | %l" .. "/%L|%#modeNormal# %p%%| "

  ---@diagnostic disable-next-line: unused-local
  local save_status_colors = {
    hl(0, "saveStatus", { fg = "#062001" }),
    hl(0, "unSaveStatus", { fg = "#090909" }),
  }

  local save_status
  if is_changed then
    save_status = "%#unSaveStatus#" .. icons["unsaved"]
  else
    save_status = "%#saveStatus#" .. icons["saved"]
  end

  -- normal mode statusline
  if mode == "n" then
    local lsp = get_lsp_diagnostics()
    statusline = save_status .. "%#modeNormal#" .. " Normal %m" ..
		"%#string# %y" ..
        buffer_info .. lsp
  end

  if mode == "i" then
    local cursor = line:sub(1, col)

    statusline = icons["pen"] .. " %c %m --> %#normal#" .. cursor
  end

  ----------------------------------------------------------------------------------------------------
  if mode == "R" or mode == "r" then
    local end_col = vim.fn.col('.')

    while end_col <= #line and line:sub(end_col, end_col) ~= " " do
      end_col = end_col + 1
    end

    local cursor = "Replace: %m " .. line:sub(col, end_col - 1)

    statusline = icons["wrench"] .. " --> %#normal# " .. cursor
  end
  ----------------------------------------------------------------------------------------------------

  if mode == "c" then
    statusline = "%#modeNormal#\u{1f191} Command "
  end

  if mode == "t" then
    statusline = "%#modeNormal#\u{1f39b} Terminal "
  end

  ----------------------------------------------------------------------------------------------------

  if mode == "V" or mode == "v" then
    statusline = "%#visual#\u{1f50d} Visual "
  end

  ----------------------------------------------------------------------------------------------------

  if vim.bo.filetype == "TelescopePrompt" then
    statusline = "%#linenr# [%#cursorlinenr#%Y%#linenr#] \u{1f52d} "
  end

  ----------------------------------------------------------------------------------------------------

  return statusline
end

----------------------------------------------------------------------------------------------------

function M.load()
  vim.go.winbar = '%!v:lua.MyWinbar()'
  vim.go.statusline = '%!v:lua.MyStatusline()'
end

return M
