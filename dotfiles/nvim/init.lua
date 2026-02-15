vim.g.mapleader          = " "
vim.g.maplocalleader     = "\\"

vim.g.netrw_banner       = 0
vim.g.netrw_browse_split = 0
vim.g.netrw_mouse        = 2

vim.g.show_theme_name    = true

-----------------------------------------------------------

require("vsix.opts")
require("vsix.keymaps")

vim.defer_fn(function()
	vim.cmd("colo zeus")
	vim.g.CUSTOM_COLORSCHEME = 1
end, 0)

local utils = require("vsix.util")


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		{
			import = "plugins.treesitter",
		},

		{
			import = "plugins.telescope",
		},

		{
			import = "plugins.nvim-lspconfig",
		},
	},
	defaults = {
		lazy = true,
	},
	checker = {
		enabled   = false,
		notify    = true,
		frequency = 3600,
	},
	change_detection = {
		enabled = true,
		notify  = false,
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"tarPlugin",
				"tutor",
				"zipPlugin",
				"matchit",
				"matchparen",
				"netrw",
				"netrwPlugin",
				"2html_plugin",
				"tohtml",
				"getscript",
				"getscriptPlugin",
				"logipat",
				"rrhelper",
				"spellfile_plugin",
				"vimball",
				"vimballPlugin",
			}
		}
	},
})


local function load_module(mod)
	local ok, m = pcall(require, mod)
	if ok and m.load then m.load() end
end

vim.defer_fn(function()
	load_module("vsix.ui")
	require("vsix.autocmds")
	require("vsix.autocmp")
	require("vsix.lspconf").load()

	if vim.fn.argv(0) == "" then
		pcall(function() require("vsix.menu").load() end)
	end
end, 0)
