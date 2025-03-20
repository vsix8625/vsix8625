local M = {}

----------------------------------------------------------------------------------------------------

local function get_current_time()
	return os.date("[%H:%M:%S]: ")
end

local function get_current_date()
	return os.date("%d-%m-%Y")
end

local function write_to_log(message, mode)
	local log_file = io.open("nvim_debug.log", mode)
	if log_file then
		log_file:write(get_current_time() .. " - " .. message .. "\n")
		log_file:close()
	end
end

function M.initialize_debug_log()
	write_to_log(get_current_date() .. ": nvim_debug_mode", "w")
end

function M.debug_log(msg)
	if vim.g.debug_mode then
		write_to_log(msg, "a")
	end
end

----------------------------------------------------------------------------------------------------

function M.vsix_require(module)
	M.debug_log("Loading: " .. module)
	local success, error_msg = pcall(require, module)
	if not success then
		print("Error: " .. error_msg)
		print("Error loading module: " .. module)
	else
		M.debug_log("Status: OK")
	end
end

----------------------------------------------------------------------------------------------------

local function is_file(path)
	return vim.fn.filereadable(path) == 1
end

function M.switch_cfile()
	local file = vim.fn.expand("%:t:r")
	local ext = vim.fn.expand("%:e")
	local switch = 0
	local switch_path = ""

	if ext == "c" then
		if is_file(file .. ".h") then
			switch_path = file .. ".h"
			switch = 1
		elseif is_file("inc/" .. file .. ".h") then
			switch_path = "inc/" .. file .. ".h"
			switch = 1
		elseif is_file("include/" .. file .. ".h") then
			switch_path = "include/" .. file .. ".h"
			switch = 1
		end
	else
		if is_file("src/" .. file .. ".c") then
			switch_path = "src/" .. file .. ".c"
			switch = 1
		end
	end

	if switch and switch_path then
		print("switch")
		vim.cmd("edit " .. switch_path)
	else
		print("Header/source not found for " .. file)
	end
end

----------------------------------------------------------------------------------------------------

function M.flterminal()
	local width = 80
	local height = 20
	local buf = vim.api.nvim_create_buf(false, true)

	local win = vim.api.nvim_open_win(buf, true, {
		relative = 'editor',
		width = width,
		height = height,
		col = (vim.o.columns - width) / 2,
		row = (vim.o.lines - height) / 2,
		border = 'rounded',
	})


	vim.cmd("terminal")
	vim.api.nvim_buf_set_option(buf, 'spell', false)
	vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
	vim.cmd("startinsert")

	vim.api.nvim_set_current_win(win)
end

return M
