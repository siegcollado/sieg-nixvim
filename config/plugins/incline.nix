{ pkgs, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [
    incline-nvim
  ];

  # globals.opts.showtabline = 0;

  extraConfigLua = ''
    local path = _G.utils.path
    local root = _G.utils.root
    local colors = _G.utils.colors
    local icons = _G.utils.icons
    local diagnostic_icon_set = icons.diagnostics or {}
    local title_bg = colors.get_bg("Normal") or colors.get_bg("CursorLine")
    local title_fg = colors.get_fg("CursorLineNr") or colors.get_fg("Normal")
    local title_fg_nc = colors.get_fg("LineNr") or colors.get_fg("Comment") or title_fg

    local function get_sign_icon(severity, name, fallback)
      local config = vim.diagnostic.config()
      local signs = config and config.signs
      local signs_text = type(signs) == "table" and signs.text or nil

      if type(signs_text) == "table" then
        local icon = signs_text[severity]
          or signs_text[vim.diagnostic.severity[severity]]
          or signs_text[string.lower(vim.diagnostic.severity[severity] or "")]
        if icon and icon ~= "" then
          return vim.trim(icon)
        end
      end

      local sign = vim.fn.sign_getdefined(name)[1]
      if sign and sign.text and sign.text ~= "" then
        return vim.trim(sign.text)
      end

      return fallback
    end

    local diagnostic_icons = {
      [vim.diagnostic.severity.ERROR] = diagnostic_icon_set.Error
        or get_sign_icon(vim.diagnostic.severity.ERROR, "DiagnosticSignError", "E"),
      [vim.diagnostic.severity.WARN] = diagnostic_icon_set.Warn
        or get_sign_icon(vim.diagnostic.severity.WARN, "DiagnosticSignWarn", "W"),
      [vim.diagnostic.severity.INFO] = diagnostic_icon_set.Info
        or get_sign_icon(vim.diagnostic.severity.INFO, "DiagnosticSignInfo", "I"),
      [vim.diagnostic.severity.HINT] = diagnostic_icon_set.Hint
        or get_sign_icon(vim.diagnostic.severity.HINT, "DiagnosticSignHint", "H"),
    }

    local diagnostic_fgs = {
      [vim.diagnostic.severity.ERROR] = colors.get_fg("DiagnosticError") or colors.get_fg("DiagnosticSignError") or title_fg,
      [vim.diagnostic.severity.WARN] = colors.get_fg("DiagnosticWarn") or colors.get_fg("DiagnosticSignWarn") or title_fg,
      [vim.diagnostic.severity.INFO] = colors.get_fg("DiagnosticInfo") or colors.get_fg("DiagnosticSignInfo") or title_fg,
      [vim.diagnostic.severity.HINT] = colors.get_fg("DiagnosticHint") or colors.get_fg("DiagnosticSignHint") or title_fg,
    }

    local function diagnostics_chunks(buf)
      local counts = {
        [vim.diagnostic.severity.ERROR] = 0,
        [vim.diagnostic.severity.WARN] = 0,
        [vim.diagnostic.severity.INFO] = 0,
        [vim.diagnostic.severity.HINT] = 0,
      }

      for _, diag in ipairs(vim.diagnostic.get(buf)) do
        if counts[diag.severity] then
          counts[diag.severity] = counts[diag.severity] + 1
        end
      end

      local severities = {
        vim.diagnostic.severity.ERROR,
        vim.diagnostic.severity.WARN,
        vim.diagnostic.severity.INFO,
        vim.diagnostic.severity.HINT,
      }

      local has_diagnostics = false
      for _, severity in ipairs(severities) do
        local count = counts[severity]
        if count > 0 then
          has_diagnostics = true
          break
        end
      end

      if not has_diagnostics then
        return nil
      end

      local chunks = {}

      local first = true
      for _, severity in ipairs(severities) do
        local count = counts[severity]
        if count > 0 then
          if not first then
            table.insert(chunks, { " ", gui = "bold" })
          end

          table.insert(chunks, {
            diagnostic_icons[severity],
            gui = "NONE",
            guifg = diagnostic_fgs[severity],
          })
          table.insert(chunks, {
            " ",
            gui = "NONE",
            guifg = diagnostic_fgs[severity],
          })
          table.insert(chunks, {
            tostring(count),
            gui = "bold",
            guifg = diagnostic_fgs[severity],
          })
          first = false
        end
      end

      table.insert(chunks, { "  ", gui = "bold" })

      return chunks
    end

    require("incline").setup({
      hide = {
        cursorline = "smart",
      },
      window = {
        padding = 1,
        margin = {
          horizontal = 0,
          vertical = 0,
        },
        overlap = {
          winbar = true,
          statusline = true,
          tabline = true,
          borders = true,
        },
      },
      highlight = {
        groups = {
          InclineNormal = {
            default = true,
            guibg = "NONE",
            guifg = title_fg,
          },
          InclineNormalNC = {
            default = true,
            guibg = "NONE",
            guifg = title_fg_nc,
          },
        },
      },
      render = function(props)
        local buffer_name = vim.api.nvim_buf_get_name(props.buf)
        local file_path = vim.fn.fnamemodify(buffer_name, ":.:h")
        local filename = vim.fn.fnamemodify(buffer_name, ":t")
        local is_active_win = props.win == vim.api.nvim_get_current_win()
        local diagnostics = is_active_win and diagnostics_chunks(props.buf) or nil

        if filename == "" then
          return {}
        end

        local chunks = {}

        if diagnostics then
          for _, chunk in ipairs(diagnostics) do
            table.insert(chunks, chunk)
          end
        end

        table.insert(chunks, { root.pretty_print_path(file_path), gui = "italic" })
        table.insert(chunks, { filename, gui = "bold" })

        return chunks
      end,
    })
  '';
}
