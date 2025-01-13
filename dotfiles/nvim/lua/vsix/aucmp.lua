local OMNI = "omnifunc"
local KEYWORD = "keyword"

local function auto_complete()
  local line = vim.fn.getline('.')
  local col = vim.fn.col('.')
  local cursor = line:sub(1, col)
  local filetype = vim.bo.filetype

  if cursor == " " then
    return
  end

  local suggestion
  local keys

  if filetype == "lua" then
    suggestion = KEYWORD
  elseif filetype == "c" or filetype == "cpp" then
    suggestion = OMNI
  elseif filetype == "html" or filetype == "css" then
    suggestion = KEYWORD
  elseif filetype == "sh" then
    suggestion = KEYWORD
  elseif filetype == "text" then
    suggestion = " "
  else
    suggestion = KEYWORD
  end

  if suggestion == OMNI then
    keys = vim.api.nvim_replace_termcodes("<C-x><C-o>", true, false, true)
  elseif suggestion == KEYWORD then
    keys = vim.api.nvim_replace_termcodes("<C-n>", true, false, true)
  else
    keys = vim.api.nvim_replace_termcodes("<C-n>", true, false, true)
  end

  local success, error = pcall(vim.api.nvim_feedkeys, keys, 'i', false)
  if not success then
    print("Error: ", error)
    return
  end
end


vim.api.nvim_create_autocmd("TextChangedI", {
  pattern = { "*.c", "*.cpp", "*.lua", "*.html", "*.bash", "*.py" },
  callback = function()
    if vim.bo.filetype ~= "TelescopePrompt" then
      auto_complete()
    end
  end,
})
