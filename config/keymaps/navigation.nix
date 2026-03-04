{
  keymaps = [
    # Window navigation
    {
      mode = "n";
      key = "<C-h>";
      action = "<C-w>h";
      options = {
        desc = "Go to Left Window";
        remap = true;
      };
    }
    {
      mode = "n";
      key = "<C-j>";
      action = "<C-w>j";
      options = {
        desc = "Go to Lower Window";
        remap = true;
      };
    }
    {
      mode = "n";
      key = "<C-k>";
      action = "<C-w>k";
      options = {
        desc = "Go to Upper Window";
        remap = true;
      };
    }
    {
      mode = "n";
      key = "<C-l>";
      action = "<C-w>l";
      options = {
        desc = "Go to Right Window";
        remap = true;
      };
    }
    {
      mode = "n";
      key = "<leader>w/";
      action = "<C-w>v";
      options.desc = "Split Window Right";
    }

    # Window resize
    {
      mode = "n";
      key = "<C-Up>";
      action = "<cmd>resize +2<cr>";
      options.desc = "Increase Window Height";
    }
    {
      mode = "n";
      key = "<C-Down>";
      action = "<cmd>resize -2<cr>";
      options.desc = "Decrease Window Height";
    }
    {
      mode = "n";
      key = "<C-Left>";
      action = "<cmd>vertical resize -2<cr>";
      options.desc = "Decrease Window Width";
    }
    {
      mode = "n";
      key = "<C-Right>";
      action = "<cmd>vertical resize +2<cr>";
      options.desc = "Increase Window Width";
    }

    # Window management
    {
      mode = "n";
      key = "<leader>-";
      action = "<C-W>s";
      options = {
        desc = "Split Window Below";
        remap = true;
      };
    }
    {
      mode = "n";
      key = "<leader>|";
      action = "<C-W>v";
      options = {
        desc = "Split Window Right";
        remap = true;
      };
    }
    {
      mode = "n";
      key = "<leader>wd";
      action = "<C-W>c";
      options = {
        desc = "Delete Window";
        remap = true;
      };
    }

    # Buffer navigation
    {
      mode = "n";
      key = "<S-h>";
      action = "<cmd>bprevious<cr>";
      options.desc = "Prev Buffer";
    }
    {
      mode = "n";
      key = "<S-l>";
      action = "<cmd>bnext<cr>";
      options.desc = "Next Buffer";
    }
    {
      mode = "n";
      key = "[b";
      action = "<cmd>bprevious<cr>";
      options.desc = "Prev Buffer";
    }
    {
      mode = "n";
      key = "]b";
      action = "<cmd>bnext<cr>";
      options.desc = "Next Buffer";
    }
    {
      mode = "n";
      key = "<leader>bb";
      action = "<cmd>e #<cr>";
      options.desc = "Switch to Other Buffer";
    }
    {
      mode = "n";
      key = "<leader>`";
      action = "<cmd>e #<cr>";
      options.desc = "Switch to Other Buffer";
    }

    # Tab management
    # {
    #   mode = "n";
    #   key = "<leader><tab>l";
    #   action = "<cmd>tablast<cr>";
    #   options.desc = "Last Tab";
    # }
    # {
    #   mode = "n";
    #   key = "<leader><tab>o";
    #   action = "<cmd>tabonly<cr>";
    #   options.desc = "Close Other Tabs";
    # }
    # {
    #   mode = "n";
    #   key = "<leader><tab>f";
    #   action = "<cmd>tabfirst<cr>";
    #   options.desc = "First Tab";
    # }
    # {
    #   mode = "n";
    #   key = "<leader><tab><tab>";
    #   action = "<cmd>tabnew<cr>";
    #   options.desc = "New Tab";
    # }
    # {
    #   mode = "n";
    #   key = "<leader><tab>]";
    #   action = "<cmd>tabnext<cr>";
    #   options.desc = "Next Tab";
    # }
    # {
    #   mode = "n";
    #   key = "<leader><tab>d";
    #   action = "<cmd>tabclose<cr>";
    #   options.desc = "Close Tab";
    # }
    # {
    #   mode = "n";
    #   key = "<leader><tab>[";
    #   action = "<cmd>tabprevious<cr>";
    #   options.desc = "Previous Tab";
    # }
  ];
}
