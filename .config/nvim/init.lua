--
--     ██╗███╗  ██╗██╗████████╗
--     ██║████╗ ██║██║╚══██╔══╝
--     ██║██╔██╗██║██║   ██║
--     ██║██║╚████║██║   ██║
--     ██║██║ ╚███║██║   ██║
--     ╚═╝╚═╝  ╚══╝╚═╝   ╚═╝
--

-- Bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.o.guifont = "JetBrainsMonoNL Nerd Font:h12"
-- Recommended for auto-session
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- Autocommands
local trim_group = vim.api.nvim_create_augroup("TrimWhitespace", { clear = true })

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

-- Commands
-- Create empty windows for diffing arbitrary text
vim.api.nvim_create_user_command("DiffScratch", function()
    vim.cmd("tabnew")
    vim.cmd("vnew")
    vim.cmd("setlocal buftype=nofile bufhidden=wipe noswapfile")
    vim.cmd("diffthis")
    vim.cmd("wincmd p")
    vim.cmd("setlocal buftype=nofile bufhidden=wipe noswapfile")
    vim.cmd("diffthis")
end, {})

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
end

-- Keymaps
-- Make arrow keys respect wrapped lines
vim.keymap.set("i", "<Up>", "<C-o>gk", { noremap = true })
vim.keymap.set("i", "<Down>", "<C-o>gj", { noremap = true })
vim.keymap.set({ "n", "v" }, "<Up>", "<C-o>gk", { noremap = true })
vim.keymap.set({ "n", "v" }, "<Down>", "<C-o>gj", { noremap = true })
vim.keymap.set("i", "jk", "<ESC>") -- Leave Insert mode with jk
vim.keymap.set("i", "<C-BS>", "<C-w>") -- Delete by word with Ctrl-BS
vim.keymap.set("i", "<S-Tab>", "<C-d>") -- Unindent with Shift-Tab
vim.keymap.set("n", "<CR>", "o") -- Enter to open a new line
vim.keymap.set("n", "<C-a>", "ggVG") -- Select all
vim.keymap.set("n", "<A-,>", ":BufferLineMovePrev<CR>", { desc = "Move buffer backward" }) -- Move buffer left in buffer line
vim.keymap.set("n", "<A-.>", ":BufferLineMoveNext<CR>", { desc = "Move buffer forward" }) -- Move buffer right in buffer line
vim.keymap.set("n", "<F11>", ":let g:neovide_fullscreen = !g:neovide_fullscreen<CR>") -- Toggle fullscreen with F11
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>") -- Use <ESC> to exit terminal mode
