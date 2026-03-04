{ lib, ... }:
{
  plugins.trouble = {
    enable = true;
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>xx";
      action = lib.nixvim.mkRaw ''function() require("trouble").toggle("diagnostics") end'';
      options.desc = "Diagnostics (Trouble)";
    }
    {
      mode = "n";
      key = "<leader>xX";
      action = lib.nixvim.mkRaw ''function() require("trouble").toggle({ mode = "diagnostics", filter = { buf = 0 } }) end'';
      options.desc = "Buffer Diagnostics (Trouble)";
    }
    {
      mode = "n";
      key = "<leader>xL";
      action = lib.nixvim.mkRaw ''function() require("trouble").toggle("loclist") end'';
      options.desc = "Location List (Trouble)";
    }
    {
      mode = "n";
      key = "<leader>xQ";
      action = lib.nixvim.mkRaw ''function() require("trouble").toggle("qflist") end'';
      options.desc = "Quickfix List (Trouble)";
    }
    {
      mode = "n";
      key = "<leader>cs";
      action = lib.nixvim.mkRaw ''function() require("trouble").toggle("lsp_document_symbols") end'';
      options.desc = "Symbols (Trouble)";
    }
    {
      mode = "n";
      key = "<leader>cS";
      action = lib.nixvim.mkRaw ''function() require("trouble").toggle("lsp_references") end'';
      options.desc = "LSP References (Trouble)";
    }
    {
      mode = "n";
      key = "[q";
      action = lib.nixvim.mkRaw ''function() require("trouble").previous() end'';
      options.desc = "Previous Trouble Item";
    }
    {
      mode = "n";
      key = "]q";
      action = lib.nixvim.mkRaw ''function() require("trouble").next() end'';
      options.desc = "Next Trouble Item";
    }
  ];
}
