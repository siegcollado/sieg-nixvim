{ lib, config, ... }:
{
  plugins.overseer = {
    enable = true;
    settings = {
      # Task list configuration
      task_list = {
        default_detail = 1;
        max_width = {
          __raw = "function() return math.min(120, vim.o.columns * 0.5) end";
        };
        min_width = 40;
        width = 40;
        direction = "bottom";
        bindings = {
          "?" = "ShowHelp";
          "g?" = "ShowHelp";
          "<CR>" = "RunAction";
          "<C-e>" = "Edit";
          "o" = "Open";
          "<C-v>" = "OpenVsplit";
          "<C-s>" = "OpenSplit";
          "<C-f>" = "OpenFloat";
          "<C-q>" = "OpenQuickFix";
          "p" = "TogglePreview";
          "<C-l>" = "IncreaseDetail";
          "<C-h>" = "DecreaseDetail";
          "L" = "IncreaseAllDetail";
          "H" = "DecreaseAllDetail";
          "[" = "DecreaseWidth";
          "]" = "IncreaseWidth";
          "{" = "PrevTask";
          "}" = "NextTask";
          "<C-k>" = "ScrollOutputUp";
          "<C-j>" = "ScrollOutputDown";
          "q" = "Close";
        };
      };
      # Automatically detect tasks from various sources
      templates = [
        "builtin"
      ];
      # DAP integration
      dap = true;
      # Form configuration for task editor
      form = {
        border = "rounded";
        zindex = 40;
        min_width = 80;
        min_height = 10;
        win_opts = {
          winblend = 0;
        };
      };
      # Confirm configuration
      confirm = {
        border = "rounded";
        zindex = 40;
        min_width = 20;
        min_height = 6;
        win_opts = {
          winblend = 0;
        };
      };
      # Task window configuration
      task_win = {
        border = "rounded";
        padding = 2;
        win_opts = {
          winblend = 0;
        };
      };
      # Help window configuration
      help_win = {
        border = "rounded";
        padding = 2;
        win_opts = {
          winblend = 0;
        };
      };
      # Aliases for components
      component_aliases = {
        default = {
          __unkeyed-1 = "on_output_summarize";
          __unkeyed-2 = "on_exit_set_status";
          __unkeyed-3 = "on_complete_notify";
          __unkeyed-4 = "on_complete_dispose";
        };
        default_vscode = {
          __unkeyed-1 = "default";
          __unkeyed-2 = "on_result_diagnostics";
        };
      };
    };
  };

  # Keymaps for overseer
  keymaps = [
    {
      mode = "n";
      key = "<leader>por";
      action = "<cmd>OverseerRun<CR>";
      options.desc = "Run Task";
    }
    {
      mode = "n";
      key = "<leader>pot";
      action = "<cmd>OverseerToggle<CR>";
      options.desc = "Toggle Task List";
    }
    {
      mode = "n";
      key = "<leader>poc";
      action = "<cmd>OverseerClose<CR>";
      options.desc = "Close Task List";
    }
    {
      mode = "n";
      key = "<leader>poo";
      action = "<cmd>OverseerOpen<CR>";
      options.desc = "Open Task List";
    }
    {
      mode = "n";
      key = "<leader>poq";
      action = "<cmd>OverseerQuickAction<CR>";
      options.desc = "Quick Action";
    }
    {
      mode = "n";
      key = "<leader>poi";
      action = "<cmd>OverseerInfo<CR>";
      options.desc = "Task Info";
    }
    {
      mode = "n";
      key = "<leader>pob";
      action = "<cmd>OverseerBuild<CR>";
      options.desc = "Build Task";
    }
    {
      mode = "n";
      key = "<leader>poa";
      action = "<cmd>OverseerTaskAction<CR>";
      options.desc = "Task Action";
    }
    {
      mode = "n";
      key = "<leader>pos";
      action = "<cmd>OverseerSaveBundle<CR>";
      options.desc = "Save Task Bundle";
    }
    {
      mode = "n";
      key = "<leader>pol";
      action = "<cmd>OverseerLoadBundle<CR>";
      options.desc = "Load Task Bundle";
    }
    {
      mode = "n";
      key = "<leader>pod";
      action = "<cmd>OverseerDeleteBundle<CR>";
      options.desc = "Delete Task Bundle";
    }
  ];

  # Add which-key group
  plugins.which-key.settings.spec = lib.mkAfter [
    {
      __unkeyed-1 = "<leader>po";
      group = "+overseer";
    }
  ];
}
