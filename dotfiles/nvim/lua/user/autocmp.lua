local function should_auto_complete()
	local line = vim.fn.getline('.')
	local col = vim.fn.col('.') - 1
	local cursor = line:sub(1, col)
	if col < 2 or cursor:match("%s$") then
		return false
	end
	if vim.tbl_contains({ "nofile", "prompt", "terminal", "acwrite" }, vim.bo.buftype) then
		return false
	end
	return true
end

local function auto_complete()
	-- All guards in one place
	if not should_auto_complete() then return end
	if vim.fn.pumvisible() == 1 then return end
	if vim.api.nvim_get_mode().mode ~= 'i' then return end

	local filetype = vim.bo.filetype
	local omni = vim.bo.omnifunc
	local has_lsp = omni == "v:lua.vim.lsp.omnifunc"
	local has_omni = omni ~= ""

	local suggestion
	if filetype == "c" or filetype == "cpp" or filetype == "lua" then
		suggestion = (has_lsp or has_omni) and "<C-x><C-o>" or "<C-n>"
	elseif filetype == "text" then
		return -- don't trigger anything in plain text
	else
		suggestion = "<C-n>"
	end

	vim.api.nvim_feedkeys(
		vim.api.nvim_replace_termcodes(suggestion, true, false, true),
		'n', false
	)
end

-- Single unified timer and autocmd
local completion_timer = vim.loop.new_timer()

vim.api.nvim_create_autocmd("TextChangedI", {
	pattern = { "*.c", "*.cpp", "*.lua" },
	callback = function()
		completion_timer:stop()
		-- 150ms gives you time to finish a keystroke before firing
		completion_timer:start(150, 0, vim.schedule_wrap(auto_complete))
	end,
})
