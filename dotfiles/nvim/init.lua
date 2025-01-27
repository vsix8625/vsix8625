require("vsix.globals")
vim.cmd("colo neovimo")
require("vsix.statusline").load()

----------------------------------------------------------------------------------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

----------------------------------------------------------------------------------------------------

require("vsix.options")
require("vsix.keymaps")
require("vsix.aucmp")
require("vsix.aucmds")

----------------------------------------------------------------------------------------------------

local plugins_spec = {}
--if not vim.g.NEBULA_THEMES then
-- table.insert(plugins_spec, { import = "plugins.colorscheme" })
--end
table.insert(plugins_spec, { import = "plugins.treesitter" })
table.insert(plugins_spec, { import = "plugins.mason" })
table.insert(plugins_spec, { import = "plugins.telescope" })
table.insert(plugins_spec, { import = "plugins.colorizer" })

require("lazy").setup({
  spec = {
    plugins_spec,
  },
  checker = {
    enabled   = true,
    notify    = true,
    frequency = 3600,
  },
  change_detection = {
    enabled = true,
    notify  = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tutor",
        "zipPlugin",
      }
    }
  },
})

vim.defer_fn(function()
  vim.opt.syntax = "off"
  require("plugins.treesitter").config()
  require("vsix.lspconfig").load()
end, 30)
