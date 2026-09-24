{ lib }:
# Setup hook for a project dev shell: adds plugins to the runtimepath of the
# base nvim and runs `exrc` (a Lua string) after startup.
{
  pkgs,
  plugins ? [ ],
  exrc ? null,
}:
pkgs.writeTextDir "nix-support/setup-hook" ''
  export NVIM_EXTRA_RTP="${lib.concatStringsSep ":" plugins}''${NVIM_EXTRA_RTP:+:$NVIM_EXTRA_RTP}"
  ${lib.optionalString (exrc != null) "export NVIM_EXTRA_LUA=${pkgs.writeText "nvim-extra.lua" exrc}"}
''
