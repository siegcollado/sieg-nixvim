local M = {}

local icons = _G.utils.icons
local progress = _G.utils.lualine.progress
local status = _G.utils.lualine.status

function M.build()
  local sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  }

  local inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  }

  local function insert_leftmost(component)
    table.insert(sections.lualine_a, component)
  end

  local function insert_left(component)
    table.insert(sections.lualine_c, component)
  end

  local function insert_right(component)
    table.insert(sections.lualine_x, component)
  end

  insert_leftmost({
    "mode",
    color = { gui = "bold" },
    separator = { left = "", right = "" },
    padding = { left = 1 },
    fmt = function()
      return " "
    end,
    draw_empty = true,
  })

  insert_left({
    "branch",
    separator = "",
    icon = "",
    padding = { left = 1, right = 1 },
  })

  insert_left({
    "diff",
    separator = "",
    symbols = {
      added = icons.git.added,
      modified = icons.git.modified,
      removed = icons.git.removed,
    },
    source = function()
      local gitsigns = vim.b.gitsigns_status_dict
      if gitsigns then
        return {
          added = gitsigns.added,
          modified = gitsigns.changed,
          removed = gitsigns.removed,
        }
      end
    end,
  })

  insert_right({
    function()
      return require("noice").api.status.mode.get()
    end,
    cond = function()
      return package.loaded["noice"] and require("noice").api.status.mode.has()
    end,
    color = function()
      return {
        fg = Snacks.util.color("Statement"),
        gui = "bold",
      }
    end,
    separator = "",
    padding = { left = 0, right = 1 },
    draw_empty = false,
  })

  insert_right({
    function(msg)
      local lsps = status.lsp(msg)
      local formatters = status.conform()
      if lsps == "" or formatters == "" then
        return ""
      end
      return table.concat({ lsps, formatters }, ",")
    end,
    color = { gui = "bold" },
    padding = { left = 0, right = 1 },
    separator = "",
    draw_empty = true,
  })

  insert_right({
    "filetype",
    icon_only = true,
    separator = "",
    padding = { left = 0, right = 1 },
    draw_empty = true,
  })

  insert_right({
    "location",
    separator = { left = "", right = "" },
    padding = { left = 1, right = 1 },
    draw_empty = true,
  })

  insert_right({
    progress.clockish,
    separator = "",
    padding = { left = 0, right = 2 },
    draw_empty = true,
  })

  return {
    sections = sections,
    inactive_sections = inactive_sections,
  }
end

return M
