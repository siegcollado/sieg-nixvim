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
        {
          title = "Overseer",
          ft = "OverseerList",
          size = { height = 0.4 },
        },
      },
      left = {
        {
          title = "Neo-Tree",
          ft = "neo-tree",
          filter = function(buf)
            return vim.b[buf].neo_tree_source == "filesystem"
          end,
          size = { width = 40 },
          pinned = true,
          open = "Neotree filesystem",
        },
      },
      right = {
        {
          title = "Grug Far",
          ft = "grug-far",
          size = { width = 50 },
        },
        {
          title = "Symbols (aerial)",
          ft = "aerial",
          size = { width = 40 },
          pinned = true,
          open = "AerialOpen",
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

  # Keymaps for toggling specific right panels
  keymaps = [
    {
      mode = "n";
      key = "<leader>eg";
      action = "<cmd>GrugFar<CR>";
      options.desc = "Toggle Grug Far";
    }
    {
      mode = "n";
      key = "<leader>ea";
      action = "<cmd>AerialToggle<CR>";
      options.desc = "Toggle Aerial";
    }
    {
      mode = "n";
      key = "<leader>ev";
      action = "<cmd>AvanteToggle<CR>";
      options.desc = "Toggle Avante";
    }
    {
      mode = "n";
      key = "<leader>ec";
      action = "<cmd>edgy.close('right')<CR>";
      options.desc = "Close Right Panel";
    }
  ];

  # Add which-key group
  plugins.which-key.settings.spec = lib.mkAfter [
    {
      __unkeyed-1 = "<leader>e";
      group = "+edgy";
    }
  ];

  # Add edgy highlight groups to transparent plugin
  plugins.transparent = lib.mkIf config.transparent {
    settings.extra_groups = [
      "EdgyNormal"
      "EdgyWinBar"
    ];
  };
}
