--
--  ██████╗███╗   ███╗██████╗ ███████╗
-- ██╔════╝████╗ ████║██╔══██╗██╔════╝
-- ██║     ██╔████╔██║██║  ██║███████╗
-- ██║     ██║╚██╔╝██║██║  ██║╚════██║
-- ╚██████╗██║ ╚═╝ ██║██████╔╝███████║
--  ╚═════╝╚═╝     ╚═╝╚═════╝ ╚══════╝

-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local trim_group = vim.api.nvim_create_augroup("TrimWhitespace", { clear = true })

-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
    group = trim_group,
    pattern = "*",
    callback = function(args)
        local ignore = {
            markdown = true,
            gitcommit = true,
        }

        if ignore[vim.bo[args.buf].filetype] then
            return
        end

        local view = vim.fn.winsaveview()
        vim.cmd([[%s/\s\+$//e]]) -- Remove trailing whitespace
        vim.fn.winrestview(view)
    end,
})
