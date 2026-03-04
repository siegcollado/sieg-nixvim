{ lib, ... }:
{
  keymaps = [
    # Clear search with escape
    {
      mode = [
        "i"
        "n"
        "s"
      ];
      key = "<esc>";
      action = lib.nixvim.mkRaw ''
        function()
          vim.cmd("noh")
          return "<esc>"
        end
      '';
      options = {
        expr = true;
        desc = "Escape and Clear hlsearch";
      };
    }

    # Redraw / clear
    {
      mode = "n";
      key = "<leader>ur";
      action = "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>";
      options.desc = "Redraw / Clear hlsearch / Diff Update";
    }
  ];
}
