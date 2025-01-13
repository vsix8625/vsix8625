Servers = { "clangd", "pyright", "bashls", "html", "lemminx" }

local M = {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "neovim/nvim-lspconfig",
  },
}

function M.config()
  vim.defer_fn(function()
    require("mason").setup {
      build = ":MasonUpdate",
      ui = {
        border = "rounded",
        width = 0.60,
        height = 0.40,
      },
    }
    require("mason-lspconfig").setup {
      ensure_installed = Servers
    }
  end, 20)
end

return M
