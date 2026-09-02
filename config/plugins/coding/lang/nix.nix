{
  plugins = {
    conform-nvim.settings.formatters_by_ft.nix = [ "nixfmt" ];
  };

  lsp.servers = {
    nil_ls.enable = true; # Nix
    statix.enable = true; # Nix linter
  };
}
