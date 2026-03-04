{
  plugins.tmux-navigator = {
    enable = true;

    settings = {
      no_mappings = 1;
      disable_when_zoomed = 1;

    };

    keymaps =
      let
        mode = [
          "n"
          "x"
        ];
        keys = [
          {
            key = "h";
            action = "left";
          }
          {
            key = "j";
            action = "down";
          }
          {
            key = "k";
            action = "up";
          }
          {
            key = "l";
            action = "right";
          }
          {
            key = "\\";
            action = "previous";
          }
        ];
      in
      builtins.concatMap (keymap: [
        {
          inherit mode;
          key = "<C-w>" + keymap.key;
          inherit (keymap) action;
        }
        {
          inherit mode;
          key = "<C-${keymap.key}>";
          inherit (keymap) action;
        }
        {
          inherit mode;
          key = "<C-w><C-${keymap.key}>";
          inherit (keymap) action;
        }
      ]) keys;
  };
}
