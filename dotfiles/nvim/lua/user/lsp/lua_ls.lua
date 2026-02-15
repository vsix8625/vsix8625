local M = {}


function M.load()
	vim.lsp.config('lua_ls', {
		cmd = { '/usr/bin/lua-language-server' },
		filetypes = { 'lua' },

		root_markers = {
			'.luarc.json', '.luarc.jsonc', '.luacheckrc',
			'.stylua.toml', 'stylua.toml', '.git'
		},

		settings = {
			Lua = {
				runtime = { version = 'LuaJIT' },
				diagnostics = { globals = { 'vim' } },
				workspace = {
					library = {
						vim.fn.expand('$VIMRUNTIME/lua'),
						vim.fn.stdpath('config') .. '/lua',
					},
					checkThirdParty = false,
					maxPreload = 50,
					preloadFileSize = 100,
				},
				telemetry = { enable = false },
			},
		},

		on_attach = function(client, bufnr)
			vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
			vim.cmd([[autocmd BufWritePre <buffer> lua vim.lsp.buf.format({async = false, timeout_ms = 1000})]])
		end,

		flags = { debounce_text_changes = 150 },
	})


	vim.lsp.enable('lua_ls')
end

return M
