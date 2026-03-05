{
  plugins = {
    conform-nvim.settings.formatters_by_ft.ruby = [ "rubocop" ];

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
      };
    };

    neotest.adapters.rspec = {
      enable = true;
    };
  };
}
