{
  imports = [
    ./core.nix
    ./navigation.nix
    ./editing.nix
    ./search.nix
    ./quickfix.nix
  ];

  extraConfigLuaPre = ''
    -- Leader key setup
    vim.keymap.set("n", " ", "<Nop>", { silent = true, remap = false })
    vim.g.mapleader = " "

    -- Diagnostic navigation helper (global for keymap access)
    _G.diagnostic_goto = function(next, severity)
      return function()
        vim.diagnostic.jump({
          count = (next and 1 or -1) * vim.v.count1,
          severity = severity and vim.diagnostic.severity[severity] or nil,
          float = true,
        })
      end
    end
  '';
}
