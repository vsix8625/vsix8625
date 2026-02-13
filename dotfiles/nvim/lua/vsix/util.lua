local M = {}

local function find_file_in_tree(filename)
	local handle = io.popen("find . -type f -name '" .. filename .. "'")
	if handle then
		local result = handle:read("*l")
		handle:close()
		return result
	end
	return nil
end

function M.switch_cfile()
	local file = vim.fn.expand("%:t:r") -- filename without extension
	local ext = vim.fn.expand("%:e")
	local target = ""

	if ext == "c" then
		target = file .. ".h"
	elseif ext == "h" or ext == "hpp" then
		target = file .. ".c"
	else
		print("Unsupported extension: " .. ext)
		return
	end

	local found = find_file_in_tree(target)
	if found then
		vim.cmd("edit " .. found)
	else
		print("No matching file found for " .. target)
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
