{
  plugins.treesj = {
    enable = true;
    settings = {
      use_default_keymaps = false;
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "gm";
      action = "<cmd>TSJToggle<cr>";
      options.desc = "Toggle split/join blocks";
    }
  ];
}
