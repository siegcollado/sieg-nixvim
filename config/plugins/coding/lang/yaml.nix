{
  plugins.conform-nvim.settings = {
    formatters_by_ft = {
      yaml = [ "prettier" ];
      yml = [ "prettier" ];
    };
  };

  lsp.servers.yamlls.enable = true;
}
