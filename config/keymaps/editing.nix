{
  keymaps = [
    # Move lines
    {
      mode = "n";
      key = "<A-j>";
      action = "<cmd>execute 'move .+' . v:count1<cr>==";
      options.desc = "Move Down";
    }
    {
      mode = "n";
      key = "<A-k>";
      action = "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==";
      options.desc = "Move Up";
    }
    {
      mode = "i";
      key = "<A-j>";
      action = "<esc><cmd>m .+1<cr>==gi";
      options.desc = "Move Down";
    }
    {
      mode = "i";
      key = "<A-k>";
      action = "<esc><cmd>m .-2<cr>==gi";
      options.desc = "Move Up";
    }
    {
      mode = "v";
      key = "<A-j>";
      action = ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv";
      options.desc = "Move Down";
    }
    {
      mode = "v";
      key = "<A-k>";
      action = ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv";
      options.desc = "Move Up";
    }

    # Copy file path
    {
      mode = "n";
      key = "<leader>fy";
      action = ":let @+=expand('%:p')<cr>";
      options.desc = "Copy File Path";
    }
    {
      mode = "n";
      key = "<leader>fY";
      action = ":let @+=expand(\"%:p\") . \":\" . line(\".\")<cr>";
      options.desc = "Copy File Path + Line";
    }

    # New file
    {
      mode = "n";
      key = "<leader>fn";
      action = "<cmd>enew<cr>";
      options.desc = "New File";
    }

    # Keywordprg
    {
      mode = "n";
      key = "<leader>K";
      action = "<cmd>norm! K<cr>";
      options.desc = "Keywordprg";
    }
  ];
}
