--
--     ██╗███╗  ██╗██╗████████╗
--     ██║████╗ ██║██║╚══██╔══╝
--     ██║██╔██╗██║██║   ██║
--     ██║██║╚████║██║   ██║
--     ██║██║ ╚███║██║   ██║
--     ╚═╝╚═╝  ╚══╝╚═╝   ╚═╝
--

-- Bootstrap lazy.nvim, LazyVim, and plugins
require("config.lazy")

if vim.fn.has("win32") == 1 then
    vim.o.guifont = "JetBrainsMonoNL Nerd Font:h10"
else
    vim.o.guifont = "JetBrainsMonoNL Nerd Font:h12"
end

-- Recommended for auto-session
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

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
