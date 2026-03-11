{ inputs, ... }:
{
  flake.overlays.default = _: prev: {
    # NOTE: Work around nixpkgs ast-grep regression that breaks grug-far.
    # Remove once this lands https://github.com/NixOS/nixpkgs/pull/498607
    ast-grep = prev.ast-grep.overrideAttrs (_: rec {
      version = "0.40.5";
      src = prev.fetchFromGitHub {
        owner = "ast-grep";
        repo = "ast-grep";
        tag = version;
        hash = "sha256-O4f9PjGtwK6poFIbtz26q8q4fiYjfQEtobXmghQZAfw=";
      };

      cargoHash = "sha256-N5WrItW/yeZ+GDTw5yFy4eB11BzOlcuePGAefhJaG6I=";
      cargoDeps = prev.rustPlatform.fetchCargoVendor {
        inherit src;
        hash = cargoHash;
      };
    });
    vimPlugins = prev.vimPlugins // {
      exrc-nvim = prev.vimUtils.buildVimPlugin {
        pname = "exrc.nvim";
        version = inputs.exrc-nvim.shortRev or "unknown";
        src = inputs.exrc-nvim;
      };
      agentic-nvim = prev.vimUtils.buildVimPlugin {
        pname = "agentic.nvim";
        version = inputs.agentic-nvim.shortRev or "unknown";
        src = inputs.agentic-nvim;
        # Disable all checks - plugin has test files with missing deps
        doCheck = false;
        dontCheck = true;
      };
    };
  };
}
