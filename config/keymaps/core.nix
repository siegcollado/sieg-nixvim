{
  keymaps = [
    # Escape alternatives
    {
      mode = "i";
      key = "jk";
      action = "<Esc>";
      options.desc = "Escape";
    }
    {
      mode = "i";
      key = "kj";
      action = "<Esc>";
      options.desc = "Escape";
    }

    # Better up/down with wrapped lines
    {
      mode = [
        "n"
        "x"
      ];
      key = "j";
      action = "v:count == 0 ? 'gj' : 'j'";
      options = {
        desc = "Down";
        expr = true;
      };
    }
    {
      mode = [
        "n"
        "x"
      ];
      key = "<Down>";
      action = "v:count == 0 ? 'gj' : 'j'";
      options = {
        desc = "Down";
        expr = true;
      };
    }
    {
      mode = [
        "n"
        "x"
      ];
      key = "k";
      action = "v:count == 0 ? 'gk' : 'k'";
      options = {
        desc = "Up";
        expr = true;
      };
    }
    {
      mode = [
        "n"
        "x"
      ];
      key = "<Up>";
      action = "v:count == 0 ? 'gk' : 'k'";
      options = {
        desc = "Up";
        expr = true;
      };
    }

    # Saner n/N - consistent direction regardless of search direction
    {
      mode = "n";
      key = "n";
      action = "'Nn'[v:searchforward].'zv'";
      options = {
        desc = "Next Search Result";
        expr = true;
      };
    }
    {
      mode = "x";
      key = "n";
      action = "'Nn'[v:searchforward]";
      options = {
        desc = "Next Search Result";
        expr = true;
      };
    }
    {
      mode = "o";
      key = "n";
      action = "'Nn'[v:searchforward]";
      options = {
        desc = "Next Search Result";
        expr = true;
      };
    }
    {
      mode = "n";
      key = "N";
      action = "'nN'[v:searchforward].'zv'";
      options = {
        desc = "Prev Search Result";
        expr = true;
      };
    }
    {
      mode = "x";
      key = "N";
      action = "'nN'[v:searchforward]";
      options = {
        desc = "Prev Search Result";
        expr = true;
      };
    }
    {
      mode = "o";
      key = "N";
      action = "'nN'[v:searchforward]";
      options = {
        desc = "Prev Search Result";
        expr = true;
      };
    }

    # Undo breakpoints
    {
      mode = "i";
      key = ",";
      action = ",<c-g>u";
      options.desc = "Undo breakpoint";
    }
    {
      mode = "i";
      key = ".";
      action = ".<c-g>u";
      options.desc = "Undo breakpoint";
    }
    {
      mode = "i";
      key = ";";
      action = ";<c-g>u";
      options.desc = "Undo breakpoint";
    }

    # Save file
    {
      mode = [
        "i"
        "x"
        "n"
        "s"
      ];
      key = "<C-s>";
      action = "<cmd>w<cr><esc>";
      options.desc = "Save File";
    }

    # Better indenting (stay in visual mode)
    {
      mode = "x";
      key = "<";
      action = "<gv";
      options.desc = "Indent left";
    }
    {
      mode = "x";
      key = ">";
      action = ">gv";
      options.desc = "Indent right";
    }

    # Recenter on scroll
    {
      mode = "n";
      key = "<C-d>";
      action = "<C-d>zz";
      options.desc = "Scroll down and center";
    }
    {
      mode = "n";
      key = "<C-u>";
      action = "<C-u>zz";
      options.desc = "Scroll up and center";
    }
  ];
}
