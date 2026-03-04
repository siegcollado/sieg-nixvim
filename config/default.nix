{
  imports = [
    ./options.nix
    ./autocmds.nix
    ./diagnostics.nix
    ./keymaps
    ./plugins
  ];

  extraFiles = {
    "lua/utils/colors.lua".source = ./lua/utils/colors.lua;
    "lua/utils/features.lua".source = ./lua/utils/features.lua;
    "lua/utils/icons.lua".source = ./lua/utils/icons.lua;
    "lua/utils/root.lua".source = ./lua/utils/root.lua;
    "lua/utils/path.lua".source = ./lua/utils/path.lua;
    "lua/utils/lualine/progress.lua".source = ./lua/utils/lualine/progress.lua;
    "lua/utils/lualine/sections.lua".source = ./lua/utils/lualine/sections.lua;
    "lua/utils/lualine/theme.lua".source = ./lua/utils/lualine/theme.lua;
    "lua/utils/lualine/status.lua".source = ./lua/utils/lualine/status.lua;
  };
}
