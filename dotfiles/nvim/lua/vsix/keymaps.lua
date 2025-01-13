local map_set = function(mode, key, action, options)
  options = options or {}
  options.noremap = true
  options.silent = true
  vim.keymap.set(mode, key, action, options)
end

local keymaps = {
  { "n", "<Space>",           "" },
  { "n", "<C-i>",             "<C-i>" },
  { "v", "J",                 ":m '>+1<cr>gv=gv" },
  { "v", "K",                 ":m '<-2<cr>gv=gv" },

  { "n", "<Leader>mp",        function() vim.cmd("map") end },

  { "i", "<C-k>",             "<esc>" },
  { "t", '<Esc><Esc>',        '<C-\\><C-n>' },

  { "n", "<Esc>",             "<cmd>nohlsearch<CR>" },
  { "n", "<leader><leader>m", ":messages<CR>" },

  { { "n", "i", "v" }, "<C-s>", function()
    vim.cmd("silent wa")
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', true)
  end },

  { "n",                    "<leader>w",         function() vim.cmd("silent w") end },
  { "n",                    "<leader>r",         function() vim.cmd("so") end },
  { "n",                    "<leader>R",         function() vim.cmd("luafile %") end },
  { "n",                    "<F12>",             function() vim.cmd("wqa") end },
  { { "n", "i", "v", "t" }, "<C-F12>",           function() vim.cmd("qa!") end },
  { "n",                    "<leader><F12>",     function() vim.cmd("q") end },

  { "n",                    "<leader>.",         function() vim.cmd("Ex") end },
  { "n",                    "<leader>la",        function() vim.cmd("Lazy") end },

  { "n",                    "<leader>it",        function() vim.cmd("InspectTree") end },
  { "n",                    "<leader>is",        function() vim.cmd("Inspect") end },

  { "n",                    "<leader>ma",        function() vim.cmd("Mason") end },

  { "n",                    "<left>",            "<C-w><C-h>" },
  { "n",                    "<right>",           "<C-w><C-l>" },
  { "n",                    "<down>",            "<C-w><C-j>" },
  { "n",                    "<up>",              "<C-w><C-k>" },

  -- splits
  { "n",                    "<leader><leader>v", function() vim.cmd("V") end },
  { "n",                    "<leader><leader>s", function() vim.cmd("split") end },
  { "n",                    "<leader>cs",        "<C-W><C-S><CR>" },

  -- buffers jumps
  { "n",                    "{",                 function() vim.cmd("bnext") end },
  { "n",                    "}",                 function() vim.cmd("bp") end },
  { "n",                    "<Home>",            function() vim.cmd("b1") end },
  { "n",                    "<leader><leader>e", function() vim.cmd("ColorizerToggle") end },
  { "n",                    "<leader>ri",        function() vim.cmd("so " .. vim.env.MYVIMRC) end },
}

for _, map in ipairs(keymaps) do
  map_set(map[1], map[2], map[3])
end

vim.defer_fn(function()
  map_set("n", "<leader>o", function() vim.cmd("normal! o") end)
  map_set("n", "<leader>O", function() vim.cmd("normal! O") end)
  map_set("n", "<leader>,", function() vim.cmd("normal! *") end)

  map_set("n", "<leader><leader><leader><leader>", function() vim.cmd("LspInfo") end)

  map_set("n", "<leader><leader>t", function() vim.cmd("TSHighlightCapturesUnderCursor") end)
  map_set("n", "<leader><leader>nd", "<C-W><C-D>")
  

  -- selects all and copy to clipboard
  map_set("n", "<leader>cm", function()
    vim.cmd([[
    normal! gg^vG$
    normal! "+y
  ]])
  end)

  -- yanks paragraph and copy at the end of it
  map_set("n", "<leader><leader>yy", function()
    vim.cmd([[
    normal! yap}p
  ]])
  end)

  map_set("i", "<Tab>", function()
    return vim.fn.pumvisible() == 1 and "<C-n>" or "<Tab>"
  end, { expr = true })
end, 2500)


