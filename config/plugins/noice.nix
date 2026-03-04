{ lib, ... }:
{
  plugins = {
    noice.enable = true;
    nui.enable = true;
    which-key.settings.spec = [
      {
        __unkeyed-1 = "<leader>sn";
        desc = "Noice Keymaps (which-key)";
      }
    ];
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>snl";
      action = lib.nixvim.mkRaw ''function() require("noice").cmd("last") end'';
      options.desc = "Noice Last";
    }
    {
      mode = "n";
      key = "<leader>snh";
      action = lib.nixvim.mkRaw ''function() require("noice").cmd("history") end'';
      options.desc = "Noice History";
    }
    {
      mode = "n";
      key = "<leader>sna";
      action = lib.nixvim.mkRaw ''function() require("noice").cmd("all") end'';
      options.desc = "Noice All";
    }
    {
      mode = "n";
      key = "<leader>snd";
      action = lib.nixvim.mkRaw ''function() require("noice").cmd("dismiss") end'';
      options.desc = "Dismiss All";
    }
    {
      mode = "n";
      key = "<leader>snt";
      action = lib.nixvim.mkRaw ''function() require("noice").cmd("pick") end'';
      options.desc = "Noice Picker";
    }
    {
      mode = [
        "i"
        "n"
        "s"
      ];
      key = "<c-f>";
      action = lib.nixvim.mkRaw ''
        function()
          if not require("noice.lsp").scroll(4) then
            return "<c-f>"
          end
        end
      '';
      options = {
        silent = true;
        expr = true;
        desc = "Scroll Forward";
      };
    }
    {
      mode = [
        "i"
        "n"
        "s"
      ];
      key = "<c-b>";
      action = lib.nixvim.mkRaw ''
        function()
          if not require("noice.lsp").scroll(-4) then
            return "<c-b>"
          end
        end
      '';
      options = {
        silent = true;
        expr = true;
        desc = "Scroll Backward";
      };
    }
    {
      mode = "c";
      key = "<s-enter>";
      action = lib.nixvim.mkRaw ''function() require("noice").redirect(vim.fn.getcmdline()) end'';
      options.desc = "Redirect Cmdline";
    }
  ];

  # Note: The which-key group for "<leader>sn" should be added to which-key.nix
  # The require("noice").setup() call is handled automatically by Nixvim
}
