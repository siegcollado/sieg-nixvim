{ inputs, lib, ... }:
{
  flake.overlays.default = final: prev: {
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
