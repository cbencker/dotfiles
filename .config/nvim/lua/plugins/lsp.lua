-- Disable LSP folding and use Treesitter folds instead.
-- If folds are not saving correctly in LSP-managed buffers,
-- double check that `:verbose set foldexpr` is using
-- `v:lua.LazyVim.treesitter.foldexpr()` instead of
-- `v:lua.vim.lsp.foldexpr()`. This may be saved in view
-- or session data.
return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            folds = {
                enabled = false,
            },
        },
    },
}
