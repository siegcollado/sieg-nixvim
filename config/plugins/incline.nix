{ pkgs, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [
    incline-nvim
  ];

  # globals.opts.showtabline = 0;

  extraConfigLua = ''
    local path = require("utils.path")
    local root = require("utils.root")

    require("incline").setup({
      hide = {
        cursorline = "smart",
      },
      window = {
        padding = 0,
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
            group = "Normal",
          },
          InclineNormalNC = {
            default = true,
            group = "Comment",
          },
        },
      },
      render = function(props)
        local function pretty_print(file_path, length)
          if file_path == "" then
            return ""
          end

          local normalized_path = path.norm(file_path)
          local root_dir = root.get({ normalize = true })
          local cwd = root.cwd()

          local norm_path = normalized_path
          if norm_path:find(cwd, 1, true) == 1 then
            normalized_path = normalized_path:sub(#cwd + 2)
          end

          local sep = package.config:sub(1, 1)
          local parts = vim.split(normalized_path, "[\\/]")

          if length == 0 then
            parts = parts
          elseif #parts > length then
            parts = { parts[1], "…", unpack(parts, #parts - length + 2, #parts) }
          end

          local dir = ""
          if #parts > 1 then
            dir = table.concat({ unpack(parts, 1, #parts - 1) }, sep)
            dir = dir .. sep
          end

          return dir .. parts[#parts] .. sep
        end

        local buffer_name = vim.api.nvim_buf_get_name(props.buf)
        local file_path = vim.fn.fnamemodify(buffer_name, ":.:h")
        local filename = vim.fn.fnamemodify(buffer_name, ":t")

        if filename == "" then
          return {}
        end

        return {
          { pretty_print(file_path, 3), gui = "italic" },
          { filename, gui = "bold" },
        }
      end,
    })
  '';
}
