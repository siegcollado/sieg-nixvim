{ lib, ... }:
{
  plugins.copilot-lua = {
    enable = true;
    settings = {
      copilot_node_command = lib.nixvim.mkRaw "vim.fn.exepath('node')";
      suggestion = {
        enabled = false;
        auto_trigger = true;
        hide_during_completion = true;
        keymap = {
          accept = false;
          next = "<M-]>";
          prev = "<M-[>";
        };
      };
      panel = {
        enabled = false;
      };
      filetypes = {
        markdown = true;
        help = true;
      };
    };
  };
}
