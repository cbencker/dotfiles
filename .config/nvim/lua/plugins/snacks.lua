return {
    "folke/snacks.nvim",
    opts = {
        scroll = {
            enabled = true,
            animate = {
                duration = { step = 10, total = 100 },
                easing = "linear",
            },
        },
        picker = {
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
                        "*.o",
                        "*.so",
                        "*.a",
                        "*.exe",
                        "*.dll",
                        "*.pyc",
                        "*.class",
                    },
                },
            },
        },
        explorer = {
            files = {
                -- Show hidden files by default in the explorer
                hidden = true,
            },
        },
    },
}
