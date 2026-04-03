local M = {}

local function find_file_in_tree(target)
	local cmd = string.format("find . -name '%s' -not -path '*/.*' | head -n 1", target)
	local result = vim.fn.system(cmd):gsub("%s+", "")

	if result ~= "" then
		return result
	end
	return nil
end

function M.switch_cfile()
	local file = vim.fn.expand("%:t:r")
	local ext = vim.fn.expand("%:e"):lower()
	local targets = {}

	if ext == "c" or ext == "cpp" or ext == "cc" then
		targets = { file .. ".h", file .. ".hpp" }
	elseif ext == "h" or ext == "hpp" then
		targets = { file .. ".c", file .. ".cpp", file .. ".cc" }
	else
		print("Not a C/C++ file: ." .. ext)
		return
	end

	for _, target in ipairs(targets) do
		local found = find_file_in_tree(target)
		if found then
			vim.cmd("edit " .. found)
			return
		end
	end

	print("Could not find a matching header/source for: " .. file)
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

local opts = {
	{ "swapfile",       false },
	{ "guicursor",      "n-v-i-c:block-Cursor" },
	{ "completeopt",    "menu,menuone,noselect" },
	{ "pumheight",      15 },
	{ "pumwidth",       35 },
	{ "pumblend",       8 },
	{ "laststatus",     3 },
	{ "termguicolors",  true },
	{ "number",         false },
	{ "relativenumber", false },
	{ "scrolloff",      8 },
	{ "hlsearch",       true },
	{ "incsearch",      true },
	{ "showcmd",        false },
	{ "showfulltag",    true },
	{ "updatetime",     50 },
	{ "timeoutlen",     300 },
	{ "conceallevel",   0 },
	{ "mouse",          "a" },
	{ "showtabline",    1 },
	{ "ignorecase",     true },
	{ "smartcase",      true },
	{ "showmode",       false },
	{ "splitbelow",     true },
	{ "splitright",     true },
	{ "signcolumn",     "yes" },
	{ "undofile",       true },
	{ "inccommand",     "split" },
	{ "writebackup",    false },
	{ "smartindent",    true },
	{ "expandtab",      false },
	{ "shiftwidth",     4 },
	{ "tabstop",        4 },
	{ "softtabstop",    2 },
	{ "numberwidth",    2 },
	{ "cursorline",     true },
	{ "spelllang",      "en_us" },
	{ "cmdheight",      0 },
	{ "scrolljump",     1 },
}

for _, opt in ipairs(opts) do
	local name, value = opt[1], opt[2]
	vim.opt[name] = value
end

vim.opt.ruler = true
vim.opt.spell = true
vim.opt.wrap = false
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.spelllang = "en_us"
vim.opt.winblend = 5
vim.opt.shortmess:append 'c'
vim.opt.shortmess:append 'a'
vim.opt.shortmess:append 'I'
vim.opt.matchpairs:append "<:>"

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

map("n", "<leader><leader>p", function() vim.cmd("Lazy profile") end)
map("n", "<leader><leader>l", function() vim.cmd("Lazy update") end)

return M
