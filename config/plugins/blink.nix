{ lib, ... }:
{

  plugins.blink-cmp-avante.enable = true;
  plugins.blink-cmp-copilot.enable = true;

  plugins.blink-cmp = {
    enable = true;
    settings = {
      snippets = {
        preset = "default";
      };
      appearance = {
        use_nvim_cmp_as_default = true;
        kind_icons = lib.nixvim.mkRaw ''
          (function()
              local mini = require("mini.icons")
              local kind_icons = {}
              local completion_kinds = vim.lsp.protocol.CompletionItemKind or {}
              for _, kind in ipairs(completion_kinds) do
                local glyph = mini.get("lsp", kind:lower())
                kind_icons[kind] = glyph
              end

              local ai_kinds = {
                Copilot = " ",
                Codeium = "󰘦 ",
                Supermaven = " ",
                TabNine = "󰏚 ",
              }

              for kind, glyph in pairs(ai_kinds) do
                kind_icons[kind] = glyph
              end

              return kind_icons
            end)()
        '';
      };
      sources = {
        default = [
          "avante"
          "copilot"
          "lsp"
          "path"
          "snippets"
          "buffer"
        ];
        providers = {
          avante = {
            name = "Avante";
            module = "blink-cmp-avante";
          };
          copilot = {
            async = true;
            module = "blink-cmp-copilot";
            name = "copilot";
            score_offset = 100;
          };
          lsp.module = "blink.cmp.sources.lsp";
          path.module = "blink.cmp.sources.path";
          snippets.module = "blink.cmp.sources.snippets";
          buffer.module = "blink.cmp.sources.buffer";
        };
      };
      keymap = {
        preset = "super-tab";
        "<C-j>" = [
          "select_next"
          "fallback"
        ];
        "<C-k>" = [
          "select_prev"
          "fallback"
        ];
        "<C-space>" = [
          "show"
          "show_documentation"
          "hide_documentation"
        ];
      };
    };
  };
}
