-- Recursively check if the cursor is in a <script> element
local function in_script()
    local node = vim.treesitter.get_node()

    while node do
        if node:type() == "script_element" then
            return true
        end
        node = node:parent()
    end

    return false
end

return {
    {
        "nvim-mini/mini.pairs",
        enabled = false,
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            local npairs = require("nvim-autopairs")
            local Rule = require("nvim-autopairs.rule")

            npairs.setup({
                check_ts = true,
            })

            -- Add a pair of double quotes after an equals sign for easier typing of HTML attributes
            npairs.add_rules({
                Rule("=", '""', { "html", "xml" }):set_end_pair_length(1):with_pair(function()
                    return not in_script()
                end),
            })
        end,
    },
}
