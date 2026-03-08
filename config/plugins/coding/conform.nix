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
  globals.autoformat = true;

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

  extraConfigLuaPre = ''
    vim.opt.formatexpr = "v:lua.require'conform'.formatexpr()"
  '';

  keymaps = [
    {
      mode = "n";
      key = "<leader>uf";
      action = lib.nixvim.mkRaw ''
        function()
          vim.g.autoformat = not vim.g.autoformat
          vim.notify("Autoformat: " .. (vim.g.autoformat and "on" or "off"))
        end
      '';
      options.desc = "Toggle Auto Format (Global)";
    }
    {
      mode = "n";
      key = "<leader>uF";
      action = lib.nixvim.mkRaw ''
        function()
          vim.b.autoformat = not vim.b.autoformat
          vim.notify("Buffer Autoformat: " .. (vim.b.autoformat and "on" or "off"))
        end
      '';
      options.desc = "Toggle Auto Format (Buffer)";
    }
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
