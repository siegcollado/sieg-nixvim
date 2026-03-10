{
  lib,
  config,
  pkgs,
  ...
}:
{
  # edgy.nvim - Window layout management
  extraPlugins = with pkgs.vimPlugins; [
    edgy-nvim
  ];

  extraConfigLua = ''
    require("edgy").setup({
      bottom = {
        {
          title = "QuickFix",
          ft = "qf",
          size = { height = 0.4 },
        },
        {
          title = "Terminal",
          ft = "toggleterm",
          size = { height = 0.4 },
          filter = function(buf, win)
            return vim.api.nvim_win_get_config(win).relative == ""
          end,
        },
        {
          title = "Trouble",
          ft = "trouble",
          size = { height = 0.4 },
        },
      },
      left = {
        {
          title = "Aerial",
          ft = "aerial",
          size = { width = 40 },
          pinned = true,
          open = "AerialOpen",
        },
      },
      right = {
        {
          title = "Grug Far",
          ft = "grug-far",
          size = { width = 50 },
        },
        {
          title = "Agentic",
          ft = "agentic",
          size = { width = 50 },
        },
      },
      top = {},
      options = {
        left = { size = 40 },
        bottom = { size = 15 },
        right = { size = 50 },
        top = { size = 10 },
      },
      animate = {
        enabled = false,
      },
    })
  '';

  # Set required options for edgy
  opts = {
    laststatus = 3;
    splitkeep = "screen";
  };

  # Add edgy highlight groups to transparent plugin
  plugins.transparent = lib.mkIf config.sieg-nixvim.theme.transparent {
    settings.extra_groups = [
      "EdgyNormal"
      "EdgyWinBar"
    ];
  };
}
