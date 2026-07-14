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
