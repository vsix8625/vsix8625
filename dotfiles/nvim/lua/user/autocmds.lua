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
		vim.api.nvim_set_option_value("shiftwidth", 4, { buf = 0 })
		vim.api.nvim_set_option_value("tabstop", 4, { buf = 0 })

		vim.keymap.set('i', '<C-f>', function()
			local line = vim.api.nvim_get_current_line()
			local col = vim.api.nvim_win_get_cursor(0)[2]

			local before = line:sub(1, col)
			if before:match("%.$") then
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<BS>->", true, false, true), "n", false)
			else
				vim.cmd([[normal! F.s->]])
				vim.cmd([[startinsert]])
			end
		end)
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
