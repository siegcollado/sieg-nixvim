{ lib, ... }:
{
  plugins.persistence.enable = true;

  keymaps = [
    {
      mode = "n";
      key = "<leader>qs";
      action = lib.nixvim.mkRaw ''function() require("persistence").load() end'';
      options.desc = "Restore Session";
    }
    {
      mode = "n";
      key = "<leader>qS";
      action = lib.nixvim.mkRaw ''function() require("persistence").select() end'';
      options.desc = "Select Session";
    }
    {
      mode = "n";
      key = "<leader>ql";
      action = lib.nixvim.mkRaw ''function() require("persistence").load({ last = true }) end'';
      options.desc = "Restore Last Session";
    }
    {
      mode = "n";
      key = "<leader>qd";
      action = lib.nixvim.mkRaw ''function() require("persistence").stop() end'';
      options.desc = "Don't Save Current Session";
    }
  ];
}
