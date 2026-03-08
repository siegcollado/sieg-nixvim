{ lib, config, ... }:
{
  plugins.mini = {
    enable = true;
    modules.files = {
      mappings = {
        go_in = "l";
        go_in_plus = "<CR>";
        go_out = "h";
        go_out_plus = "H";
        reset = "<BS>";
        reveal_cwd = "@";
        show_help = "g?";
        synchronize = "=";
        trim_left = "<";
        trim_right = ">";
        toggle_preview = "P";
      };

      windows = {
        max_number = lib.nixvim.mkRaw "math.huge";
        preview = false;
        width_focus = 40;
        width_nofocus = 20;
        width_preview = 40;
      };

      options = {
        permanent_delete = false;
        use_as_default_explorer = true;
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>fe";
      action = lib.nixvim.mkRaw ''
        function()
          local MiniFiles = require("mini.files")
          if not MiniFiles.close() then
            MiniFiles.open(_G.utils.root.get(), true)
          end
        end
      '';
      options = {
        desc = "Explorer MiniFiles (Root Dir)";
      };
    }
    {
      mode = "n";
      key = "<leader>fE";
      action = lib.nixvim.mkRaw ''
        function()
          local MiniFiles = require("mini.files")
          if not MiniFiles.close() then
            MiniFiles.open(vim.uv.cwd(), true)
          end
        end
      '';
      options = {
        desc = "Explorer MiniFiles (cwd)";
      };
    }
    {
      mode = "n";
      key = "<leader>e";
      action = lib.nixvim.mkRaw ''
        function()
          local MiniFiles = require("mini.files")
          if not MiniFiles.close() then
            MiniFiles.open(_G.utils.root.get(), true)
          end
        end
      '';
      options = {
        desc = "Explorer MiniFiles (Root Dir)";
      };
    }
    {
      mode = "n";
      key = "<leader>E";
      action = lib.nixvim.mkRaw ''
        function()
          local MiniFiles = require("mini.files")
          if not MiniFiles.close() then
            MiniFiles.open(vim.uv.cwd(), true)
          end
        end
      '';
      options = {
        desc = "Explorer MiniFiles (cwd)";
      };
    }
  ];

  autoCmd = [
    {
      event = "BufEnter";
      group = "Minifiles_start_directory";
      desc = "Start mini.files with directory";
      once = true;
      callback = lib.nixvim.mkRaw ''
        function()
          local MiniFiles = require("mini.files")
          if MiniFiles.get_explorer_state() ~= nil then
            return
          end

          local target = vim.fn.argv(0)
          if target == nil or target == "" then
            return
          end

          local stats = vim.uv.fs_stat(target)
          if stats and stats.type == "directory" then
            MiniFiles.open(target, true)
          end
        end
      '';
    }
    {
      event = "User";
      group = "Minifiles_actions";
      pattern = "MiniFilesBufferCreate";
      callback = lib.nixvim.mkRaw ''
        function(args)
          local MiniFiles = require("mini.files")
          local buf_id = args.data.buf_id

          local map = function(lhs, rhs, desc)
            vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
          end

          map("Y", function()
            local entry = MiniFiles.get_fs_entry()
            if entry then
              vim.fn.setreg("+", entry.path, "c")
            end
          end, "Copy Path to Clipboard")

          map("O", function()
            local entry = MiniFiles.get_fs_entry()
            if entry then
              vim.ui.open(entry.path)
            end
          end, "Open with System Application")
        end
      '';
    }
    {
      event = "User";
      group = "Minifiles_actions";
      pattern = "MiniFilesActionRename";
      callback = lib.nixvim.mkRaw ''
        function(args)
          local ok_snacks, Snacks = pcall(require, "snacks")
          if ok_snacks and Snacks.rename and Snacks.rename.on_rename_file then
            Snacks.rename.on_rename_file(args.data.from, args.data.to)
          end
        end
      '';
    }
    {
      event = "User";
      group = "Minifiles_actions";
      pattern = "MiniFilesActionMove";
      callback = lib.nixvim.mkRaw ''
        function(args)
          local ok_snacks, Snacks = pcall(require, "snacks")
          if ok_snacks and Snacks.rename and Snacks.rename.on_rename_file then
            Snacks.rename.on_rename_file(args.data.from, args.data.to)
          end
        end
      '';
    }
  ];

  autoGroups = {
    Minifiles_start_directory = {
      clear = true;
    };
    Minifiles_actions = {
      clear = true;
    };
  };

  plugins.transparent = lib.mkIf config.sieg-nixvim.theme.transparent {
    settings.extra_groups = [
      "MiniFilesNormal"
      "MiniFilesBorder"
      "MiniFilesCursorLine"
      "MiniFilesTitle"
    ];
  };
}
