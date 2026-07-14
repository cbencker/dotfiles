-- NOTE: AutoSession does not process hooks when manually using restore,
-- so we need our own functions to stop restoring a session if there
-- are unsaved buffers

local M = {}

function M.has_modified_buffers()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].modified then
            return true
        end
    end
    return false
end

function M.safe_restore(session)
    if M.has_modified_buffers() then
        vim.notify("Session restore cancelled: unsaved buffers exist.", vim.log.levels.WARN)
        return
    end

    vim.cmd("AutoSession restore" .. (session and (" " .. session) or ""))
end

function M.safe_search()
    if M.has_modified_buffers() then
        vim.notify("Session search cancelled: unsaved buffers exist.", vim.log.levels.WARN)
        return
    end

    vim.cmd("AutoSession search")
end

vim.api.nvim_create_user_command("SafeRestoreSession", function(opts)
    M.safe_restore(opts.args ~= "" and opts.args or nil)
end, {
    nargs = "?",
})

return M
