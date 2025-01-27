local M = {
  "nvim-telescope/telescope.nvim",
  dependencies = { 'nvim-lua/plenary.nvim' },
}

----------------------------------------------------------------------------------------------------
local function find_files2()
  require("telescope.builtin").find_files({
    previewer = false,
    layout_strategy = "flex",
    layout_config = {
      width = 0.40,
      height = 0.90,
    },
	hidden = true,
	no_ignore = true,
  })
end
----------------------------------------------------------------------------------------------------

local function grep_word()
  local word = vim.fn.expand("<cword>")
  require("telescope.builtin").grep_string({
    previewer = false,
    search = word,
    layout_strategy = "flex",
    layout_config = {
      width = 0.50,
      height = 0.50,
    },
  })
end

local function grep_WORD()
  local word = vim.fn.expand("<cWORD>")
  require("telescope.builtin").grep_string({
    previewer = false,
    search = word,
    layout_strategy = "flex",
    layout_config = {
      width = 0.50,
      height = 0.50,
    },
  })
end


----------------------------------------------------------------------------------------------------

local function search_buffers()
  require("telescope.builtin").buffers({
    previewer = true,
    layout_strategy = "flex",
    layout_config = {
      width = 0.60,
      height = 0.30,
    },
  })
end
----------------------------------------------------------------------------------------------------

local function search_help_tags()
  require("telescope.builtin").help_tags({
    previewer = false,
    layout_strategy = "flex",
    layout_config = {
      width = 0.80,
      height = 0.30,
    },
  })
end
----------------------------------------------------------------------------------------------------

local function search_in_buffer()
  require("telescope.builtin").current_buffer_fuzzy_find({
    previewer = false,
    layout_strategy = "flex",
    layout_config = {
      width = 0.40,
      height = 0.10,
    },
  })
end
----------------------------------------------------------------------------------------------------

vim.keymap.set("n", "<leader><leader>n", function() grep_word() end, { noremap = true, silent = true })
vim.keymap.set("n", "<leader><leader>N", function() grep_WORD() end, { noremap = true, silent = true })
vim.keymap.set("n", "<leader><leader>h", function() search_help_tags() end, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>fu", function() search_in_buffer() end, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>s", function() find_files2() end, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>b", function() search_buffers() end, { noremap = true, silent = true })
vim.keymap.set("n", "<leader><leader>c", "<Esc>:Telescope commands<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-b>", "<Esc>:Telescope<CR>", { noremap = true, silent = true })

----------------------------------------------------------------------------------------------------

function M.lightsearch()
  find_files2()
end

return M

