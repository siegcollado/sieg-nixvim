{ lib, ... }:
{
  plugins.tmux-navigator = {
    enable = true;
    settings = {
      disable_when_zoomed = 1;
    };
  };
}
