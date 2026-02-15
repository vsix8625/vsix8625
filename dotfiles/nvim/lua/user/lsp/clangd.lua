local M = {}

function M.load()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	vim.lsp.config('clangd', {
		cmd = { 'clangd', '--clang-tidy', '--background-index', '--offset-encoding=utf-16' },
		filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
		root_markers = { '.clangd', 'compile_commands.json', '.clang-format' },
		settings = {
			clangd = {
				usePlaceholders = true,
				completeUnimported = true,
			},
		},
		capabilities = capabilities,
		on_attach = function(client, bufnr)
			local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
			local opts = { noremap = true, silent = true }

			buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
			buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
			buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)

			buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
			buf_set_keymap("n", "<C-s>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
			buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)

			buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
			buf_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
			buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)
			buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)
			buf_set_keymap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)

			buf_set_keymap("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>",
				opts)
			buf_set_keymap("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
			buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.format {async = true}<cr>", opts)
			buf_set_keymap("n", "<leader>ws", "<cmd>lua vim.lsp.buf.workspace_symbol()<cr>", opts)

			buf_set_keymap("n", "<leader>dh", "<cmd>lua vim.lsp.buf.document_highlight()<cr>", opts)
			buf_set_keymap("n", "<leader>dhc", "<cmd>lua vim.lsp.buf.clear_references()<cr>", opts)
			buf_set_keymap("n", "<leader>ds", "<cmd>lua vim.lsp.buf.document_symbol()<cr>", opts)

			buf_set_keymap("n", "<leader>cl", "<cmd>lua vim.lsp.codelens.run()<cr>", opts)
			buf_set_keymap("n", "<leader>clr", "<cmd>lua vim.lsp.codelens.refresh()<cr>", opts)
			buf_set_keymap("n", "<leader>ic", "<cmd>lua vim.lsp.buf.incoming_calls()<cr>", opts)
			buf_set_keymap("n", "<leader>oc", "<cmd>lua vim.lsp.buf.outgoing_calls()<cr>", opts)

			vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
			vim.cmd([[autocmd BufWritePre <buffer> lua vim.lsp.buf.format({async = false, timeout_ms= 3000})]])
		end,
		flags = {
			debounce_text_changes = 150,
		},
	})

	-- Enable the LSP server
	vim.lsp.enable('clangd')
end

return M
