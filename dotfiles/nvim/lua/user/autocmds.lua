vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.h",
	command = "set filetype=c",
})


------------------------------------------------------------------------------------------------------

vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		local success = pcall(vim.treesitter.start)

		if success then
			vim.bo.syntax = 'off'
		else
			vim.bo.syntax = 'on'
		end
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "help", "qf", "startuptime" },
	callback = function()
		vim.cmd("nnoremap <buffer> q :close<CR>")
		vim.bo.buflisted = false
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup('nebula-highlight-yank', { clear = true }),
	callback = function()
		vim.hl.on_yank({ higroup = "yanking", timeout = 80 })
	end,
})

-- Monolith files
local lith_group = vim.api.nvim_create_augroup("lith_files", { clear = true })

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	group = lith_group,
	pattern = "*.lith",
	callback = function()
		vim.bo.filetype = "monolith"

		vim.cmd("syntax sync fromstart")
		vim.cmd("setlocal syntax=c")

		for _, client in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
			client:detach(0)
		end

		-- apply C-specific buffer settings manually
		vim.opt_local.cindent = true
		vim.opt_local.shiftwidth = 4
		vim.opt_local.tabstop = 4
		vim.opt_local.omnifunc = "ccomplete#Complete"
	end,
})

vim.filetype.add({
	filename = {
		["Barrfile"] = "sh",
	},
})
