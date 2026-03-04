{
  plugins = {
    bufferline = {
      enable = true;
      settings = {
        options = {
          close_command.__raw = ''
            function(n)
              local ok, snacks = pcall(require, "snacks")
              if ok and snacks.bufdelete then
                snacks.bufdelete(n)
                return
              end
              vim.cmd("bdelete " .. n)
            end
          '';
          right_mouse_command.__raw = ''
            function(n)
              local ok, snacks = pcall(require, "snacks")
              if ok and snacks.bufdelete then
                snacks.bufdelete(n)
                return
              end
              vim.cmd("bdelete " .. n)
            end
          '';
          diagnostics = "nvim_lsp";
          always_show_bufferline = false;
          diagnostics_indicator.__raw = ''
            function(_, _, diag)
              local icons = require("utils.icons").diagnostics
              local ret = (diag.error and icons.Error .. diag.error .. " " or "")
                .. (diag.warning and icons.Warn .. diag.warning or "")
              return vim.trim(ret)
            end
          '';
          offsets = [
            {
              filetype = "neo-tree";
              text = "Neo-tree";
              highlight = "Directory";
              text_align = "left";
            }
            {
              filetype = "snacks_layout_box";
            }
          ];
          get_element_icon.__raw = ''
            function(opts)
              local mini_icons_get
              do
                local ok, mini_icons = pcall(require, "mini.icons")
                if ok and mini_icons.get_icon then
                  mini_icons_get = mini_icons.get_icon
                end
              end

              if not mini_icons_get then
                return ""
              end

              local name = opts.buffer_name or opts.name or opts.filetype or ""
              local extension = opts.extension or vim.fn.fnamemodify(name, ":e")
              local ok, icon = pcall(mini_icons_get, name, extension)
              if ok and icon then
                return icon
              end

              return ""
            end
          '';
          separator_style = "thin";
          groups = {
            items = [
              {
                __raw = ''require("bufferline.groups").builtin.pinned:with({ icon = "" })'';
              }
            ];
          };
        };
      };
    };
    web-devicons.enable = true;
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>bp";
      action = "<Cmd>BufferLineTogglePin<CR>";
      options.desc = "Toggle Pin";
    }
    {
      mode = "n";
      key = "<leader>bP";
      action = "<Cmd>BufferLineGroupClose ungrouped<CR>";
      options.desc = "Delete Non-Pinned Buffers";
    }
    {
      mode = "n";
      key = "<leader>br";
      action = "<Cmd>BufferLineCloseRight<CR>";
      options.desc = "Delete Buffers to the Right";
    }
    {
      mode = "n";
      key = "<leader>bl";
      action = "<Cmd>BufferLineCloseLeft<CR>";
      options.desc = "Delete Buffers to the Left";
    }
    {
      mode = "n";
      key = "<S-h>";
      action = "<cmd>BufferLineCyclePrev<cr>";
      options.desc = "Prev Buffer";
    }
    {
      mode = "n";
      key = "<S-l>";
      action = "<cmd>BufferLineCycleNext<cr>";
      options.desc = "Next Buffer";
    }
    {
      mode = "n";
      key = "[b";
      action = "<cmd>BufferLineCyclePrev<cr>";
      options.desc = "Prev Buffer";
    }
    {
      mode = "n";
      key = "]b";
      action = "<cmd>BufferLineCycleNext<cr>";
      options.desc = "Next Buffer";
    }
    {
      mode = "n";
      key = "[B";
      action = "<cmd>BufferLineMovePrev<cr>";
      options.desc = "Move buffer prev";
    }
    {
      mode = "n";
      key = "]B";
      action = "<cmd>BufferLineMoveNext<cr>";
      options.desc = "Move buffer next";
    }
  ];
}
