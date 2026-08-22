{
  globals.markdown_recommended_style = 0;

  plugins.conform-nvim.settings.formatters_by_ft = {
    markdown = [ "prettier" ];
    "markdown.mdx" = [ "prettier" ];
  };

  lsp.servers.marksman = {
    enable = true;
    # TODO: remove when nixpkgs#506470 lands in nixpkgs-unstable.
    # Ideally I'd like to temporarily overlay marksman from a nixpkgs
    # revision containing the ICU symbol fix (instead of this env var).
    # We are keeping this env workaround for now because pulling/building the
    # .NET-based marksman overlay is slower in this setup.
    config.cmd_env.DOTNET_SYSTEM_GLOBALIZATION_INVARIANT = "1";
  };
}
