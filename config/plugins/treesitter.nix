# TODO: Consider installing only commonly used grammars (e.g., nix, lua, javascript, typescript, python)
# and allow runtime installation of additional grammars via :TSInstall
{
  plugins = {
    treesitter = {
      enable = true;
      settings = {
        highlight.enable = true;
        autotag.enable = true;
        auto_install = false;
        ensure_installed = [ ];
      };
    };
    treesitter-textobjects.enable = true;
    ts-autotag.enable = true;
  };
}
