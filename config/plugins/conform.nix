{ lib, ... }:
let
  biomeOrPrettier = lib.nixvim.mkRaw ''
    function(bufnr)
      local root = require("utils.root")
      local has_biome_config = root.has_pattern(bufnr, { "biome.json", "biome.jsonc", "biome.yaml", "biome.yml" })
      if has_biome_config then
        return { "biome" }
      end
      return { "prettier" }
    end
  '';
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
    settings = {
      formatters_by_ft = {
        lua = [ "stylua" ];
        nix = [ "nixfmt" ];
        ruby = [ "rubocop" ];
        python = [ "black" ];
        javascript = biomeOrPrettier;
        javascriptreact = biomeOrPrettier;
        typescript = biomeOrPrettier;
        typescriptreact = biomeOrPrettier;
        json = biomeOrPrettier;
        jsonc = biomeOrPrettier;
        yaml = [ "prettier" ];
        yml = [ "prettier" ];
        markdown = [ "prettier" ];
        "markdown.mdx" = [ "prettier" ];
        toml = [ "taplo" ];
      };
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
  ];
}
