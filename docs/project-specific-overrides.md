# Project specific neovim overrides

Neovim loads a `.nvim.lua` file from the project directory (`opts.exrc = true`).
Neovim asks you to trust the file the first time, and again after each edit.
Run `:trust` to approve it.

Get the directory of the `.nvim.lua` file like this:

```lua
local dir = vim.fs.dirname(debug.getinfo(1, "S").source:sub(2))
```

### Setting neotest test runners

* note: see [langs](../config/plugins/coding/lang/) for enabled jest adapters.

```lua
local dir = vim.fs.dirname(debug.getinfo(1, "S").source:sub(2))

require("neotest").setup_project(
  dir,
  vim.tbl_deep_extend("force", require("neotest.config"), {
    adapters = {
      require("neotest-jest")({
        jestCommand = "npm test --",
        jestConfigFile = "jest.config.ts",
        env = { CI = true },
        cwd = function()
          return dir
        end,
      }),
    },
  })
)
```

## Adding plugins or adapters for one project

There are two ways. Adapters already enabled in the base config (for example
jest) need neither.

### Nix way: `mkNvimShell`

`lib.mkNvimShell` from this flake returns a dev shell setup hook. It sets two
variables, and the base config reads them at startup:

- `NVIM_EXTRA_RTP`: the plugins are added to the runtimepath.
- `NVIM_EXTRA_LUA`: the optional `exrc` Lua string runs after startup. It is
  stored in the nix store, so there is no `.nvim.lua` file and no trust prompt.

The `nvim` you already have loads the plugins, and keeps all its other settings
(stylix and so on).

```nix
# in the project's flake.nix
pkgs.mkShell {
  buildInputs = [
    (inputs.sieg-nixvim.lib.mkNvimShell {
      inherit pkgs;
      plugins = with pkgs.vimPlugins; [ neotest-golang ];
      exrc = ''
        require("neotest").setup_project(vim.uv.cwd(), {
          adapters = { require("neotest-golang")() },
        })
      '';
    })
  ];
}
```

- `exrc` is optional. Use `vim.uv.cwd()` for the project directory; start `nvim`
  from the project root.
- The plugin must exist in `pkgs.vimPlugins` (or use `pkgs.vimUtils.buildVimPlugin`).
- Use direnv (`use flake`) so the variables are set in the project directory.
- Plain `mkShell` only. It has not been tried with devenv.
- Delete the plugin from the list to remove it. Nothing is installed globally.
- Your own `.nvim.lua` still loads as well.

### Non-nix way: `vim.pack.add`

Neovim 0.12 or newer. Install the plugin from `.nvim.lua`:

```lua
vim.pack.add({ "https://github.com/fredrikaverpil/neotest-golang" })
```

- Neovim asks for confirmation on the first install. It needs `git`.
- The install is global and not reproducible through nix.
- Deleting the line does not uninstall the plugin. Run
  `:lua vim.pack.del({ "neotest-golang" })` to remove it.

## TODO

- Make a simpler wrapper for this.
