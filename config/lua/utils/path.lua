---@class CorePath
local M = {}

---@param path string|nil
---@return string
function M.norm(path)
  if not path or path == "" then
    return ""
  end
  local normalized = vim.fs.normalize(path)
  return normalized
end

return M
