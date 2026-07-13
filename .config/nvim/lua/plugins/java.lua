-- ~/.config/nvim/lua/plugins/java.lua

-- Don't set up on non-Windows machines
if vim.fn.has("win32") == 0 then
    return {}
end

return {
    {
        "mfussenegger/nvim-jdtls",
        opts = function(_, opts)
            local jdtls_exe = vim.fn.exepath("jdtls")
            local jdk25_java = "C:/Program Files/Eclipse Adoptium/jdk-25.0.3.9-hotspot/bin/java.exe"
            -- Run jdtls with JDK 25
            -- The --java-executable option gets passed through Mason scripts
            -- to a Python script where it will ultimately be used (instead of
            -- JAVA_HOME, which needs to point to Java 11 for the projects I work on)
            opts.cmd = {
                jdtls_exe,
                "--java-executable=" .. jdk25_java,
            }

            -- Use JDK 11 for the Java code being analyzed
            opts.settings = vim.tbl_deep_extend("force", opts.settings or {}, {
                java = {
                    configuration = {
                        runtimes = {
                            {
                                name = "JavaSE-11",
                                path = "C:/Program Files/Java/jdk-11.0.26_4",
                                default = true,
                            },
                        },
                        updateBuildConfiguration = "disabled",
                    },
                    project = {
                        -- Don't write new entries to the .project file
                        resourceFilters = {},
                    },
                },
            })

            opts.init_options = vim.tbl_deep_extend("force", opts.init_options or {}, {
                settings = {
                    java = {
                        import = {
                            generatesMetadataFilesAtProjectRoot = false,
                        },
                    },
                },
            })

            return opts
        end,
    },
}
