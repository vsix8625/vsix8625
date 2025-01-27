----------------------------------------------------------------------------------------------------

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup('nebula-highlight-yank', { clear = true }),
  callback = function()
    local hl_string = vim.api.nvim_get_hl_by_name("string", true)
    local fg_string = hl_string.foreground
    local string_fg_hex = string.format("#%06x", fg_string or 0)
    vim.api.nvim_set_hl(0, "yanking", { bg = string_fg_hex })

    vim.highlight.on_yank({ higroup = "yanking", timeout = 50 })
  end,
})



vim.api.nvim_create_autocmd("CmdlineEnter", {
  pattern = "*",
  callback = function()
    vim.api.nvim_set_option_value("cmdheight", 1, {})
  end,
})

vim.api.nvim_create_autocmd("CmdlineLeave", {
  pattern = "*",
  callback = function()
    vim.api.nvim_set_option_value("cmdheight", 0, {})
  end,
})

----------------------------------------------------------------------------------------------------

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "help", "qf", "startuptime" },
  callback = function()
    vim.cmd("nnoremap <buffer> q :close<CR>")
    vim.bo.buflisted = false
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "h", "cpp", "hpp" },
  callback = function()
    vim.api.nvim_set_option_value("omnifunc", "ccomplete#Complete", { buf = 0 })
    vim.api.nvim_set_option_value("cindent", true, { buf = 0 })
    vim.api.nvim_set_option_value("shiftwidth", 2, { buf = 0 })
    vim.api.nvim_set_option_value("tabstop", 2, { buf = 0 })   
  end,
})

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = "*.h",
  command = "set filetype=c",
})


vim.api.nvim_create_autocmd("FileType", {
  pattern = { "html" },
  callback = function()
    vim.api.nvim_set_option_value("omnifunc", "htmlcomplete#CompleteTags", { buf = 0 })
  end,
})

-- TODO: the omnifunc complete
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "xml" },
  callback = function()
    vim.bo.omnifunc = "xmlcomplete#CompleteTags"
    -- vim.api.nvim_set_option_value("omnifunc", "xmlcomplete#CompleteTags", { buf = 0 })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "*" },
  callback = function()
    if vim.bo.filetype ~= "homepage" and vim.bo.filetype ~= "TelescopeResults" then
      vim.opt.number = true
      vim.opt.relativenumber = true
    else
      vim.opt.number = false
      vim.opt.relativenumber = false
    end
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  callback = function()
    if vim.fn.argv(0) == "" then
      require("vsix.menu").load()
    end
  end,
})

--------------------------------------------------------------------------------------------

if vim.g.DYNAMIC_CURSORLINE then
  vim.api.nvim_create_autocmd("InsertEnter", {
    pattern = "*",
    callback = function()
      vim.o.cursorline = false
    end,
  })

  vim.api.nvim_create_autocmd("InsertLeave", {
    pattern = "*",
    callback = function()
      vim.o.cursorline = true
    end,
  })
end

vim.api.nvim_create_user_command("Browser", vim.g.BROWSER, {})
vim.api.nvim_create_user_command("OpenCD", "!xdg-open .", {})

