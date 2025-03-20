vim.api.nvim_create_autocmd("FileType", {
	pattern = { "*" },
	callback = function()
		if vim.bo.filetype ~= "homepage" and vim.bo.filetype ~= "TelescopeResults" then
			vim.opt.number = true
			vim.opt.relativenumber = true
		else
			vim.opt.number = false
			vim.opt.relativenumber = false
		end
	end,
})

------------------------------------------------------------------------------------------------------

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "c", "h", "cpp", "hpp" },
	callback = function()
		vim.api.nvim_set_option_value("omnifunc", "ccomplete#Complete", { buf = 0 })
		vim.api.nvim_set_option_value("cindent", true, { buf = 0 })
		vim.api.nvim_set_option_value("shiftwidth", 2, { buf = 0 })
		vim.api.nvim_set_option_value("tabstop", 2, { buf = 0 })
	end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.h",
	command = "set filetype=c",
})


------------------------------------------------------------------------------------------------------

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
		vim.highlight.on_yank({ higroup = "yanking", timeout = 80 })
	end,
})
