-- lua/plugins/dadbod.lua
--
-- Requires a file containing database connections.
-- File should be at /lua/config/db_connections.lua.
-- Connections file should look like the following:
--
--     return {
--         {
--             name = "TEST my_database",
--             url = "postgresql://postgres@192.168.0.1:5432/my_database"
--         },
--     }

local platform = require("config.platform")

return {
    {
        "tpope/vim-dadbod",
        cond = platform.is_windows,
        lazy = true,
    },
    {
        "kristijanhusak/vim-dadbod-ui",
        cond = platform.is_windows,
        dependencies = {
            { "tpope/vim-dadbod", lazy = true },
            {
                "kristijanhusak/vim-dadbod-completion",
                ft = { "sql", "mysql", "plsql" },
            },
        },
        init = function()
            if platform.is_windows then
                vim.g.dbs = require("config.db_connections")
                vim.g.db_ui_execute_on_save = 0
            end
        end,
        cmd = {
            "DBUI",
            "DBUIToggle",
            "DBUIAddConnection",
            "DBUIFindBuffer",
        },
    },
}
