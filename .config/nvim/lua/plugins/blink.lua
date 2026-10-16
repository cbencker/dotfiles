return {
    {
        "saghen/blink.cmp",
        optional = true,
        opts = {
            completion = {
                list = {
                    selection = {
                        preselect = false,
                    },
                },
            },
            sources = {
                per_filetype = {
                    sql = { "dadbod", "buffer" },
                    mysql = { "dadbod", "buffer" },
                    plsql = { "dadbod", "buffer" },
                },
                providers = {
                    dadbod = {
                        name = "Dadbod",
                        module = "vim_dadbod_completion.blink",
                    },
                },
            },
        },
    },
}
