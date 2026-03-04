{ lib, ... }:
{
  autoGroups = {
    CoreRoot = {
      clear = true;
    };
    CoreNumberToggle = {
      clear = true;
    };
    CoreAutocmds = {
      clear = true;
    };
  };

  autoCmd = [
    # Root cache clearing
    {
      group = "CoreRoot";
      event = [
        "LspAttach"
        "BufWritePost"
        "DirChanged"
        "BufEnter"
      ];
      callback = lib.nixvim.mkRaw ''
        function(args)
          require("utils.root").clear_cache(args.buf)
        end
      '';
      desc = "Clear root cache";
    }

    # Terminal: disable line numbers
    {
      group = "CoreAutocmds";
      event = "TermOpen";
      callback = lib.nixvim.mkRaw ''
        function()
          vim.wo.relativenumber = false
          vim.wo.number = false
        end
      '';
      desc = "Disable numbers in terminal";
    }

    # Relative number: enable when entering normal mode
    {
      group = "CoreNumberToggle";
      event = [
        "BufEnter"
        "FocusGained"
        "InsertLeave"
        "WinEnter"
        "CmdlineLeave"
      ];
      callback = lib.nixvim.mkRaw ''
        function()
          if vim.wo.number and vim.api.nvim_get_mode().mode ~= "i" then
            vim.wo.relativenumber = true
          end
        end
      '';
      desc = "Enable relative number in normal mode";
    }

    # Relative number: disable when leaving normal mode
    {
      group = "CoreNumberToggle";
      event = [
        "BufLeave"
        "FocusLost"
        "InsertEnter"
        "WinLeave"
        "CmdlineEnter"
      ];
      callback = lib.nixvim.mkRaw ''
        function()
          if vim.wo.number then
            vim.wo.relativenumber = false
            vim.cmd("redraw")
          end
        end
      '';
      desc = "Disable relative number when leaving normal mode";
    }

    # Checktime on focus
    {
      group = "CoreAutocmds";
      event = [
        "FocusGained"
        "TermClose"
        "TermLeave"
      ];
      callback = lib.nixvim.mkRaw ''
        function()
          if vim.bo.buftype ~= "nofile" then
            vim.cmd("checktime")
          end
        end
      '';
      desc = "Check for file changes on focus";
    }

    # Highlight on yank
    {
      group = "CoreAutocmds";
      event = "TextYankPost";
      callback = lib.nixvim.mkRaw "function() vim.highlight.on_yank() end";
      desc = "Highlight yanked text";
    }

    # Resize splits on vim resize
    {
      group = "CoreAutocmds";
      event = "VimResized";
      callback = lib.nixvim.mkRaw ''
        function()
          local tab = vim.fn.tabpagenr()
          vim.cmd("tabdo wincmd =")
          vim.cmd("tabnext " .. tab)
        end
      '';
      desc = "Equalize window splits on resize";
    }

    # Restore cursor position
    {
      group = "CoreAutocmds";
      event = "BufReadPost";
      callback = lib.nixvim.mkRaw ''
        function()
          local mark = vim.api.nvim_buf_get_mark(0, '"')
          local lcount = vim.api.nvim_buf_line_count(0)
          if mark[1] > 0 and mark[1] <= lcount then
            if vim.bo.filetype ~= "gitcommit" and vim.fn.line("'\"") > 1 then
              vim.cmd('normal! g`"')
            end
          end
        end
      '';
      desc = "Restore cursor to last position";
    }

    # FileType: q to close special buffers
    {
      group = "CoreAutocmds";
      event = "FileType";
      pattern = [
        "PlenaryTestPopup"
        "help"
        "lspinfo"
        "man"
        "notify"
        "qf"
        "query"
        "spectre_panel"
        "grug-far"
        "startuptime"
        "tsplayground"
        "neotest-output"
        "checkhealth"
        "neotest-summary"
        "neotest-output-panel"
        "dbout"
        "gitsigns-blame"
      ];
      callback = lib.nixvim.mkRaw ''
        function(event)
          vim.bo[event.buf].buflisted = false
          vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
        end
      '';
      desc = "Close ephemeral buffers with q";
    }

    # FileType: man buflisted false
    {
      group = "CoreAutocmds";
      event = "FileType";
      pattern = [ "man" ];
      callback = lib.nixvim.mkRaw ''
        function(event)
          vim.bo[event.buf].buflisted = false
        end
      '';
      desc = "Hide man pages from buffer list";
    }

    # FileType: text files wrap and spell
    {
      group = "CoreAutocmds";
      event = "FileType";
      pattern = [
        "text"
        "plaintex"
        "typst"
        "gitcommit"
        "markdown"
      ];
      callback = lib.nixvim.mkRaw ''
        function()
          vim.opt_local.wrap = true
          vim.opt_local.spell = true
        end
      '';
      desc = "Enable wrap and spell for text files";
    }

    # FileType: json conceallevel
    {
      group = "CoreAutocmds";
      event = "FileType";
      pattern = [
        "json"
        "jsonc"
        "json5"
      ];
      callback = lib.nixvim.mkRaw ''
        function()
          vim.opt_local.conceallevel = 0
        end
      '';
      desc = "Show JSON content fully";
    }

    # Auto-create parent directories on save
    {
      group = "CoreAutocmds";
      event = "BufWritePre";
      callback = lib.nixvim.mkRaw ''
        function(event)
          if event.match:match("^%w%w+://") then
            return
          end
          local file = vim.uv.fs_realpath(event.match) or event.match
          vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
        end
      '';
      desc = "Create parent directories before saving";
    }
  ];
}
