---@class CoreColors
local M = {}

---@param value integer|nil
---@return string|nil
local function to_hex(value)
  if not value then
    return nil
  end

  return string.format("#%06x", value)
end

---@param group string
---@return table|nil
local function get_hl(group)
  local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
  if not hl then
    return nil
  end

  if hl.link then
    local linked = vim.api.nvim_get_hl(0, { name = hl.link, link = false })
    if linked then
      hl = linked
    end
  end

  return hl
end

---@param kind "fg"|"bg"
---@param group string
---@return string|nil
function M.get_color(kind, group)
  local hl = get_hl(group)
  if not hl then
    return nil
  end

  return to_hex(hl[kind])
end

---@param group string
---@return string|nil
function M.get_fg(group)
  return M.get_color("fg", group)
end

---@param group string
---@return string|nil
function M.get_bg(group)
  return M.get_color("bg", group)
end

---@param group string
---@param opts table
function M.override_style(group, opts)
  local hl = get_hl(group)
  if not hl then
    return
  end

  local merged = vim.tbl_extend("force", hl, opts or {})
  vim.api.nvim_set_hl(0, group, merged)
end

return M
