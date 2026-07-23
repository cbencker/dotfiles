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
vim.keymap.set("i", "<Up>", "<C-o>gk")
vim.keymap.set("i", "<Down>", "<C-o>gj")
vim.keymap.set({ "n", "v" }, "<Up>", "gk")
vim.keymap.set({ "n", "v" }, "<Down>", "gj")

vim.keymap.set("i", "jk", "<ESC>", { desc = "Leave insert mode" })
vim.keymap.set("i", "<C-BS>", "<C-w>", { desc = "Delete by word" })
vim.keymap.set("n", "<C-a>", "ggVG", { desc = "Select all" })

-- Indenting
vim.keymap.set("i", "<S-Tab>", "<C-d>", { desc = "Indent left" })
vim.keymap.set("n", "<M-h>", "<<", { desc = "Indent left" })
vim.keymap.set("n", "<M-l>", ">>", { desc = "Indent right" })
vim.keymap.set({ "v", "x" }, "<M-h>", "<gv", { desc = "Indent left" })
vim.keymap.set({ "v", "x" }, "<M-l>", ">gv", { desc = "Indent right" })

-- Move buffer left/right in buffer line
vim.keymap.set("n", "<A-,>", "<Cmd>BufferLineMovePrev<CR>", { desc = "Move buffer left" })
vim.keymap.set("n", "<A-.>", "<Cmd>BufferLineMoveNext<CR>", { desc = "Move buffer right" })

-- Use <ESC> to exit terminal mode
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

-- Toggle fullscreen in Neovide
if vim.g.neovide then
    vim.keymap.set("n", "<F11>", function()
        vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
    end, { desc = "Toggle fullscreen" })
end
