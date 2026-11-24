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

-- Save and restore folds with views
local view_group = vim.api.nvim_create_augroup("AutoView", { clear = true })

-- Save view when leaving a window/buffer
vim.api.nvim_create_autocmd({ "BufWinLeave" }, {
    group = view_group,
    callback = function(args)
        if vim.bo[args.buf].buftype == "" then
            vim.cmd("silent! mkview")
        end
    end,
})

-- Load view when entering a buffer
vim.api.nvim_create_autocmd("BufWinEnter", {
    group = view_group,
    callback = function(args)
        if vim.bo[args.buf].buftype ~= "" or vim.api.nvim_buf_get_name(args.buf) == "" then
            return
        end

        -- Only load the view the first time this buffer is shown
        if vim.b[args.buf].view_loaded then
            return
        end
        vim.b[args.buf].view_loaded = true

        vim.schedule(function()
            -- Make sure we're still in the same buffer when the scheduled call runs
            if not (vim.api.nvim_buf_is_valid(args.buf) and vim.api.nvim_get_current_buf() == args.buf) then
                return
            end
            -- Remember where the cursor (and scroll position) is before the view runs
            local saved = vim.fn.winsaveview()
            vim.cmd("silent! loadview")
            -- Put it back; the view should only contribute folds
            pcall(vim.fn.winrestview, saved)
        end)
    end,
})

-- Disable semantic token highlighting for Java files, and only rely on Treesitter.
-- Semantic tokens cause highlighting to get out of sync for some reason.
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        if vim.bo[args.buf].filetype ~= "java" then
            return
        end

        vim.lsp.semantic_tokens.enable(false, {
            bufnr = args.buf,
        })
    end,
})

-- Use built-in formatting for Markdown files
vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        vim.opt_local.formatexpr = ""
        vim.opt_local.formatprg = ""
        vim.opt_local.textwidth = 100
        vim.opt_local.formatlistpat = [[^\s*[-*+]\s\+\|^\s*\d\+[.)]\s\+]]
        vim.opt_local.formatoptions:append("n") -- Recognize numbered lists
    end,
})
