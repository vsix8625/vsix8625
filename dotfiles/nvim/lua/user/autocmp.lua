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
	if not should_auto_complete() then
		return
	end

	local suggestion
	local filetype = vim.bo.filetype

	if filetype == "c" or filetype == "cpp" then
		local has_lsp = vim.bo.omnifunc == "v:lua.vim.lsp.omnifunc"
		suggestion = has_lsp and OMNI or KEYWORD
	elseif filetype == "lua" then
		local has_lsp = vim.bo.omnifunc == "v:lua.vim.lsp.omnifunc"
		suggestion = has_lsp and OMNI or KEYWORD
	elseif filetype == "html" or filetype == "css" or filetype == "sh" then
		suggestion = KEYWORD
	elseif filetype == "text" then
		suggestion = " "
	else
		suggestion = KEYWORD
	end

	local keys = vim.api.nvim_replace_termcodes(
		suggestion == OMNI and "<C-x><C-o>" or "<C-n>", true, false, true
	)

	local success, error = pcall(vim.api.nvim_feedkeys, keys, 'i', false)
	if not success then
		print("Error: ", error)
	end
end

-- Auto trigger on text change in insert mode
vim.api.nvim_create_autocmd("TextChangedI", {
	pattern = { "*.c", "*.cpp" },
	callback = function()
		if should_auto_complete() then
			auto_complete()
		end
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
