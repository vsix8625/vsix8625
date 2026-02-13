local utils = require("vsix.util")

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
--
-- Custom Utility Maps
map("n", "<leader>[", utils.switch_cfile)
map("n", "<leader>1", utils.flterminal)
