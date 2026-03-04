{ lib, ... }:
{
  plugins.harpoon = {
    enable = true;
    settings = {
      menu = {
        width = lib.nixvim.mkRaw "vim.api.nvim_win_get_width(0) - 4";
      };
      settings = {
        save_on_toggle = true;
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>H";
      action = lib.nixvim.mkRaw ''
        function()
          require("harpoon"):list():add()
        end
      '';
      options.desc = "Harpoon File";
    }
    {
      mode = "n";
      key = "<leader>h";
      action = lib.nixvim.mkRaw ''
        function()
          local harpoon = require("harpoon")
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end
      '';
      options.desc = "Harpoon Quick Menu";
    }
    {
      mode = "n";
      key = "<leader>1";
      action = lib.nixvim.mkRaw ''
        function()
          require("harpoon"):list():select(1)
        end
      '';
      options.desc = "Harpoon to File 1";
    }
    {
      mode = "n";
      key = "<leader>2";
      action = lib.nixvim.mkRaw ''
        function()
          require("harpoon"):list():select(2)
        end
      '';
      options.desc = "Harpoon to File 2";
    }
    {
      mode = "n";
      key = "<leader>3";
      action = lib.nixvim.mkRaw ''
        function()
          require("harpoon"):list():select(3)
        end
      '';
      options.desc = "Harpoon to File 3";
    }
    {
      mode = "n";
      key = "<leader>4";
      action = lib.nixvim.mkRaw ''
        function()
          require("harpoon"):list():select(4)
        end
      '';
      options.desc = "Harpoon to File 4";
    }
    {
      mode = "n";
      key = "<leader>5";
      action = lib.nixvim.mkRaw ''
        function()
          require("harpoon"):list():select(5)
        end
      '';
      options.desc = "Harpoon to File 5";
    }
    {
      mode = "n";
      key = "<leader>6";
      action = lib.nixvim.mkRaw ''
        function()
          require("harpoon"):list():select(6)
        end
      '';
      options.desc = "Harpoon to File 6";
    }
    {
      mode = "n";
      key = "<leader>7";
      action = lib.nixvim.mkRaw ''
        function()
          require("harpoon"):list():select(7)
        end
      '';
      options.desc = "Harpoon to File 7";
    }
    {
      mode = "n";
      key = "<leader>8";
      action = lib.nixvim.mkRaw ''
        function()
          require("harpoon"):list():select(8)
        end
      '';
      options.desc = "Harpoon to File 8";
    }
    {
      mode = "n";
      key = "<leader>9";
      action = lib.nixvim.mkRaw ''
        function()
          require("harpoon"):list():select(9)
        end
      '';
      options.desc = "Harpoon to File 9";
    }
  ];
}
