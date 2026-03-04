{
  lib,
  config,
  pkgs,
  ...
}:
{
  # exrc.nvim - Manage project-local .nvim.lua configuration files
  # Provides utilities for writing and managing .nvim.lua files
  # with auto-trust, auto-load, and LSP configuration overrides
  extraPlugins = with pkgs.vimPlugins; [
    exrc-nvim
  ];

  extraConfigLua = ''
    require("exrc").setup({
      -- Name of exrc files to use
      exrc_name = ".nvim.lua",
      -- Load exrc from current directory on start
      on_vim_enter = true,
      -- Automatically load exrc files on DirChanged autocmd
      on_dir_changed = {
        enabled = true,
        -- Wait until CursorHold and use vim.ui.select to confirm files to load
        use_ui_select = true,
      },
      -- Automatically trust when saving exrc file
      trust_on_write = true,
      -- Use telescope instead of vim.ui.select for picking files (if available)
      use_telescope = true,
      -- LSP configuration
      lsp = {
        -- Automatically configure lspconfig to register on_new_config
        auto_setup = true,
      },
    })
  '';
}
