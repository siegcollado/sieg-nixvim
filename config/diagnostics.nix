let
  icons = (import ./icons.nix).diagnostics;
in
{
  diagnostic.settings = {
    underline = true;
    update_in_insert = false;
    severity_sort = true;
    signs = {
      text = {
        "ERROR" = "${icons.Error} ";
        "WARN" = "${icons.Warn} ";
        "HINT" = "${icons.Hint} ";
        "INFO" = "${icons.Info} ";
      };
    };
  };
}
