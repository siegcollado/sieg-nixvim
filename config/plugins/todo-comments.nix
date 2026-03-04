{ lib, ... }:
{
  plugins.todo-comments = {
    enable = true;
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>st";
      action = lib.nixvim.mkRaw ''function() require("snacks").picker.todo_comments() end'';
      options.desc = "Todo";
    }
    {
      mode = "n";
      key = "<leader>sT";
      action = lib.nixvim.mkRaw ''function() require("snacks").picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end'';
      options.desc = "Todo/Fix/Fixme";
    }
    {
      mode = "n";
      key = "[t";
      action = lib.nixvim.mkRaw ''function() require("todo-comments").jump_prev() end'';
      options.desc = "Prev Todo";
    }
    {
      mode = "n";
      key = "]t";
      action = lib.nixvim.mkRaw ''function() require("todo-comments").jump_next() end'';
      options.desc = "Next Todo";
    }
  ];
}
