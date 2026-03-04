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
  plugins = {
    neotest.adapters = {
      jest = {
        enable = true;
        settings = {
          # Avoid glob() in fast event context by specifying config path
          # jestConfigFile = "jest.config.js";
          # Or use a function to dynamically find it
          jestConfigFile = lib.nixvim.mkRaw ''
            function()
              local root = require("utils.root")
              local configFile = nil
              vim.schedule(function()
                configFile = vim.fn.glob(root.cwd() .. "/jest.config.*")
              end)
              return configFile
            end
          '';
        };
      };
      vitest = {
        enable = true;
      };
    };

    conform-nvim.settings.formatters_by_ft = {
      javascript = biomeOrPrettier;
      javascriptreact = biomeOrPrettier;
      typescript = biomeOrPrettier;
      typescriptreact = biomeOrPrettier;

      # TODO: move me to json.nix?
      json = biomeOrPrettier;
      jsonc = biomeOrPrettier;
    };

    lsp.servers = {

      # NOTE: apparently this is slow on large projects, using vtsls instead
      # plugins.lsp.servers.ts_ls.enable = true;

      vtsls = {
        enable = true;
        filetypes = [
          "javascript"
          "javascriptreact"
          "javascript.jsx"
          "typescript"
          "typescriptreact"
          "typescript.tsx"
        ];
        settings = {
          complete_function_calls = true;

          vtsls = {
            enableMoveToFileCodeAction = true;
            autoUseWorkspaceTsdk = true;
            experimental = {
              maxInlayHintLength = 30;
              completion = {
                enableServerSideFuzzMatch = true;
              };
            };
          };

          typescript = {
            updateImportsOnFileMove = {
              enabled = "always";
            };
            suggest = {
              completeFunctionCalls = true;
            };
            inlayHints = {
              enumMemberValues = {
                enabled = true;
              };
              functionLikeReturnTypes = {
                enabled = true;
              };
              parameterNames = {
                enabled = "literals";
              };
              parameterTypes = {
                enabled = true;
              };
              propertyDeclarationTypes = {
                enabled = true;
              };
              variableTypes = {
                enabled = false;
              };
            };
          };
        };
      };

      tailwindcss = {
        enable = true;
        # rootMarkers = [
        #   "tailwind.config.js"
        #   "tailwind.config.cjs"
        #   "tailwind.config.mjs"
        #   "tailwind.config.ts"
        #   "tailwind.config.json"
        # ];
      };

      # TODO:  turn this off for biome?
      eslint = {
        enable = true;
        settings.workingDirectories.mode = "auto";
      };
    };
  };

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
