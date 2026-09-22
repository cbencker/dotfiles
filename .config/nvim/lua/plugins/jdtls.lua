-- Suppress unnecessary language server notifications
return {
    {
        "mfussenegger/nvim-jdtls",
        opts = {
            jdtls = {
                handlers = {
                    -- Suppress "language/status" notifications
                    ["language/status"] = function() end,
                },
            },
        },
    },

    {
        "folke/noice.nvim",
        opts = {
            routes = {
                {
                    filter = {
                        event = "lsp",
                        kind = "progress",
                        cond = function(message)
                            -- Suppress progress notifications
                            local client = vim.tbl_get(message.opts, "progress", "client")
                            return client == "jdtls"
                        end,
                    },
                    opts = { skip = true },
                },
            },
        },
    },
}
