{
  lib,
  config,
  pkgs,
  ...
}:
let
  # Custom sand-style spinner animation frames
  sandSpinner = [
    "⠁"
    "⠂"
    "⠄"
    "⡀"
    "⡈"
    "⡐"
    "⡠"
    "⣀"
    "⣁"
    "⣂"
    "⣄"
    "⣌"
    "⣔"
    "⣤"
    "⣥"
    "⣦"
    "⣮"
    "⣶"
    "⣷"
    "⣿"
    "⡿"
    "⠿"
    "⢟"
    "⠟"
    "⡛"
    "⠛"
    "⠫"
    "⢋"
    "⠋"
    "⠍"
    "⡉"
    "⠉"
    "⠑"
    "⠡"
    "⢁"
  ];
in
{
  # agentic.nvim - Agentic Chat Interface with ACP providers
  # Not available as nixvim module, using extraPlugins
  extraPlugins = with pkgs.vimPlugins; [
    agentic-nvim
  ];

  extraConfigLua = ''
    require("agentic").setup({
      -- Default provider
      provider = "opencode-acp",
      
      -- Custom spinners (sand dropping animation)
      spinner_chars = {
        generating = ${lib.nixvim.lua.toLuaObject sandSpinner},
        thinking = ${lib.nixvim.lua.toLuaObject sandSpinner},
        searching = ${lib.nixvim.lua.toLuaObject sandSpinner},
        busy = ${lib.nixvim.lua.toLuaObject sandSpinner},
      },
      
      -- Custom keymaps
      keymaps = {
        widget = {
          close = "q",
          change_mode = {
            {
              "<S-Tab>",
              mode = { "i", "n", "v" },
            },
          },
          switch_provider = "<localleader>s",
        },
        prompt = {
          submit = {
            "<CR>",
            {
              "<C-s>",
              mode = { "i", "n", "v" },
            },
          },
          paste_image = {
            {
              "<localleader>p",
              mode = { "n" },
            },
            {
              "<C-v>",
              mode = { "i" },
            },
          },
          accept_completion = {
            {
              "<Tab>",
              mode = { "i" },
            },
          },
        },
        diff_preview = {
          next_hunk = "]c",
          prev_hunk = "[c",
        },
      },
    })
  '';

  # Agentic highlight groups using mini.base16 colors (nix-land)
  highlightOverride = {
    AgenticTitle = {
      bg = config.plugins.mini.modules.base16.palette.base0D;
      fg = config.plugins.mini.modules.base16.palette.base00;
      bold = true;
    };
    AgenticSpinnerGenerating = {
      fg = config.plugins.mini.modules.base16.palette.base0D;
      bold = true;
    };
    AgenticSpinnerThinking = {
      fg = config.plugins.mini.modules.base16.palette.base0E;
      bold = true;
    };
    AgenticSpinnerSearching = {
      fg = config.plugins.mini.modules.base16.palette.base0A;
      bold = true;
    };
    AgenticSpinnerBusy = {
      link = "Comment";
    };
    AgenticStatusPending = {
      bg = config.plugins.mini.modules.base16.palette.base0E;
      fg = config.plugins.mini.modules.base16.palette.base00;
    };
    AgenticStatusCompleted = {
      bg = config.plugins.mini.modules.base16.palette.base0B;
      fg = config.plugins.mini.modules.base16.palette.base00;
    };
    AgenticStatusFailed = {
      bg = config.plugins.mini.modules.base16.palette.base08;
      fg = config.plugins.mini.modules.base16.palette.base00;
    };
  };

  # Agentic keymaps - all under <leader>aa (agentic sub-group)
  keymaps = [
    {
      mode = [
        "n"
        "v"
      ];
      key = "<leader>aaa";
      action = lib.nixvim.mkRaw ''
        function() require("agentic").toggle() end
      '';
      options.desc = "Toggle Chat";
    }
    {
      mode = [ "n" ];
      key = "<leader>aan";
      action = lib.nixvim.mkRaw ''
        function() require("agentic").new_session() end
      '';
      options.desc = "New Session";
    }
    {
      mode = [
        "n"
        "v"
      ];
      key = "<leader>aae";
      action = lib.nixvim.mkRaw ''
        function() require("agentic").add_selection_or_file_to_context() end
      '';
      options.desc = "Add to Context";
    }
    {
      mode = [ "n" ];
      key = "<leader>aar";
      action = lib.nixvim.mkRaw ''
        function() require("agentic").restore_session() end
      '';
      options.desc = "Restore Session";
    }
  ];

  # Add which-key group
  plugins.which-key.settings.spec = lib.mkAfter [
    {
      __unkeyed-1 = "<leader>aa";
      group = "+agentic";
    }
  ];
}
