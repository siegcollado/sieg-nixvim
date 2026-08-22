{ lib, ... }:
{
  # Installs nvim-lspconfig, which provides default configs (cmd, root_markers,
  # filetypes) for the servers enabled below.
  plugins.lspconfig.enable = true;

  lsp = {
    inlayHints.enable = true;

    servers."*".config = {
      # Global capabilities, merged into every server by neovim (vim.lsp.config('*', ...)).
      # TODO: drop the require("blink-cmp").get_lsp_capabilities() call if/when blink.cmp
      # starts registering its LSP capabilities itself via vim.lsp.config. As of blink.cmp
      # 1.10.2 it doesn't (no vim.lsp.config calls in its source) - checked 2026-08-22.
      capabilities = lib.nixvim.mkRaw ''
        (function()
          local capabilities = require("blink-cmp").get_lsp_capabilities()

          capabilities.workspace = capabilities.workspace or {}
          capabilities.workspace.fileOperations = {
            didRename = true,
            willRename = true,
          }

          return capabilities
        end)()
      '';
    };

    keymaps = [
      # Maps to vim.lsp.buf.* via lspBufAction - automatically checks capabilities
      {
        key = "gd";
        lspBufAction = "definition";
        options.desc = "Goto Definition";
      }
      {
        key = "gr";
        lspBufAction = "references";
        options.desc = "References";
      }
      {
        key = "gI";
        lspBufAction = "implementation";
        options.desc = "Goto Implementation";
      }
      {
        key = "gy";
        lspBufAction = "type_definition";
        options.desc = "Goto Type Definition";
      }
      {
        key = "gD";
        lspBufAction = "declaration";
        options.desc = "Goto Declaration";
      }
      {
        key = "K";
        lspBufAction = "hover";
        options.desc = "Hover";
      }
      {
        key = "gK";
        lspBufAction = "signature_help";
        options.desc = "Signature Help";
      }
      {
        key = "<leader>ca";
        lspBufAction = "code_action";
        options.desc = "Code Action";
      }
      {
        key = "<leader>cr";
        lspBufAction = "rename";
        options.desc = "Rename";
      }

      # Custom keymaps with Lua actions
      {
        key = "<leader>cl";
        action = lib.nixvim.mkRaw ''
          function()
            require("snacks").picker.lsp_config()
          end
        '';
        options.desc = "Lsp Info";
      }
      {
        key = "<leader>cR";
        action = lib.nixvim.mkRaw ''
          function()
            require("snacks").rename.rename_file()
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
            require("snacks").words.jump(vim.v.count1)
          end
        '';
        options.desc = "Next Reference";
      }
      {
        key = "[[";
        action = lib.nixvim.mkRaw ''
          function()
            require("snacks").words.jump(-vim.v.count1)
          end
        '';
        options.desc = "Prev Reference";
      }
      {
        key = "<a-n>";
        action = lib.nixvim.mkRaw ''
          function()
            require("snacks").words.jump(vim.v.count1, true)
          end
        '';
        options.desc = "Next Reference (strict)";
      }
      {
        key = "<a-p>";
        action = lib.nixvim.mkRaw ''
          function()
            require("snacks").words.jump(-vim.v.count1, true)
          end
        '';
        options.desc = "Prev Reference (strict)";
      }
    ];
  };
}
