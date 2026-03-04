local M = {}

local function build_progress_bar(icon_set)
  return function()
    local current_line = vim.fn.line(".")
    if current_line == 1 then
      return icon_set[1]
    end
    local total_lines = vim.fn.line("$")
    if current_line == total_lines then
      return icon_set[#icon_set]
    end

    local rest_of_icons = { unpack(icon_set, 2, #icon_set - 1) }
    local percentage = current_line / total_lines
    local index = math.ceil(percentage * #rest_of_icons)
    return rest_of_icons[index]
  end
end

M.clockish = build_progress_bar({
  "󰽤",
  "󰪞",
  "󰪟",
  "󰪠",
  "󰪡",
  "󰪢",
  "󰪣",
  "󰪤",
  "󰪥",
})

M.moon = build_progress_bar({
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
})

M.bar = build_progress_bar({
  " ",
  "▁",
  "▂",
  "▃",
  "▄",
  "▅",
  "▆",
  "▇",
  "█",
})

return M
