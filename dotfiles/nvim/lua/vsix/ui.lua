local M = {}


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
	local diagnostics = "S:"

	vim.g.is_lsp_error = false

	if errors > 0 then
		diagnostics = "E:" .. " (" .. "X" .. errors .. ") "
		vim.g.is_lsp_error = true
	end

	if warnings > 0 then
		diagnostics = diagnostics .. "(" .. "X" .. warnings .. ") "
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
	sys_information = " Windows "
elseif os_info.sysname == "Linux" then
	sys_information = " Linux "
else
	sys_information = " MacOS "
end


----------------------------------------------------------------------------------------------------

local hour_n = 1
function MyWinbar()
	local winbar
	local colorscheme_icon = " "
	local is_changed = vim.bo.modified

	local time = os.date(" %H:%M:%S")
	local date = os.date("%d/%m/%y")
	hour_n = hour_n + 1
	if hour_n >= 24 then
		hour_n = 1
	end
	local date_time = string.format([[%s%s %s%s]], " ", date, " ", time)

	sync_colors()

	if colorscheme_icon == nil then
		colorscheme_icon = " "
	end

	-- hides the theme name and icon if vim.g.show_theme_name is set to false
	local theme_name_icon = colorscheme_icon .. "[" .. vim.g.colors_name .. "]"
	if not vim.g.show_theme_name then
		theme_name_icon = " "
	end

	----------------------------------------------------------------------------------------------------

	-- the main winbar
	winbar = "%#modeNormal#" ..
		"-->" .. " %t [%#linenr#%n%#modeNormal#] %=" ..
		theme_name_icon .. "%=" .. sys_information

	----------------------------------------------------------------------------------------------------

	if is_changed then
		winbar = "%#errormsg#" .. " %F " ..
			"%=Diagnostics: " .. get_lsp_diagnostics()
	end
	----------------------------------------------------------------------------------------------------

	if vim.bo.filetype == "homepage" then
		winbar = "Home[%n] %=" .. date_time
	end

	return winbar
end

----------------------------------------------------------------------------------------------------
local function get_shiftwidth()
	return vim.api.nvim_buf_get_option(0, 'shiftwidth')
end

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

	local buffer_info = "%=%#modeNormal# " ..
		" %#linenr#TAB=" .. get_shiftwidth() .. " | %c | %l" .. "/%L|%#modeNormal# %p%%| "

	---@diagnostic disable-next-line: unused-local
	local save_status_colors = {
		hl(0, "saveStatus", { fg = "#062001" }),
		hl(0, "unSaveStatus", { fg = "#090909" }),
	}

	local save_status
	if is_changed then
		save_status = "%#unSaveStatus#" .. "$"
	else
		save_status = "%#saveStatus#"
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

		statusline = "I: %c %m --> %#normal#" .. cursor
	end

	----------------------------------------------------------------------------------------------------
	if mode == "R" or mode == "r" then
		local end_col = vim.fn.col('.')

		while end_col <= #line and line:sub(end_col, end_col) ~= " " do
			end_col = end_col + 1
		end

		local cursor = "Replace: %m " .. line:sub(col, end_col - 1)

		statusline = " --> %#normal# " .. cursor
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
