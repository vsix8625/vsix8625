vim.g.mapleader          = " "
vim.g.maplocalleader     = "\\"

vim.g.netrw_banner       = 0
vim.g.netrw_browse_split = 0
vim.g.netrw_mouse        = 2

vim.g.show_theme_name    = true

-----------------------------------------------------------

require("vsix.opts")
require("vsix.keymaps")

vim.cmd("colo zeus")
vim.g.CUSTOM_COLORSCHEME = 1

local utils              = require("vsix.util")


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
			event = { "BufReadPre", "BufNewFile" }
		},

		{
			import = "plugins.telescope",
			cmd = "Telescope",
		},

		{
			import = "plugins.nvim-lspconfig",
			event = { "BufReadPre", "BufNewFile" },
		},
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
			}
		}
	},
})


local function load_module(mod)
	local ok, m = pcall(require, mod)
	if ok and m.load then m.load() end
end

load_module("vsix.ui")
require("vsix.lspconf").load()
require("vsix.autocmds")
require("vsix.autocmp")

if vim.fn.argv(0) == "" then
	pcall(function() require("vsix.menu").load() end)
end
