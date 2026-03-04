---@class CoreColors
local M = {}

---@param group string
---@param opts table
function M.override_style(group, opts)
  local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
  if not hl then
    return
  end

  if hl.link then
    local linked = vim.api.nvim_get_hl(0, { name = hl.link, link = false })
    if linked then
      hl = linked
    end
  end

  local merged = vim.tbl_extend("force", hl, opts or {})
  vim.api.nvim_set_hl(0, group, merged)
end

return M
