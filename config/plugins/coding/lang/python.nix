{ lib, ... }:
{
  plugins = {
    conform-nvim.settings.formatters_by_ft.python = [ "black" ];

    neotest.adapters.python = {
      enable = true;
      settings = {
        is_test_file = lib.nixvim.mkRaw ''
          function(filename)
            return string.match(file_path, "test_.*%.py") ~= nil
          end
        '';
      };
    };
  };

  lsp.servers.pyright.enable = true;
}
