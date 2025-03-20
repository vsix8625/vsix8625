Servers = { "clangd", "pyright", "bashls", "lua_ls" }

local M = {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "neovim/nvim-lspconfig",
  },
}

function M.config()
    require("mason").setup {
      ui = {
        border = "rounded",
        width = 0.60,
        height = 0.40,
      },
    }
    require("mason-lspconfig").setup {
      ensure_installed = Servers
    }
end

return M

