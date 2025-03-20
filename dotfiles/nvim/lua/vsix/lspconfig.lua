local M = {}

function M.load()
	local lspconfig = require("lspconfig")

	lspconfig.clangd.setup {
		cmd = { "clangd", "--clang-tidy", "--background-index" },
		filetypes = { "c", "cpp", "objc", "objcpp" },
		root_dir = require 'lspconfig'.util.root_pattern(".clangd", "compile_command.json"),
		settings = {
			clangd = {
				usePlaceholders = true,
				completeUnimported = true,
			}
		}
	}

	lspconfig.lua_ls.setup({
		cmd = { "lua-language-server" },
		filetypes = { "lua" },
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim", "use" },
				},
				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
				},
				telemetry = {
					enable = false,
				},
			},
		},
	})

	lspconfig.pyright.setup {
		filetypes = { "python" },
		Settings = {
			pyright = {
				autoSearchPaths = true
			}
		}
	}


	lspconfig.bashls.setup {
		filetypes = { "sh" },
	}

	local function on_attach(client, bufnr)
		local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
		local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

		buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

		local opts = { noremap = true, silent = true }

		buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)

		buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
		buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
		buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
		buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
		buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)

		buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
		buf_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
		buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)
		buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)
		buf_set_keymap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)

		buf_set_keymap("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>", opts)
		buf_set_keymap("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
		buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.format {async = true}<cr>", opts)
		buf_set_keymap("n", "<leader>ws", "<cmd>lua vim.lsp.buf.workspace_symbol()<cr>", opts)
		buf_set_keymap("n", "<leader>lc", "<cmd>lua print(vim.inspect(vim.lsp.buf_get_clients()))<cr>", opts)

		buf_set_keymap("n", "<leader>dh", "<cmd>lua vim.lsp.buf.document_highlight()<cr>", opts)
		buf_set_keymap("n", "<leader>dhc", "<cmd>lua vim.lsp.buf.clear_references()<cr>", opts)
		buf_set_keymap("n", "<leader>ds", "<cmd>lua vim.lsp.buf.document_symbol()<cr>", opts)
		buf_set_keymap("n", "<leader>cl", "<cmd>lua vim.lsp.codelens.run()<cr>", opts)
		buf_set_keymap("n", "<leader>clr", "<cmd>lua vim.lsp.codelens.refresh()<cr>", opts)
		buf_set_keymap("n", "<leader>ic", "<cmd>lua vim.lsp.buf.incoming_calls()<cr>", opts)
		buf_set_keymap("n", "<leader>oc", "<cmd>lua vim.lsp.buf.outgoing_calls()<cr>", opts)

		vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
		vim.cmd([[autocmd BufWritePre <buffer> lua vim.lsp.buf.format(nil, 1000)]])
	end

	for _, lsp in pairs(Servers) do
		lspconfig[lsp].setup {
			on_attach = on_attach,
			flags = {
				debounce_text_changes = 150,
			}
		}
	end
end

return M
