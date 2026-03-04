{ lib, config, ... }:
{
  plugins.neo-tree = {
    enable = true;

    settings = {
      close_if_last_window = true;
      sources = [ "filesystem" ];
      open_files_do_not_replace_types = [
        "terminal"
        "Trouble"
        "trouble"
        "qf"
        "Outline"
      ];

      filesystem = {
        bind_to_cwd = false;
        follow_current_file = {
          enabled = true;
        };
        use_libuv_file_watcher = true;
      };

      window = {
        mappings = {
          "l" = "open";
          "h" = "close_node";
          "<space>" = "none";
          "Y" = lib.nixvim.mkRaw ''
            {
              function(state)
                local node = state.tree:get_node()
                local path = node:get_id()
                vim.fn.setreg("+", path, "c")
              end,
              desc = "Copy Path to Clipboard",
            }
          '';
          "O" = lib.nixvim.mkRaw ''
            {
              function(state)
                vim.ui.open(state.tree:get_node().path)
              end,
              desc = "Open with System Application",
            }
          '';
          "P" = lib.nixvim.mkRaw ''{ "toggle_preview", config = { use_float = false } }'';
        };
      };

      default_component_configs = {
        indent = {
          with_expanders = true;
          expander_collapsed = lib.nixvim.mkRaw ''require("utils.icons").ui.ArrowClosed'';
          expander_expanded = lib.nixvim.mkRaw ''require("utils.icons").ui.ArrowOpen'';
          expander_highlight = "NeoTreeExpander";
        };
        git_status = {
          symbols = {
            added = lib.nixvim.mkRaw ''require("utils.icons").git.added'';
            modified = lib.nixvim.mkRaw ''require("utils.icons").git.modified'';
            deleted = lib.nixvim.mkRaw ''require("utils.icons").git.removed'';
            renamed = lib.nixvim.mkRaw ''require("utils.icons").git.renamed'';
            unstaged = lib.nixvim.mkRaw ''require("utils.icons").git.unstaged'';
            staged = lib.nixvim.mkRaw ''require("utils.icons").git.staged'';
            untracked = lib.nixvim.mkRaw ''require("utils.icons").git.untracked'';
            conflict = lib.nixvim.mkRaw ''require("utils.icons").git.conflict'';
            ignored = lib.nixvim.mkRaw ''require("utils.icons").git.ignored'';
          };
        };
      };

      event_handlers = [
        {
          event = "file_moved";
          handler = lib.nixvim.mkRaw ''
            function(data)
              local ok_snacks, Snacks = pcall(require, "snacks")
              if ok_snacks and Snacks.rename and Snacks.rename.on_rename_file then
                Snacks.rename.on_rename_file(data.source, data.destination)
              end
            end
          '';
        }
        {
          event = "file_renamed";
          handler = lib.nixvim.mkRaw ''
            function(data)
              local ok_snacks, Snacks = pcall(require, "snacks")
              if ok_snacks and Snacks.rename and Snacks.rename.on_rename_file then
                Snacks.rename.on_rename_file(data.source, data.destination)
              end
            end
          '';
        }
      ];
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>fe";
      action = lib.nixvim.mkRaw ''
        function()
          require("neo-tree.command").execute({ toggle = true, dir = require("utils.root").get() })
        end
      '';
      options = {
        desc = "Explorer NeoTree (Root Dir)";
      };
    }
    {
      mode = "n";
      key = "<leader>fE";
      action = lib.nixvim.mkRaw ''
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
        end
      '';
      options = {
        desc = "Explorer NeoTree (cwd)";
      };
    }
    {
      mode = "n";
      key = "<leader>e";
      action = lib.nixvim.mkRaw ''
        function()
          require("neo-tree.command").execute({ toggle = true, dir = require("utils.root").get() })
        end
      '';
      options = {
        desc = "Explorer NeoTree (Root Dir)";
      };
    }
    {
      mode = "n";
      key = "<leader>E";
      action = lib.nixvim.mkRaw ''
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
        end
      '';
      options = {
        desc = "Explorer NeoTree (cwd)";
      };
    }
  ];

  autoCmd = [
    {
      event = "BufEnter";
      group = "Neotree_start_directory";
      desc = "Start Neo-tree with directory";
      once = true;
      callback = lib.nixvim.mkRaw ''
        function()
          if package.loaded["neo-tree"] then
            return
          end

          local stats = vim.uv.fs_stat(vim.fn.argv(0))
          if stats and stats.type == "directory" then
            require("neo-tree")
          end
        end
      '';
    }
    {
      event = "TermClose";
      pattern = "*lazygit";
      callback = lib.nixvim.mkRaw ''
        function()
          if package.loaded["neo-tree.sources.git_status"] then
            require("neo-tree.sources.git_status").refresh()
          end
        end
      '';
    }
  ];

  autoGroups = {
    Neotree_start_directory = {
      clear = true;
    };
  };

  # Add Neo-tree highlight groups to transparent plugin
  plugins.transparent = lib.mkIf config.sieg-nixvim.theme.transparent {
    settings.extra_groups = [
      "NeoTreeNormal"
      "NeoTreeNormalNC"
      "NeoTreeSignColumn"
    ];
  };
}
