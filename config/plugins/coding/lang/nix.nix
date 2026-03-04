{
  plugins = {
    conform-nvim.settings.formatters_by_ft.nix = [
      "nixfmt"
      # "statix"
    ];

    lint.lintersByFt.nix = [ "statix" ];

    lsp.servers = {
      nil_ls.enable = true; # Nix
      statix.enable = true; # Nix linter
    };
  };
}
