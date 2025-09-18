local M = {}

function M.load()
    local servers = {
        'clangd',
    }

    for _, server in ipairs(servers) do
        local ok, conf = pcall(require, 'vsix.lsp.'..server)
        if ok then
            conf.load()
        else
            print('Failed to load LSP: ' .. server)
        end
    end
end

return M

