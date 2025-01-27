local profile_options          = {
  { "guicursor",      "n-v-i-c:block-Cursor" },
  { "completeopt",    "menu,menuone,noselect" },
  { "pumheight",      10 },
  { "pumwidth",       20 },
  { "pumblend",       8 },
  { "laststatus",     3 },
  { "termguicolors",  true },
  { "number",         true },
  { "relativenumber", true },
  { "scrolloff",      8 },
  { "hlsearch",       true },
  { "incsearch",      true },
  { "showcmd",        false },
  { "showfulltag",    true },
  { "updatetime",     50 },
  { "timeoutlen",     300 },
  { "conceallevel",   0 },
  { "mouse",          "a" },
  { "showtabline",    1 },
  { "ignorecase",     true },
  { "smartcase",      true },
  { "showmode",       false },
  { "swapfile",       false },
  { "splitbelow",     true },
  { "splitright",     true },
  { "signcolumn",     "yes" },
  { "undofile",       true },
  { "inccommand",     "split" },
  { "writebackup",    false },
  { "smartindent",    true },
  { "expandtab",      false },
  { "shiftwidth",     4 },
  { "tabstop",        4 },
  { "softtabstop",    2 },
  { "numberwidth",    2 },
  { "cursorline",     true },
  { "spelllang",      "en_us" },
  { "cmdheight",      0 },
  { "scrolljump",     1 },
}

for _, opt in ipairs(profile_options) do
  local name, value = opt[1], opt[2]
  vim.opt[name] = value
end

vim.defer_fn(function()
  vim.opt.ruler = true
  vim.opt.spell = true
  vim.opt.wrap = false
  vim.opt.encoding = "utf-8"
  vim.opt.fileencoding = "utf-8"
  vim.opt.spelllang = "en_us"
  vim.opt.winblend = 5
  vim.opt.shortmess:append 'c'
  vim.opt.shortmess:append 'a'
  vim.opt.shortmess:append 'I'
  vim.opt.matchpairs:append "<:>"
end, 100)

