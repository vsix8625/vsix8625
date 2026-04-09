local M = {}

local function find_file_in_tree(target, base_name)
	local current_dir = vim.fn.expand("%:p:h")

	local same_dir_check = current_dir .. "/" .. target
	if vim.fn.filereadable(same_dir_check) == 1 then
		return same_dir_check
	end

	local parent_dir = vim.fn.fnamemodify(current_dir, ":h")
	local common_dirs = { "src", "source", "include", "inc" }

	for _, dir in ipairs(common_dirs) do
		local path = parent_dir .. "/" .. dir .. "/" .. target
		if vim.fn.filereadable(path) == 1 then
			return path
		end
	end

	local root_markers = { '.git', 'Makefile', 'CMakeLists.txt', 'Barrfile' }
	local root_match = vim.fs.find(root_markers, { path = current_dir, upward = true })[1]
	local search_base = root_match and vim.fn.fnamemodify(root_match, ":h") or current_dir

	local target_ext = target:match("^.+(%..+)$") or ""

	local prefix_cmd = string.format("find %s -type f -name '%s*%s' -not -path '*/.*' -not -path '*/build/*'",
		search_base, base_name, target_ext)

	local results = vim.fn.systemlist(prefix_cmd)

	if #results > 0 then
		return results[1]
	end

	return nil
end

function M.switch_cfile()
	local bufnr = vim.api.nvim_get_current_buf()
	local params = { uri = vim.uri_from_bufnr(bufnr) }

	vim.lsp.buf_request(bufnr, 'textDocument/switchSourceHeader', params, function(err, result)
		if result and result ~= "" then
			local fname = vim.uri_to_fname(result)
			if vim.fn.filereadable(fname) == 1 then
				vim.api.nvim_command('edit ' .. fname)
				return
			end
		end

		local file = vim.fn.expand("%:t:r") -- e.g., "my_io"
		local ext = vim.fn.expand("%:e"):lower()
		local targets = {}

		local seek_exts = {}
		if ext == "c" or ext == "cpp" or ext == "cc" then
			seek_exts = { "h", "hpp" }
		elseif ext == "h" or ext == "hpp" then
			seek_exts = { "c", "cpp", "cc" }
		end

		for _, s_ext in ipairs(seek_exts) do
			local found = find_file_in_tree(file .. "." .. s_ext, file)
			if found then
				vim.cmd("edit " .. found)
				return
			end
		end

		print("Could not find match for " .. file)
	end)
end

-- function M.switch_cfile()
-- 	local file = vim.fn.expand("%:t:r")
-- 	local ext = vim.fn.expand("%:e"):lower()
-- 	local targets = {}
--
-- 	if ext == "c" or ext == "cpp" or ext == "cc" then
-- 		targets = { file .. ".h", file .. ".hpp" }
-- 	elseif ext == "h" or ext == "hpp" then
-- 		targets = { file .. ".c", file .. ".cpp", file .. ".cc" }
-- 	else
-- 		print("Not a C/C++ file: ." .. ext)
-- 		return
-- 	end
--
-- 	for _, target in ipairs(targets) do
-- 		local found = find_file_in_tree(target)
-- 		if found then
-- 			vim.cmd("edit " .. found)
-- 			return
-- 		end
-- 	end
--
-- 	print("Could not find a matching header/source for: " .. file)
-- end

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

local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then options = vim.tbl_extend("force", options, opts) end
	vim.keymap.set(mode, lhs, rhs, options)
end

map("n", "<Esc>", "<CMD>nohlsearch<CR>")
map("n", "<C-i>", "<C-i>")
map("v", "J", ":m '>+1<cr>gv=gv")
map("v", "K", ":m '<-2<cr>gv=gv")

map("n", ";", function()
	vim.fn.setreg("/", "TODO")
	vim.cmd("normal! n")
end)

map("n", ",", function()
	vim.fn.setreg("/", "NOTE")
	vim.cmd("normal! n")
end)

map("n", "<leader>w", "<CMD>w<CR>")
map("n", "<leader>ww", "<CMD>w!<CR>")
map("n", "<F12>", "<CMD>wqa<CR>")
map("n", "<C-F12>", "<CMD>qa!<CR>")

map("n", "<leader>cm", 'gg^VG"+y')
map("v", "<C-c>", '"+y')


map("n", "U", function()
	vim.cmd("Undotree")
end)

map("n", "{", "<CMD>bnext<CR>")
map("n", "}", "<CMD>bp<CR>")
map("n", "<C-h>", "<C-w><C-h>")
map("n", "<C-l>", "<C-w><C-l>")
map("n", "<C-j>", "<C-w><C-j>")
map("n", "<C-k>", "<C-w><C-k>")

-- Custom Utility Maps
map("n", "<leader>[", M.switch_cfile)
map("n", "<leader>1", M.flterminal)
map("n", "<leader>km", M.show_maps)

map("n", "<leader><leader>i", function() vim.cmd("Inspect") end)

return M
