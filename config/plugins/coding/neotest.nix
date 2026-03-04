{ lib, ... }:
{
  plugins.neotest = {
    enable = true;
    settings = {
      summary = {
        animated = true;
      };

      highlights = {
        adapter_name = "Title";
        border = "VertSplit";
        dir = "Directory";
        expand_marker = "Normal";
        failed = "DiagnosticError";
        file = "Normal";
        focused = "Underline";
        indent = "Normal";
        marked = "Bold";
        namespace = "Title";
        passed = "DiagnosticOK";
        running = "DiagnosticInfo";
        select_win = "Title";
        skipped = "DiagnosticWarn";
        target = "NeotestTarget";
        test = "String";
        unknown = "Normal";
        watching = "DiagnosticWarn";
      };

      icons = {
        passed = "✓";
        failed = "✗";
        skipped = "";
        unknown = "";
        watching = "";
        notify = "";
        running_animated = [
          "⠋"
          "⠙"
          "⠚"
          "⠒"
          "⠂"
          "⠂"
          "⠒"
          "⠲"
          "⠴"
          "⠦"
          "⠖"
          "⠒"
          "⠐"
          "⠐"
          "⠒"
          "⠓"
          "⠋"
        ];
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>ta";
      action = lib.nixvim.mkRaw "function() require('neotest').run.attach() end";
      options.desc = "Attach to Test (Neotest)";
    }
    {
      mode = "n";
      key = "<leader>tt";
      action = lib.nixvim.mkRaw "function() require('neotest').run.run(vim.fn.expand('%')) end";
      options.desc = "Run File (Neotest)";
    }
    {
      mode = "n";
      key = "<leader>tT";
      action = lib.nixvim.mkRaw "function() require('neotest').run.run(vim.uv.cwd()) end";
      options.desc = "Run All Test Files (Neotest)";
    }
    {
      mode = "n";
      key = "<leader>tr";
      action = lib.nixvim.mkRaw "function() require('neotest').run.run() end";
      options.desc = "Run Nearest (Neotest)";
    }
    {
      mode = "n";
      key = "<leader>tl";
      action = lib.nixvim.mkRaw "function() require('neotest').run.run_last() end";
      options.desc = "Run Last (Neotest)";
    }
    {
      mode = "n";
      key = "<leader>ts";
      action = lib.nixvim.mkRaw "function() require('neotest').summary.toggle() end";
      options.desc = "Toggle Summary (Neotest)";
    }
    {
      mode = "n";
      key = "<leader>to";
      action = lib.nixvim.mkRaw "function() require('neotest').output.open({ enter = true, auto_close = true }) end";
      options.desc = "Show Output (Neotest)";
    }
    {
      mode = "n";
      key = "<leader>tO";
      action = lib.nixvim.mkRaw "function() require('neotest').output_panel.toggle() end";
      options.desc = "Toggle Output Panel (Neotest)";
    }
    {
      mode = "n";
      key = "<leader>tS";
      action = lib.nixvim.mkRaw "function() require('neotest').run.stop() end";
      options.desc = "Stop (Neotest)";
    }
    {
      mode = "n";
      key = "<leader>tw";
      action = lib.nixvim.mkRaw "function() require('neotest').watch.toggle(vim.fn.expand('%')) end";
      options.desc = "Toggle Watch (Neotest)";
    }
  ];
}
