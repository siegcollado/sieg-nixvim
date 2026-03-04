{
  plugins.conform-nvim.settings = {
    formatters_by_ft = {
      yaml = [ "prettier" ];
      yml = [ "prettier" ];
    };
  };

  plugins.lsp.servers.yamlls.enable = true;
}
