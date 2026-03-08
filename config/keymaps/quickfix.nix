{ lib, ... }:
{
  keymaps = [
    # Location list
    {
      mode = "n";
      key = "<leader>xl";
      action = lib.nixvim.mkRaw ''
        function()
          local success, err = pcall(vim.fn.getloclist(0, { winid = 0 }).winid ~= 0 and vim.cmd.lclose or vim.cmd.lopen)
          if not success and err then
            vim.notify(err, vim.log.levels.ERROR)
          end
        end
      '';
      options.desc = "Location List";
    }

    # Quickfix list
    {
      mode = "n";
      key = "<leader>xq";
      action = lib.nixvim.mkRaw ''
        function()
          local success, err = pcall(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and vim.cmd.cclose or vim.cmd.copen)
          if not success and err then
            vim.notify(err, vim.log.levels.ERROR)
          end
        end
      '';
      options.desc = "Quickfix List";
    }
    {
      mode = "n";
      key = "[q";
      action = lib.nixvim.mkRaw "vim.cmd.cprev";
      options.desc = "Previous Quickfix";
    }
    {
      mode = "n";
      key = "]q";
      action = lib.nixvim.mkRaw "vim.cmd.cnext";
      options.desc = "Next Quickfix";
    }

    # Diagnostics (using diagnostic_goto helper from default.nix)
    {
      mode = "n";
      key = "<leader>cd";
      action = lib.nixvim.mkRaw "vim.diagnostic.open_float";
      options.desc = "Line Diagnostics";
    }
    {
      mode = "n";
      key = "]d";
      action = lib.nixvim.mkRaw "diagnostic_goto(true)";
      options.desc = "Next Diagnostic";
    }
    {
      mode = "n";
      key = "[d";
      action = lib.nixvim.mkRaw "diagnostic_goto(false)";
      options.desc = "Prev Diagnostic";
    }
    {
      mode = "n";
      key = "]e";
      action = lib.nixvim.mkRaw ''diagnostic_goto(true, "ERROR")'';
      options.desc = "Next Error";
    }
    {
      mode = "n";
      key = "[e";
      action = lib.nixvim.mkRaw ''diagnostic_goto(false, "ERROR")'';
      options.desc = "Prev Error";
    }
    {
      mode = "n";
      key = "]w";
      action = lib.nixvim.mkRaw ''diagnostic_goto(true, "WARN")'';
      options.desc = "Next Warning";
    }
    {
      mode = "n";
      key = "[w";
      action = lib.nixvim.mkRaw ''diagnostic_goto(false, "WARN")'';
      options.desc = "Prev Warning";
    }
  ];
}
