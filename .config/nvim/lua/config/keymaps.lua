--
--  ██╗  ██╗███████╗██╗   ██╗███╗   ███╗ █████╗ ██████╗ ███████╗
--  ██║ ██╔╝██╔════╝╚██╗ ██╔╝████╗ ████║██╔══██╗██╔══██╗██╔════╝
--  █████╔╝ █████╗   ╚████╔╝ ██╔████╔██║███████║██████╔╝███████╗
--  ██╔═██╗ ██╔══╝    ╚██╔╝  ██║╚██╔╝██║██╔══██║██╔═══╝ ╚════██║
--  ██║  ██╗███████╗   ██║   ██║ ╚═╝ ██║██║  ██║██║     ███████║
--  ╚═╝  ╚═╝╚══════╝   ╚═╝   ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝     ╚══════╝

-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

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

-- Move buffer left/right in buffer line
vim.keymap.set("n", "<A-,>", ":BufferLineMovePrev<CR>", { desc = "Move buffer backward" })
vim.keymap.set("n", "<A-.>", ":BufferLineMoveNext<CR>", { desc = "Move buffer forward" })

-- Toggle fullscreen with F11
vim.keymap.set("n", "<F11>", ":let g:neovide_fullscreen = !g:neovide_fullscreen<CR>")
--
-- Use <ESC> to exit terminal mode
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
