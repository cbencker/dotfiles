--
--   ██████╗ ██████╗ ████████╗██╗ ██████╗ ███╗  ██╗███████╗
--  ██╔═══██╗██╔══██╗╚══██╔══╝██║██╔═══██╗████╗ ██║██╔════╝
--  ██║   ██║██████╔╝   ██║   ██║██║   ██║██╔██╗██║███████╗
--  ██║   ██║██╔═══╝    ██║   ██║██║   ██║██║╚████║╚════██║
--  ╚██████╔╝██║        ██║   ██║╚██████╔╝██║ ╚███║███████║
--   ╚═════╝ ╚═╝        ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚══╝╚══════╝

-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Spellfiles
-- By default, zg will put words into a private spellfile.
-- Running 2zg will use the global spellfile, which can be synced to Github
vim.opt.spellfile = {
    vim.fn.stdpath("config") .. "/spell/private.utf-8.add",
    vim.fn.stdpath("config") .. "/spell/global.utf-8.add",
}

-- Editing
vim.opt.clipboard = "unnamedplus" -- Integrate with system clipboard
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.shiftwidth = 4 -- Size of an indent
vim.opt.softtabstop = 4 -- Number of spaces tabs count for in edit
vim.opt.tabstop = 4 -- Number of spaces tabs count for
vim.opt.wrap = true -- Enable word wrapping
vim.opt.diffopt:append("vertical") -- Use vertical splits for :diffsplit

-- Markdown
vim.g.markdown_folding = 1 -- Allow folding markdown headings

-- Neovide settings
if vim.g.neovide == true then
    vim.g.neovide_cursor_animation_length = 0.05 -- Default 0.13
    vim.g.neovide_scroll_animation_length = 0.2 -- Default 0.3
    vim.g.neovide_progress_bar_enabled = false
end
