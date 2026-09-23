{ inputs, ... }:
{
  flake.overlays.default = _: prev: {
    vimPlugins = prev.vimPlugins // {
      agentic-nvim = prev.vimUtils.buildVimPlugin {
        pname = "agentic.nvim";
        version = inputs.agentic-nvim.shortRev or "unknown";
        src = inputs.agentic-nvim;
        # Disable checks - plugin has test files with missing deps
        doCheck = false;
      };
    };
  };
}
