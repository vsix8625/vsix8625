vim.g.mapleader      = " "
vim.g.maplocalleader = "\\"

--vim.cmd("colo ares")
vim.cmd("colo zeus")
vim.g.CUSTOM_COLORSCHEME = 1

vim.g.netrw_banner       = 0
vim.g.netrw_browse_split = 0
vim.g.netrw_mouse        = 2

vim.g.show_theme_name    = true

-----------------------------------------------------------

vim.opt.ruler            = true
vim.opt.spell            = true
vim.opt.wrap             = false
vim.opt.encoding         = "utf-8"
vim.opt.fileencoding     = "utf-8"
vim.opt.spelllang        = "en_us"
vim.opt.winblend         = 5
vim.opt.shortmess:append 'c'
vim.opt.shortmess:append 'a'
vim.opt.shortmess:append 'I'
vim.opt.matchpairs:append "<:>"

local opts = {
	{ "swapfile",       false },
	{ "guicursor",      "n-v-i-c:block-Cursor" },
	{ "completeopt",    "menu,menuone,noselect" },
	{ "pumheight",      15 },
	{ "pumwidth",       35 },
	{ "pumblend",       8 },
	{ "laststatus",     3 },
	{ "termguicolors",  true },
	{ "number",         true },
	{ "relativenumber", true },
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

-----------------------------------------------------------

local utils                   = require("user.util")

-----------------------------------------------------------

vim.g.loaded_gzip             = 1
vim.g.loaded_tarPlugin        = 1
vim.g.loaded_tutor            = 1
vim.g.loaded_zipPlugin        = 1
vim.g.loaded_matchit          = 1
vim.g.loaded_matchparen       = 1
vim.g.loaded_netrw            = 1
vim.g.loaded_netrwPlugin      = 1
vim.g.loaded_2html_plugin     = 1
vim.g.loaded_getscript        = 1
vim.g.loaded_getscriptPlugin  = 1
vim.g.loaded_logipat          = 1
vim.g.loaded_rrhelper         = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_vimball          = 1
vim.g.loaded_vimballPlugin    = 1

vim.cmd("syntax on")

local function load_module(mod)
	local ok, m = pcall(require, mod)
	if ok and m.load then m.load() end
end

require("user.autocmds")

vim.defer_fn(function()
	load_module("user.ui")
	require("user.autocmp")
	require("user.lspconf").load()
end, 0)

