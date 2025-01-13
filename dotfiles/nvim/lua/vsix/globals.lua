vim.g.mapleader          = " "
vim.g.maplocalleader     = " "

vim.g.netrw_banner       = 0
vim.g.netrw_browse_split = 0
vim.g.netrw_mouse        = 2

--if false it will look for a colorscheme plugin
vim.g.NEBULA_THEMES      = true
vim.g.show_theme_name    = true
----------------------------------------------------------------------------------------------------
-- Hides cursor line while in Insert Mode
-- Requires restart after change the global to work
vim.g.DYNAMIC_CURSORLINE = true
----------------------------------------------------------------------------------------------------
-- the browser that "i" key will open in main menu
vim.g.BROWSER            = "!firefox --detach"
