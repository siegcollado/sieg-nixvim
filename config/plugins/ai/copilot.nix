{ lib, config, ... }:
{
  config = lib.mkMerge [
    # https://github.com/zbirenbaum/copilot.lua/issues/725
    # https://github.com/zbirenbaum/copilot.lua/issues/725#issuecomment-5082050925
    # Just an escape hatch for environments with keyring issues
    (lib.mkIf (!config.sieg-nixvim.copilot.tokenEncryption) {
      env.GITHUB_COPILOT_AUTH_TOKEN_ENCRYPTION = "false";
    })

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
  ];
}
