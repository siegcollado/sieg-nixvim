{ lib, pkgs, ... }:
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
              local root = _G.utils.root.get()
              return vim.fn.glob(root .. "/jest.config.*")
            end
          '';
        };
      };
      vitest = {
        enable = true;
      };
    };

    conform-nvim.settings.formatters_by_ft =
      let
        combined = {
          __unkeyed-1 = "biome";
          __unkeyed-2 = "prettier";
          stop_after_first = true;
        };
      in
      {
        javascript = combined;
        javascriptreact = combined;
        typescript = combined;
        typescriptreact = combined;

        # TODO: move me to json.nix?
        json = combined;
        jsonc = combined;
      };

    # conform's built-in biome formatter is only gated on the `biome`
    # executable existing on PATH, unlike the biome LSP server which
    # refuses to attach without a biome.json in the project. Without this,
    # any project with a global `biome` binary reachable on PATH would
    # silently pick biome over prettier via stop_after_first, even in
    # projects that never declared biome as a dependency.
    conform-nvim.settings.formatters.biome.condition = lib.nixvim.mkRaw ''
      function(self, ctx)
        local root_file = require("conform.util").root_file({
          "biome.json",
          "biome.jsonc",
          ".biome.json",
          ".biome.jsonc",
        })
        return root_file(self, ctx) ~= nil
      end
    '';
  };

  lsp.servers = {

    # NOTE: apparently this is slow on large projects, using vtsls instead
    # lsp.servers.ts_ls.enable = true;

    # NOTE: testing tsgo (native Go port, targets TS 6.0 parity) as a
    # replacement. Commented out rather than removed until the comparison
    # is done.
    /*
      vtsls = {
        enable = true;
        config = {
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
      };
    */

    tsgo = {
      enable = true;
      package = pkgs.typescript-go;
      config.settings.typescript = {
        # updateImportsOnFileMove.enabled = "always";
        suggest.completeFunctionCalls = true;
        inlayHints.variableTypes.enabled = false;
      };
    };

    tailwindcss = {
      enable = true;
      config.root_markers = [
        "tailwind.config.js"
        "tailwind.config.cjs"
        "tailwind.config.mjs"
        "tailwind.config.ts"
        "tailwind.config.json"
      ];
    };

    eslint = {
      enable = true;
      config.settings.workingDirectories.mode = "auto";
    };

    biome.enable = true;
  };
}
