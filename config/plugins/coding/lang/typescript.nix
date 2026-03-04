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
in
{
  plugins.conform-nvim.settings.formatters_by_ft = {
    javascript = biomeOrPrettier;
    javascriptreact = biomeOrPrettier;
    typescript = biomeOrPrettier;
    typescriptreact = biomeOrPrettier;

    # TODO: move me to json.nix?
    json = biomeOrPrettier;
    jsonc = biomeOrPrettier;
  };

  # NOTE: apparently this is slow on large projects, consider using another
  # plugin
  plugins.lsp.servers.ts_ls.enable = true;

  # TODO: move this to json.nix as well?
  extraConfigLua = ''
    local lint = require("lint")
    local root = require("utils.root")

    if lint.linters.biomejs then
      lint.linters.biomejs.cmd = "biome"
    end

    _G.biome_filetypes = {
      javascript = true,
      javascriptreact = true,
      typescript = true,
      typescriptreact = true,
      json = true,
      jsonc = true,
    }

    function _G.has_biome_config(bufnr)
      return root.has_pattern(bufnr, { "biome.json", "biome.jsonc", "biome.yaml", "biome.yml" })
    end

    function _G.should_use_biome(bufnr)
      if not _G.biome_filetypes[vim.bo[bufnr].filetype] then
        return false
      end
      return _G.has_biome_config(bufnr)
    end
  '';

  autoCmd = [
    {
      event = [
        "BufReadPost"
        "BufWritePost"
        "InsertLeave"
      ];
      group = "Linting";
      callback = lib.nixvim.mkRaw ''
        function()
          local lint = require("lint")
          local bufnr = vim.api.nvim_get_current_buf()
          if _G.should_use_biome(bufnr) then
            lint.try_lint({ "biomejs" })
            return
          end
          lint.try_lint()
        end
      '';
    }
  ];

  autoGroups = {
    Linting = {
      clear = true;
    };
  };
}
