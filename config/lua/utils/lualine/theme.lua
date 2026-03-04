local M = {}

function M.transparent_auto()
  local theme = require("lualine.themes.auto")
  if type(theme) == "function" then
    theme = theme()
  end

  local lualine_modes = { "insert", "normal", "visual", "command", "replace", "inactive", "terminal" }
  local lualine_sections = { "b", "c", "x", "y", "z" }
  for _, mode in ipairs(lualine_modes) do
    for _, section in ipairs(lualine_sections) do
      if theme[mode] and theme[mode][section] then
        theme[mode][section].bg = "None"
      end
    end
  end

  return theme
end

return M
