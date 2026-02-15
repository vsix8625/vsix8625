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

function M.show_maps()
	local modes = { n = "Normal", v = "Visual", i = "Insert" }
	local all_lines = {}

	local width = 80
	local height = 40

	local leader = vim.g.mapleader or " "

	for mode, name in pairs(modes) do
		local lines = {}
		table.insert(lines, " " .. name .. " Mode Keymaps ")
		table.insert(lines, string.rep("─", width - 2))

		local maps_global = vim.api.nvim_get_keymap(mode)
		local maps_buf    = vim.api.nvim_buf_get_keymap(0, mode)
		local maps        = {}
		for _, m in ipairs(maps_global) do table.insert(maps, m) end
		for _, m in ipairs(maps_buf) do table.insert(maps, m) end

		local max_lhs = 0
		for _, map in ipairs(maps) do
			local lhs = map.lhs or ""

			lhs = lhs:gsub("^" .. leader, "<leader>")
			local len = vim.fn.strdisplaywidth(lhs)
			if len > max_lhs then
				max_lhs = len
			end
		end

		for _, map in ipairs(maps) do
			local lhs = map.lhs or ""
			local rhs = map.desc or map.rhs or ""
			local src = map.buffer and "[BUF]" or "[GLOB]"

			lhs = lhs:gsub("^" .. leader, "<leader>")

			local lhs_pad = max_lhs - vim.fn.strdisplaywidth(lhs)
			lhs = lhs .. string.rep(" ", lhs_pad)

			local available = width - max_lhs - 8
			if vim.fn.strdisplaywidth(rhs) > available then
				rhs = rhs:sub(1, available - 1) .. "…"
			end

			table.insert(lines, "  " .. lhs .. "  →  " .. rhs .. " " .. src)
		end

		for _, l in ipairs(lines) do
			table.insert(all_lines, l)
		end
		table.insert(all_lines, "")
	end

	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, all_lines)

	vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
	vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
	vim.api.nvim_buf_set_option(buf, "swapfile", false)
	vim.api.nvim_buf_set_option(buf, "modifiable", false)
	vim.api.nvim_buf_set_option(buf, "spell", false)

	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = math.floor((vim.o.lines - height) / 2),
		col = math.floor((vim.o.columns - width) / 2),
		border = "rounded",
	})

	vim.api.nvim_win_set_option(win, "winblend", 0)
	vim.wo[win].spell = false
	vim.wo[win].wrap = false
	vim.wo[win].number = false
	vim.wo[win].relativenumber = false
	vim.wo[win].cursorline = false
	vim.wo[win].signcolumn = "no"

	vim.keymap.set("n", "q", function()
		vim.api.nvim_win_close(win, true)
	end, { buffer = buf, nowait = true, silent = true })

	vim.keymap.set("n", "<Esc>", function()
		vim.api.nvim_win_close(win, true)
	end, { buffer = buf, nowait = true, silent = true })
end

return M
