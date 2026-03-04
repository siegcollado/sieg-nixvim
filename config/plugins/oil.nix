{ lib, ... }:
{
  plugins.oil = {
    enable = true;
    settings = {
      default_file_explorer = true;
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>fo";
      action = lib.nixvim.mkRaw ''function() require("oil").open() end'';
      options.desc = "Oil";
    }
    {
      mode = "n";
      key = "<leader>fO";
      action = lib.nixvim.mkRaw ''function() require("oil").open(vim.fn.getcwd()) end'';
      options.desc = "Oil (cwd)";
    }
  ];
}
