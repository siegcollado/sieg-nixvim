{ lib, ... }:
let
  formatOnSave = lib.nixvim.mkRaw ''
    function(bufnr)
      if vim.g.autoformat == false then
        return nil
      end
      if vim.b[bufnr].autoformat == false then
        return nil
      end
      return { timeout_ms = 3000, lsp_fallback = true }
    end
  '';
in
{
  plugins.conform-nvim = {
    enable = true;

    autoInstall.enable = true;

    settings = {
      default_format_opts = {
        lsp_fallback = true;
      };

      format_on_save = formatOnSave;
    };

  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>cF";
      action = lib.nixvim.mkRaw ''function() require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 }) end'';
      options.desc = "Format Injected Langs";
    }
    {
      mode = [
        "n"
        "x"
      ];
      key = "<leader>cf";
      action = lib.nixvim.mkRaw ''function() require("conform").format({ lsp_fallback = true }) end'';
      options.desc = "Format";
    }
  ];
}
