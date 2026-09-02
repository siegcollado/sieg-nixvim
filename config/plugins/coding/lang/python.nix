{ lib, ... }:
{
  plugins = {
    conform-nvim.settings.formatters_by_ft.python = {
      __unkeyed-1 = "ruff_format";
      __unkeyed-2 = "black";
      stop_after_first = true;
    };

    neotest.adapters.python = {
      enable = true;
      settings = {
        is_test_file = lib.nixvim.mkRaw ''
          function(filename)
            return string.match(filename, "test_.*%.py") ~= nil
          end
        '';
      };
    };
  };

  lsp.servers = {
    pyright.enable = true;
    ruff.enable = true;
  };
}
