local OMNI = "omnifunc"
local KEYWORD = "keyword"

local function should_auto_complete()
	local line = vim.fn.getline('.')
	local col = vim.fn.col('.') - 1
	local cursor = line:sub(1, col)

	-- Require at least 2 characters before triggering completion
	if col < 2 or cursor:match("%s$") then
		return false
	end

	if vim.tbl_contains({ "nofile", "prompt", "terminal", "acwrite" }, vim.bo.buftype) then
		return false
	end

	return true
end

-- Function to trigger auto-suggestions
local function auto_complete()
	if not should_auto_complete() or vim.fn.pumvisible() == 1 then
		return
	end

	local suggestion
	local filetype = vim.bo.filetype
	local omni = vim.bo.omnifunc

	local has_lsp = omni == "v:lua.vim.lsp.omnifunc"

	if filetype == "c" or filetype == "cpp" then
		suggestion = (has_lsp or omni ~= "") and "<C-x><C-o>" or "<C-n>"
	elseif filetype == "lua" then
		suggestion = has_lsp and "<C-x><C-o>" or "<C-n>"
	elseif filetype == "html" or filetype == "css" or filetype == "sh" then
		suggestion = "<C-n>"
	elseif filetype == "text" then
		suggestion = " "
	else
		suggestion = "<C-n>"
	end

	local keys = vim.api.nvim_replace_termcodes(suggestion, true, false, true)
	-- 'n' flag prevents recursive mapping issues
	vim.api.nvim_feedkeys(keys, 'n', false)
end

local c_timer = vim.loop.new_timer()
vim.api.nvim_create_autocmd("TextChangedI", {
	pattern = { "*.c", "*.cpp" },
	callback = function()
		if not c_timer then
			c_timer = vim.loop.new_timer()
		end

		pcall(function() c_timer:stop() end)

		c_timer:start(150, 0, vim.schedule_wrap(function()
			if vim.api.nvim_get_mode().mode == 'i' then
				auto_complete()
			end
		end))
	end,
})

local function show_suggestions()
	local filetype = vim.bo.filetype
	if filetype == "lua" then
		vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-x><C-o>", true, false, true), "n")
	end
end

local timer = vim.loop.new_timer()
vim.api.nvim_create_autocmd("TextChangedI", {
	pattern = "*.lua",
	callback = function()
		timer:stop()
		timer:start(50, 0, vim.schedule_wrap(function()
			show_suggestions()
		end))
	end,
})
