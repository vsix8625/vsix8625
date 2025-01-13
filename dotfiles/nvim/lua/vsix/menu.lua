local M = {}

local icons = {
  dir       = "\u{1F5C2}",
  new_file  = "\u{1f4c4}",
  magnifier = "\u{1f50e}",
  config    = "\u{1f527}",
  exit      = "\u{274c}",
  tree      = "\u{1f332}",
}

local function create_menu_item(icon, text, key)
  local text_width = 51
  local add_spaces = string.rep(" ", text_width - (#text + #key + 2))
  return string.format("%s %s%s%s", icon, text, add_spaces, key)
end

local function count_files_and_dirs()
  local current_dir = vim.fn.getcwd()
  local files = vim.fn.globpath(current_dir, "*", 0, 1)
  local dir_count = 0
  local file_count = 0

  for _, path in ipairs(files) do
    if vim.fn.isdirectory(path) == 1 then
      dir_count = dir_count + 1
    else
      file_count = file_count + 1
    end
  end
  return dir_count, file_count
end

local function get_modification_time()
  local current_dir = vim.fn.getcwd()
  local mtime = vim.fn.getftime(current_dir)
  if mtime == -1 then
    return "Unknown", 0
  end
  local mod_time = os.date("%d-%m-%Y %H:%M:%S", mtime)
  local current_time = os.time()
  local days = math.floor((current_time - mtime) / (24 * 60 * 60)) -- Calculate days
  return mod_time, days
end

local function update_nvim()
  vim.cmd("Lazy sync")
  vim.cmd("MasonUpdate")
  vim.cmd("TSUpdate")
end
vim.api.nvim_create_user_command("UpdateNvim", update_nvim, {})

local function init_menu()
  vim.cmd("enew")
  local bufnr = vim.api.nvim_get_current_buf()

  local pwd = vim.fn.getcwd()
  local dir_count, file_count = count_files_and_dirs()

  local lua_version = _VERSION
  local jit_v = jit and jit.version or "No JIT"
  local nvim_v = { vim.version().major, vim.version().minor, vim.version().patch }
  local mod_time, mod_time_days = get_modification_time()

  local header = {
    "",
    "",
    string.format("Current Directory: %s (%d dirs, %d files)", pwd, dir_count, file_count),
    string.format("Last Modified: %s (%d days ago)", mod_time, mod_time_days),
    "",
    create_menu_item(icons["dir"], "Open Directory", "(R) "),
    create_menu_item(icons["tree"], "Explorer (Netrw)", "(x) "),
    create_menu_item(icons["new_file"], "New File", "(n) "),
    create_menu_item(icons["magnifier"], "Find Files", "(f) "),
    create_menu_item(icons["config"], "Neovim Settings", "(C) "),
    create_menu_item(icons["config"], "Update", "(U) "),
    create_menu_item(icons["exit"], "Exit", "(q) "),
    "",
    string.format("Neovim: %d.%d.%d", nvim_v[1], nvim_v[2], nvim_v[3]),
    string.format("Lua: %s", lua_version),
    string.format("LuaJIT: %s", jit_v),
    "",
  }

  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, header)

  vim.api.nvim_buf_set_option(bufnr, 'filetype', 'homepage')
  vim.bo[bufnr].buftype = 'nofile'
  vim.bo[bufnr].bufhidden = 'hide'
  vim.bo[bufnr].swapfile = false

  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, "n", "R", ":!xdg-open .<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "x", ":Ex<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "n", ":enew <BAR> startinsert<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "f", ":Telescope find_files<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "C", ":edit ~/.config/nvim/init.lua<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "U", ":UpdateNvim<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "q", ":qa<CR>", opts)

  vim.defer_fn(function()
    vim.bo[bufnr].modifiable = false
  end, 80)
end

function M.load()
  init_menu()
end

return M
