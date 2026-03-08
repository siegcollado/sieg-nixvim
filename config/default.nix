{
  imports = [
    ./options.nix
    ./sieg-nixvim/options
    ./autocmds.nix
    ./diagnostics.nix
    ./keymaps
    ./plugins
  ];

  extraFiles = {
    "lua/utils/colors.lua".source = ./lua/utils/colors.lua;
    "lua/utils/icons.lua".source = ./lua/utils/icons.lua;
    "lua/utils/root.lua".source = ./lua/utils/root.lua;
    "lua/utils/path.lua".source = ./lua/utils/path.lua;
    "lua/utils/lualine/progress.lua".source = ./lua/utils/lualine/progress.lua;
    "lua/utils/lualine/sections.lua".source = ./lua/utils/lualine/sections.lua;
    "lua/utils/lualine/theme.lua".source = ./lua/utils/lualine/theme.lua;
    "lua/utils/lualine/status.lua".source = ./lua/utils/lualine/status.lua;
  };

  extraConfigLuaPre = ''
    _G.utils = _G.utils or {}

    local function require_utils(name)
      local ok, mod = pcall(require, name)
      if not ok then
        vim.notify("Missing utils module: " .. name, vim.log.levels.ERROR)
        return {}
      end
      return mod
    end

    _G.utils.path = require_utils("utils.path")
    _G.utils.icons = require_utils("utils.icons")
    _G.utils.colors = require_utils("utils.colors")
    _G.utils.lualine = _G.utils.lualine or {}
    _G.utils.lualine.progress = require_utils("utils.lualine.progress")
    _G.utils.lualine.status = require_utils("utils.lualine.status")
    _G.utils.lualine.theme = require_utils("utils.lualine.theme")
    _G.utils.lualine.sections = require_utils("utils.lualine.sections")
    _G.utils.root = require_utils("utils.root")
  '';
}
