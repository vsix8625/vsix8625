local M = {}

local function module_name_from_file(file)
    return file:gsub("%.lua$", "")
end

function M.load()
    -- path to the lsp folder
    local lsps_path = vim.fn.stdpath("config") .. "/lua/vsix/lsp/"
    local files = vim.fn.glob(lsps_path .. "*.lua", true, true)

    for _, file in ipairs(files) do
        local mod_name = module_name_from_file(vim.fn.fnamemodify(file, ":t"))
        local ok, conf = pcall(require, "vsix.lsp." .. mod_name)
        if ok and conf and conf.load then
            conf.load()
        end
    end
end

return M

