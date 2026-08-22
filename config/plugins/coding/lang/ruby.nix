{
  plugins = {
    conform-nvim.settings.formatters_by_ft.ruby = [ "rubocop" ];

    lint.lintersByFt.ruby = [ "rubocop" ];

    neotest.adapters.rspec = {
      enable = true;
    };
  };

  lsp.servers = {
    ruby_lsp = {
      enable = true;
      package = null; # use the ruby-lsp in the project.
      # extraOptions = {
      # init_options = {
      #   enabledFeatures = {
      #     diagnostics = false;
      #     # codeActions = true;
      #   };
      # };
      # };
    };
    rubocop = {
      enable = true;
      package = null; # use the rubocop in the project.
    };
  };
}
