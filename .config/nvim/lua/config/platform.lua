-- lua/config/platform.lua
--
-- Checks if the current platform is Windows or Linux.
-- Can be used to enable/disable plugins based on platform.

local M = {}

M.is_windows = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1

M.is_linux = vim.fn.has("linux") == 1

return M
