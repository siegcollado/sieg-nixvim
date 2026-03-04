{ lib, ... }:
{
  plugins.lsp = {
    enable = true;

    # Enable inlay hints globally (LazyVim style)
    inlayHints = true;

    # Global capabilities for all servers (LazyVim style)
    # Note: modifies the provided capabilities table in place
    capabilities = ''
      capabilities.workspace = capabilities.workspace or {}
      capabilities.workspace.fileOperations = {
        didRename = true,
        willRename = true,
      }
    '';

    servers = {
      # Lua with extensive custom settings
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

      # Other LSP servers (using Nixvim defaults)
      jsonls.enable = true;
      ts_ls.enable = true; # TypeScript (renamed from tsserver)
      marksman.enable = true;
      nil_ls.enable = true; # Nix
      pyright.enable = true;
      ruby_lsp.enable = true;
      taplo.enable = true; # TOML
      yamlls.enable = true;
      statix.enable = true; # Nix linter
    };

    keymaps = {
      # Maps to vim.lsp.buf.* - automatically checks capabilities
      lspBuf = {
        "gd" = "definition";
        "gr" = "references";
        "gI" = "implementation";
        "gy" = "type_definition";
        "gD" = "declaration";
        "K" = "hover";
        "gK" = "signature_help";
        "<leader>ca" = "code_action";
        "<leader>cr" = "rename";
      };

      # Custom keymaps with Lua actions
      extra = [
        {
          key = "<leader>cl";
          action = lib.nixvim.mkRaw ''
            function()
              require("utils.features").safe_require("snacks", function(snacks)
                snacks.picker.lsp_config()
              end)
            end
          '';
          options.desc = "Lsp Info";
        }
        {
          key = "<leader>cR";
          action = lib.nixvim.mkRaw ''
            function()
              require("utils.features").safe_require("snacks", function(snacks)
                snacks.rename.rename_file()
              end)
            end
          '';
          options.desc = "Rename File";
        }
        {
          key = "<leader>cA";
          action = lib.nixvim.mkRaw ''
            function()
              vim.lsp.buf.code_action({ context = { only = { "source" } } })
            end
          '';
          options.desc = "Source Action";
        }
        {
          mode = "i";
          key = "<c-k>";
          action = lib.nixvim.mkRaw "vim.lsp.buf.signature_help";
          options.desc = "Signature Help";
        }
        {
          mode = [
            "n"
            "x"
          ];
          key = "<leader>cc";
          action = lib.nixvim.mkRaw "vim.lsp.codelens.run";
          options.desc = "Run Codelens";
        }
        {
          key = "<leader>cC";
          action = lib.nixvim.mkRaw "vim.lsp.codelens.refresh";
          options.desc = "Refresh Codelens";
        }
        {
          key = "]]";
          action = lib.nixvim.mkRaw ''
            function()
              require("utils.features").safe_require("snacks", function(snacks)
                snacks.words.jump(vim.v.count1)
              end)
            end
          '';
          options.desc = "Next Reference";
        }
        {
          key = "[[";
          action = lib.nixvim.mkRaw ''
            function()
              require("utils.features").safe_require("snacks", function(snacks)
                snacks.words.jump(-vim.v.count1)
              end)
            end
          '';
          options.desc = "Prev Reference";
        }
        {
          key = "<a-n>";
          action = lib.nixvim.mkRaw ''
            function()
              require("utils.features").safe_require("snacks", function(snacks)
                snacks.words.jump(vim.v.count1, true)
              end)
            end
          '';
          options.desc = "Next Reference (strict)";
        }
        {
          key = "<a-p>";
          action = lib.nixvim.mkRaw ''
            function()
              require("utils.features").safe_require("snacks", function(snacks)
                snacks.words.jump(-vim.v.count1, true)
              end)
            end
          '';
          options.desc = "Prev Reference (strict)";
        }
      ];
    };
  };
}
