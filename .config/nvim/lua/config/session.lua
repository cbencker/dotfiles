-- Session utility functions
--
-- Auto-session does not invoke pre-restore hooks when sessions are restored
-- manually. These helpers provide a wrapper around session operations by:
--      - Preventing restores when modified buffers exist in the current session
--      - Automatically saving the current session when restoring another session
--      - Not saving the current session while in a suppressed directory

-- TODO: Also check `bypass_save_filetypes`

---@class Session
local M = {}
---Returns true if `dir` is an auto-session suppressed directory.
---@param dir string
---@return boolean
local function is_suppressed_dir(dir)
    dir = vim.fs.normalize(dir)

    ---@type string[]
    local suppressed_dirs = require("auto-session.config").options.suppressed_dirs or {}

    for _, suppressed in ipairs(suppressed_dirs) do
        suppressed = vim.fs.normalize(vim.fn.expand(suppressed))

        if dir == suppressed or vim.startswith(dir, suppressed .. "/") then
            return true
        end
    end

    return false
end

---Returns true if nvim currently has any modified buffers.
---@return boolean
local function has_modified_buffers()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].modified then
            return true
        end
    end
    return false
end

---Checks if a session with the name `name` exists. Case-sensitivity
---depends on the underlying filesystem.
---@param name string The name of the session to check for
---@return boolean
function M.exists(name)
    local dir = vim.fn.stdpath("data") .. "/sessions/"
    return vim.uv.fs_stat(dir .. name .. ".vim") ~= nil
end

---If there are no unsaved buffers, saves the current session, unless it
---is in auto-session's `config.options.suppressed_dirs` list. Then, restores `session`.
---@param session string The name of the session to restore
function M.safe_restore(session)
    if has_modified_buffers() then
        vim.notify("Session restore canceled: unsaved buffers exist.", vim.log.levels.WARN)
        return
    end

    if not is_suppressed_dir(vim.fn.getcwd()) then
        vim.cmd("AutoSession save")
    end

    vim.cmd("AutoSession restore" .. (session and (" " .. session) or ""))
end

---If there are no unsaved buffers, saves the current session, unless it
---is in auto-session's `config.options.suppressed_dirs` list. Then, opens
---auto-session's search picker.
function M.safe_search()
    if has_modified_buffers() then
        vim.notify("Session search canceled: unsaved buffers exist.", vim.log.levels.WARN)
        return
    end

    if not is_suppressed_dir(vim.fn.getcwd()) then
        vim.cmd("AutoSession save")
    end

    vim.cmd("AutoSession search")
end

return M
