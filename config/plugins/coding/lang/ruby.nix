{
  plugins.conform-nvim.settings.formatters_by_ft.ruby = [ "rubocop" ];

  plugins.lsp.servers = {
    ruby_lsp.enable = true;
    rubocop.enable = true; # not sure...
  };
}
