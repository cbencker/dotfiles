local has_session_script, session = pcall(require, "config.session")

---Insert an item into the Snacks dashboard key list immediately after the
---entry whose `key` matches `target_key`. If no matching entry is found,
---the item is appended to the end of the list.
---@param keys table The `opts.dashboard.preset.keys` array.
---@param target_key string The keybinding after which to insert `item`.
---@param item table The dashboard key entry to insert.
local function insert_after_key(keys, target_key, item)
    for i, existing in ipairs(keys) do
        if existing.key == target_key then
            table.insert(keys, i + 1, item)
            return
        end
    end

    table.insert(keys, item) -- Fall back to end
end

return {
    "folke/snacks.nvim",
    opts = function(_, opts)
        opts.scroll = vim.tbl_deep_extend("force", opts.scroll or {}, {
            enabled = true,
            animate = {
                duration = { step = 10, total = 100 },
                easing = "linear",
            },
        })

        opts.picker = vim.tbl_deep_extend("force", opts.picker or {}, {
            -- Show hidden files in file search pickers
            hidden = true,
            sources = {
                files = {
                    hidden = true,
                    ignored = false,
                    exclude = {
                        "**/.git",
                        "**/.cfg", -- Personal dotfiles git folder

                        -- Windows
                        "desktop.ini",
                        "ntuser.*",
                        "NTUSER.*",
                        "*.lnk",

                        -- Office
                        "*.doc",
                        "*.docx",
                        "*.xls",
                        "*.xlsx",
                        "*.ppt",
                        "*.pptx",
                        "*.pdf",

                        -- Binaries
                        "*.o",
                        "*.so",
                        "*.a",
                        "*.dll",
                        "*.exe",
                        "*.bin",
                        "*.dat",
                        "*.pyc",
                        "*.class",
                        "*.jar",
                        "*.ttf",

                        -- Media
                        "*.png",
                        "*.jpg",
                        "*.jpeg",
                        "*.gif",
                        "*.webp",
                        "*.mp3",
                        "*.mp4",
                        "*.mov",
                        "*.avi",

                        -- Archives
                        "*.zip",
                        "*.tar",
                        "*.gz",
                        "*.xz",
                        "*.7z",
                        "**/.git/*",

                        -- Build artifacts
                        "**/node_modules",
                        "**/dist",
                        "**/build",
                    },
                },
            },
        })

        opts.explorer = vim.tbl_deep_extend("force", opts.explorer or {}, {
            files = {
                -- Show hidden files by default in the explorer
                hidden = true,
            },
        })

        if has_session_script and opts.dashboard then
            local keys = opts.dashboard.preset.keys

            keys = vim.tbl_filter(function(item)
                return item.key ~= "p" -- Remove "Projects"
                    and item.key ~= "s" -- Remove "Restore Session"
                    and item.key ~= "c" -- Remove built-in "Config"
            end, keys)

            if session.exists("Home") then
                -- Add "Home"
                table.insert(keys, 1, {
                    icon = " ",
                    key = "h",
                    desc = "Home",
                    action = function()
                        session.safe_restore("Home")
                    end,
                })
            end

            -- Add "Select Session"
            insert_after_key(keys, "g", {
                icon = "󱐁 ",
                key = "s",
                desc = "Select Session",
                action = function()
                    session.safe_search()
                end,
            })

            if session.exists("Config") then
                -- Add "Config"
                insert_after_key(keys, "r", {
                    icon = " ",
                    key = "c",
                    desc = "Config",
                    action = function()
                        session.safe_restore("Config")
                    end,
                })
            end

            -- Set a new reference because tbl_filter gave us a new table
            opts.dashboard.preset.keys = keys
        end
    end,
}
