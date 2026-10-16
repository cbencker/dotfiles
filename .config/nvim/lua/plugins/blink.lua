local platform = require("config.platform")

return {
    {
        "saghen/blink.cmp",
        cond = platform.is_windows,
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
