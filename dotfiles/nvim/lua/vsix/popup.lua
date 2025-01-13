local M = {}

---@alias window_handle  integer
---@alias lua_table  table

--- Destroys an open window by id after desired time
---@param win_id window_handle The id of the window
---@param lifespan integer The lifetime of the window in MS
function M.WIN_Destroy(win_id, lifespan)
  lifespan = lifespan or 200
  vim.defer_fn(function()
    vim.api.nvim_win_close(win_id, true)
  end, lifespan)
end

--- Create a non-modifiable window
--- Example: Can be used in combination with WIN_Destroy(win_id,lifespan)
---          WIN_Destroy(WIN_Create(), 100)
---          This example will create a window and destroy it after 100 MS
---@param width integer Width of the window  | Default = 80
---@param height integer Height of the window  | Default = 2
---@param x integer The x position that will be created  | Default = 50
---@param y integer The y position that will be created  | Default = 20
---@param data_table lua_table The data that will be inserted in the floating window | Default = { "Such empty" }
---@return window_handle Window The window id
function M.WIN_Create(width, height, x, y, data_table)
  local line = vim.fn.line('.')
  local col = vim.fn.col('.')
  width = width or 20
  height = height or 2

  if line ~= vim.fn.line('$') - height - 1 then
    x = x or (line + height) - 1
  else
    x = x or (line - height)
  end

  y = y or col
  data_table = data_table or { "Such empty" }

  local bufnr = vim.api.nvim_create_buf(false, true)
  local win_opts = {
    relative = "editor",
    style = "minimal",
    width = width,
    height = height,
    row = y,
    col = x,
    border = "rounded",
  }

  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, data_table)

  vim.bo[bufnr].modifiable = false
  local success, win = pcall(vim.api.nvim_open_win, bufnr, false, win_opts)
  if not success then
    print("Error creating the window: ", win)
    return 1
  end
  return win
end

function M.WIN_Create_Temp(data_table, lifespan)
  local line = vim.fn.line('.') + 1
  local col = vim.fn.col('.')
  lifespan = lifespan or 1000
  data_table = data_table or { "Temp", "Window" }
  M.WIN_Destroy(M.WIN_Create(20, 2, line, col, data_table), lifespan)
end

return M
