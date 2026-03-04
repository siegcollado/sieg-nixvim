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
  };
}
