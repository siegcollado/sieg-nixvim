{ lib, ... }:
{
  plugins.snacks = {
    enable = true;
    autoLoad = true;
    settings = {
      indent = {
        enable = true;
      };
      input = {
        enable = true;
      };
      notifier = {
        enable = true;
      };
      scope = {
        enable = true;
      };
      scroll = {
        enable = true;
      };
      statuscolumn = {
        enable = true;
      };
      words = {
        enable = true;
      };

      picker = {
        enable = true;
        win = {
          input = {
            keys = {
              "<A-c>" = [
                "toggle_cwd"
                {
                  mode = [
                    "n"
                    "i"
                  ];
                }
              ];
            };
          };
        };
        actions = {
          toggle_cwd = lib.nixvim.mkRaw ''
            function(picker)
              local cwd = picker:get_cwd()
              if cwd == vim.loop.cwd() then
                picker:set_cwd(picker:get_root())
              else
                picker:set_cwd(vim.loop.cwd())
              end
            end
          '';
        };
      };
    };
  };

  keymaps = [
    # Buffer management
    {
      mode = "n";
      key = "<leader>bd";
      action = lib.nixvim.mkRaw ''function() require("snacks").bufdelete() end'';
      options.desc = "Delete Buffer";
    }
    {
      mode = "n";
      key = "<leader>bo";
      action = lib.nixvim.mkRaw ''function() require("snacks").bufdelete.other() end'';
      options.desc = "Delete Other Buffers";
    }
    {
      mode = "n";
      key = "<leader>bD";
      action = "<cmd>bd<cr>";
      options.desc = "Delete Buffer and Window";
    }

    # Pickers
    {
      mode = "n";
      key = "<leader>,";
      action = lib.nixvim.mkRaw ''function() require("snacks").picker.buffers() end'';
      options.desc = "Buffers";
    }
    {
      mode = "n";
      key = "<leader>/";
      action = lib.nixvim.mkRaw ''function() require("snacks").picker.grep() end'';
      options.desc = "Grep (Root Dir)";
    }
    {
      mode = "n";
      key = "<leader>:";
      action = lib.nixvim.mkRaw ''function() require("snacks").picker.command_history() end'';
      options.desc = "Command History";
    }
    {
      mode = "n";
      key = "<leader><space>";
      action = lib.nixvim.mkRaw ''function() require("snacks").picker.files() end'';
      options.desc = "Find Files (Root Dir)";
    }
    {
      mode = "n";
      key = "<leader>n";
      action = lib.nixvim.mkRaw ''function() require("snacks").picker.notifications() end'';
      options.desc = "Notification History";
    }

    # File pickers
    {
      mode = "n";
      key = "<leader>fb";
      action = lib.nixvim.mkRaw ''function() require("snacks").picker.buffers() end'';
      options.desc = "Buffers";
    }
    {
      mode = "n";
      key = "<leader>fB";
      action = lib.nixvim.mkRaw ''function() require("snacks").picker.buffers({ hidden = true, nofile = true }) end'';
      options.desc = "Buffers (all)";
    }
    {
      mode = "n";
      key = "<leader>ff";
      action = lib.nixvim.mkRaw ''function() require("snacks").picker.files() end'';
      options.desc = "Find Files (Root Dir)";
    }
    {
      mode = "n";
      key = "<leader>fF";
      action = lib.nixvim.mkRaw ''function() require("snacks").picker.pick("files", { root = false }) end'';
      options.desc = "Find Files (cwd)";
    }
    {
      mode = "n";
      key = "<leader>fg";
      action = lib.nixvim.mkRaw ''function() require("snacks").picker.git_files() end'';
      options.desc = "Find Files (git-files)";
    }
    {
      mode = "n";
      key = "<leader>fr";
      action = lib.nixvim.mkRaw ''function() require("snacks").picker.recent() end'';
      options.desc = "Recent";
    }
    {
      mode = "n";
      key = "<leader>fR";
      action = lib.nixvim.mkRaw ''function() require("snacks").picker.recent({ filter = { cwd = true } }) end'';
      options.desc = "Recent (cwd)";
    }
    {
      mode = "n";
      key = "<leader>fp";
      action = lib.nixvim.mkRaw ''function() require("snacks").picker.projects() end'';
      options.desc = "Projects";
    }

    # Git pickers
    {
      mode = "n";
      key = "<leader>gd";
      action = lib.nixvim.mkRaw ''function() require("snacks").picker.git_diff() end'';
      options.desc = "Git Diff (hunks)";
    }
    {
      mode = "n";
      key = "<leader>gD";
      action = lib.nixvim.mkRaw ''function() require("snacks").picker.git_diff({ base = "origin", group = true }) end'';
      options.desc = "Git Diff (origin)";
    }
    {
      mode = "n";
      key = "<leader>gs";
      action = lib.nixvim.mkRaw ''function() require("snacks").picker.git_status() end'';
      options.desc = "Git Status";
    }
    {
      mode = "n";
      key = "<leader>gS";
      action = lib.nixvim.mkRaw ''function() require("snacks").picker.git_stash() end'';
      options.desc = "Git Stash";
    }
    {
      mode = "n";
      key = "<leader>gi";
      action = lib.nixvim.mkRaw ''function() require("snacks").picker.gh_issue() end'';
      options.desc = "GitHub Issues (open)";
    }
    {
      mode = "n";
      key = "<leader>gI";
      action = lib.nixvim.mkRaw ''function() require("snacks").picker.gh_issue({ state = "all" }) end'';
      options.desc = "GitHub Issues (all)";
    }
    {
      mode = "n";
      key = "<leader>gp";
      action = lib.nixvim.mkRaw ''function() require("snacks").picker.gh_pr() end'';
      options.desc = "GitHub Pull Requests (open)";
    }
    {
      mode = "n";
      key = "<leader>gP";
      action = lib.nixvim.mkRaw ''function() require("snacks").picker.gh_pr({ state = "all" }) end'';
      options.desc = "GitHub Pull Requests (all)";
    }
    {
      mode = "n";
      key = "<leader>gL";
      action = lib.nixvim.mkRaw ''function() require("snacks").picker.git_log() end'';
      options.desc = "Git Log (cwd)";
    }
    {
      mode = "n";
      key = "<leader>gb";
      action = lib.nixvim.mkRaw ''function() require("snacks").picker.git_log_line() end'';
      options.desc = "Git Blame Line";
    }
    {
      mode = "n";
      key = "<leader>gf";
      action = lib.nixvim.mkRaw ''function() require("snacks").picker.git_log_file() end'';
      options.desc = "Git Current File History";
    }
    {
      mode = "n";
      key = "<leader>gl";
      action = lib.nixvim.mkRaw ''
        function()
          local root = require("utils.root").git()
          require("snacks").picker.git_log({ cwd = root })
        end
      '';
      options.desc = "Git Log";
    }

    # Git browse
    {
      mode = [
        "n"
        "x"
      ];
      key = "<leader>gB";
      action = lib.nixvim.mkRaw ''function() require("snacks").gitbrowse() end'';
      options.desc = "Git Browse (open)";
    }
    {
      mode = [
        "n"
        "x"
      ];
      key = "<leader>gY";
      action = lib.nixvim.mkRaw ''
        function()
          require("snacks").gitbrowse({
            open = function(url)
              vim.fn.setreg("+", url)
            end,
            notify = false
          })
        end
      '';
      options.desc = "Git Browse (copy)";
    }

    # Lazygit
    {
      mode = "n";
      key = "<leader>gg";
      action = lib.nixvim.mkRaw ''
        function()
          if vim.g.lazygit_enabled == false or vim.fn.executable("lazygit") ~= 1 then
            vim.notify("lazygit not available", vim.log.levels.WARN)
            return
          end
          local root = require("utils.root").git()
          require("snacks").lazygit({ cwd = root })
        end
      '';
      options.desc = "Lazygit (Root Dir)";
    }
    {
      mode = "n";
      key = "<leader>gG";
      action = lib.nixvim.mkRaw ''
        function()
          if vim.g.lazygit_enabled == false or vim.fn.executable("lazygit") ~= 1 then
            vim.notify("lazygit not available", vim.log.levels.WARN)
            return
          end
          require("snacks").lazygit()
        end
      '';
      options.desc = "Lazygit (cwd)";
    }

    # Terminal
    {
      mode = "n";
      key = "<leader>fT";
      action = lib.nixvim.mkRaw ''function() require("snacks").terminal() end'';
      options.desc = "Terminal (cwd)";
    }
    {
      mode = "n";
      key = "<leader>ft";
      action = lib.nixvim.mkRaw ''
        function()
          local root = require("utils.root").get()
          require("snacks").terminal(nil, { cwd = root })
        end
      '';
      options.desc = "Terminal (Root Dir)";
    }
    {
      mode = [
        "n"
        "t"
      ];
      key = "<c-/>";
      action = lib.nixvim.mkRaw ''
        function()
          local root = require("utils.root").get()
          require("snacks").terminal(nil, { cwd = root })
        end
      '';
      options.desc = "Terminal (Root Dir)";
    }
    {
      mode = [
        "n"
        "t"
      ];
      key = "<c-_>";
      action = lib.nixvim.mkRaw ''
        function()
          local root = require("utils.root").get()
          require("snacks").terminal(nil, { cwd = root })
        end
      '';
      options.desc = "which_key_ignore";
    }

    # Misc
    {
      mode = "n";
      key = "<leader>qq";
      action = "<cmd>qa<cr>";
      options.desc = "Quit All";
    }
    {
      mode = "n";
      key = "<leader>ui";
      action = "vim.show_pos";
      options.desc = "Inspect Pos";
    }
    {
      mode = "n";
      key = "<leader>uI";
      action = lib.nixvim.mkRaw ''
        function()
          vim.treesitter.inspect_tree()
          vim.api.nvim_input("I")
        end
      '';
      options.desc = "Inspect Tree";
    }
  ];

  # NOTE: Toggle mappings for <leader>u* should live in which-key.nix or dedicated Lua file
}
