local utils = require("vsix.util")

vim.defer_fn(function()
	local function set_keymap(key, action, mode)
		vim.keymap.set(mode, key, action, { noremap = true, silent = true })
	end

	local keymaps = {
		{ "<Space>", "",                    "n" },
		{ "<Esc>",   "<CMD>nohlsearch<CR>", "n" },
		{ "<C-i>",   "<C-i>",               "n" },
		{ "J",       ":m '>+1<cr>gv=gv",    "v" },
		{ "K",       ":m '<-2<cr>gv=gv",    "v" },

		{ ";", function()
			vim.fn.setreg("/", "TODO")
			vim.cmd("normal! n")
		end, "n", },
		{ ",", function()
			vim.fn.setreg("/", "NOTE")
			vim.cmd("normal! n")
		end, "n", },
		{ "<leader>w",         function() vim.cmd("w") end,                      "n", },
		{ "<leader>ww",        function() vim.cmd("w!") end,                     "n", },
		{ "<leader>so",        function() vim.cmd("so") end,                     "n", },
		{ "<leader>lf",        function() vim.cmd("luafile %") end,              "n", },
		{ "<F12>",             function() vim.cmd("wqa") end,                    "n", },
		{ "<C-F12>",           function() vim.cmd("qa!") end,                    "n", },

		-- copy whole file in clipboard
		{ "<leader>cm",        function() vim.cmd("normal! gg^VG\"+y") end,      "n", },
		-- copy selected lines in clipboard
		{ "<C-c>",             function() vim.cmd("normal! \"+y") end,           "v", },

		-- buffers
		{ "{",                 function() vim.cmd("bnext") end,                  "n", },
		{ "}",                 function() vim.cmd("bp") end,                     "n", },
		{ "<Home>",            function() vim.cmd("b1") end,                     "n", },
		{ "<leader><leader>e", function() vim.cmd("ColorizerToggle") end,        "n", },
		{ "<leader>ri",        function() vim.cmd("so " .. vim.env.MYVIMRC) end, "n", },

		-- splits
		{ "<C-h>",             "<C-w><C-h>",                                     "n", },
		{ "<C-l>",             "<C-w><C-l>",                                     "n", },
		{ "<C-j>",             "<C-w><C-j>",                                     "n", },
		{ "<C-k>",             "<C-w><C-k>",                                     "n", },
		{ "<leader><C-s>",     function() vim.cmd("V") end,                      "n", },
		{ "<leader><C-a>",     function() vim.cmd("split") end,                  "n", },



		{ "<leader>[",         utils.switch_cfile,                               "n", },
		{ "<leader>1", function()
			utils.flterminal()
		end, "n", },
	}

	utils.debug_log("[Keymaps]")
	for _, key in ipairs(keymaps) do
		set_keymap(key[1], key[2], key[3])
		utils.debug_log("Key: " .. key[1] .. " - Mode: " .. key[3])

		utils.debug_log("Type: " .. type(key[2]) .. " --> " .. tostring(key[2]))
	end
end, 2)
