local utils = require("vsix.util")

-- the vsix_print function only prints output if
-- debug_mode global was set on launch
-- eg: nvim --cmd "lua vim.g.debug_mode = 1"
if vim.g.debug_mode then
	utils.initialize_debug_log()
end
utils.debug_log("Start of \"init.lua\"")

utils.vsix_require("vsix.globals")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)


utils.vsix_require("vsix.keymaps")
utils.vsix_require("vsix.opts")


local plugins_spec = {}

utils.debug_log("Loading plugins")
table.insert(plugins_spec, { import = "plugins.treesitter" })
utils.debug_log("Plugin: treesitter OK")
table.insert(plugins_spec, { import = "plugins.telescope" })
utils.debug_log("Plugin: telescope OK")
table.insert(plugins_spec, { import = "plugins.mason" })
utils.debug_log("Plugin: mason OK")
--table.insert(plugins_spec, { import = "plugins.colorizer" })

utils.debug_log("Setting up plugins: Lazy")
require("lazy").setup({
	spec = {
		plugins_spec,
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
utils.debug_log("Lazy done")

------------------------------------------------------------------------------------------------------

utils.debug_log("Initial \"init.lua\"")
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		utils.debug_log("Loading colorscheme")
		vim.cmd("colo zeus")
		vim.g.CUSTOM_COLORSCHEME = 1
		utils.debug_log("Set to: " .. vim.g.colors_name .. " Status: OK")

		local success, menu = pcall(require, "vsix.menu")
		utils.debug_log("Loading menu")
		if success then
			if vim.fn.argv(0) == "" then
				menu.load()
				utils.debug_log("Status: OK")
			end
		else
			utils.debug_log("Error: " .. menu)
		end

		local ok, statusline = pcall(require, "vsix.ui")
		utils.debug_log("Loading statusline")
		if ok then
			statusline.load()
			utils.debug_log("Status: OK")
		else
			utils.debug_log("Error: " .. statusline)
		end

		utils.vsix_require("vsix.autocmds")
		local ts_ok, ts = pcall(require, "plugins.treesitter")
		utils.debug_log("Loading treestitter")
		if ts_ok then
			ts.config()
		else
			print("Error: " .. ts)
			utils.debug_log("Error: " .. ts)
		end

		local lsp_ok, lspconf = pcall(require, "vsix.lspconfig")
		utils.debug_log("Loading lspconfig")
		if lsp_ok then
			utils.debug_log("Setting up: lspconfig")
			lspconf.load()
			utils.debug_log("Status: OK")
		else
			print("Error: " .. lspconf)
			utils.debug_log("Error: " .. lspconf)
		end

		utils.vsix_require("vsix.autocmp")
	end,
})


vim.defer_fn(function()
	utils.debug_log("End of \"init.lua\"")
end, 100)
------------------------------------------------------------------------------------------------------
