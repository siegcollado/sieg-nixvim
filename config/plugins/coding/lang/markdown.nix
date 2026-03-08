{
  globals.markdown_recommended_style = 0;

  plugins.conform-nvim.settings.formatters_by_ft = {
    markdown = [ "prettier" ];
    "markdown.mdx" = [ "prettier" ];
  };

  plugins.lsp.servers.marksman.enable = true;
}
