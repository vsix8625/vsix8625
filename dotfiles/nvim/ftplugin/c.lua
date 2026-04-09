vim.opt_local.omnifunc = "ccomplete#Complete"
vim.opt_local.cindent = true
vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.spell = false
vim.opt_local.complete = ".,w,b,u"

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
end, { buffer = true })
