---@class CoreFeatures
local M = {}

---@param plugin string
---@return boolean
function M.has(plugin)
  local ok = pcall(require, plugin)
  return ok
end

---@param plugin string
---@param callback? fun(module: any)
---@return any|nil
function M.safe_require(plugin, callback)
  local ok, module = pcall(require, plugin)
  if not ok then
    return nil
  end
  if callback then
    callback(module)
  end
  return module
end

return M
