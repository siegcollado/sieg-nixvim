{ lib, ... }:
{
  plugins = {
    conform-nvim.settings.formatters_by_ft = {
      lua = [ "stylua" ];
    };

    # enable autocomplete on .nvim.lua
    lazydev = {
      enable = true;
      settings = {
        library = [
          {
            path = "\${3rd}/luv/library";
            words = [ "vim%.uv" ];
          }
          {
            path = "snacks.nvim";
            words = [ "Snacks" ];
          }
        ];
      };
    };

    # Lua with extensive custom settings
    lsp.servers = {
      lua_ls = {
        enable = true;
        # Ensure lua_ls attaches to standalone files and projects
        rootMarkers = [
          ".git"
          ".luarc.json"
          ".luarc.jsonc"
          ".editorconfig"

          # for exrc.nvim
          ".nvim.lua"
          ".nvimrc.lua"
          ".exrc.lua"
        ];
        settings = {
          Lua = {
            codeLens = {
              enable = true;
            };
            completion = {
              callSnippet = "Replace";
            };
            doc = {
              privateName = [ "^_" ];
            };
            hint = {
              enable = true;
              setType = false;
              paramType = true;
              paramName = "Disable";
              semicolon = "Disable";
              arrayIndex = "Disable";
            };
            runtime = {
              version = "LuaJIT";
            };
            diagnostics = {
              globals = [ "vim" ];
            };
            workspace = {
              checkThirdParty = false;
              library = lib.nixvim.mkRaw "vim.api.nvim_get_runtime_file('', true)";
            };
            telemetry = {
              enable = false;
            };
          };
        };
      };
    };
  };
}
