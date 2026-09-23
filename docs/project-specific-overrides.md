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

## TODO

- Make a simpler wrapper for this.
- Runtime install of adapters with `vim.pack.add` (Neovim 0.12 or newer).
