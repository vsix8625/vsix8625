local M = {
	"nvim-treesitter/nvim-treesitter",
	"nvim-treesitter/playground",
}

function M.config()
	require("nvim-treesitter.configs").setup({
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		ensure_installed = {
			"c",
			"lua",
			"vim",
			"vimdoc",
			"query",
			"bash",
			"python",
			"cpp",
		},
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
		indent = {
			enable = true
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<CR>",
				scope_incremental = "<CR>",
				node_incremental = "<TAB>",
				node_decremental = "<S-TAB>",
			},
		},
		playground = { enable = true }
	})
end

return M
