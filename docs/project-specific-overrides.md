# Project specific neovim overrides

## Project specific settings via [exrc.nvim](https://github.com/jedrzejboczar/exrc.nvim)

From readme:

```lua
local ctx = require('exrc').init()
local path_to_this_file = ctx.exrc_path

-- to load first exrc from directories above
ctx:source_up()
```

### Setting neotest test runners

* note: see [langs](../config/plugins/coding/default.nix) for enabled jest adapters.

```lua

local ctx = require("exrc").init()
local neotest = require('neotest')

require("neotest").setup_project(
  ctx.exrc_dir,
  vim.tbl_deep_extend("force", require("neotest.config"), {
    adapters = {
      require("neotest-jest")({
        jestCommand = "npm test --",
        jestConfigFile = "jest.config.ts",
        env = { CI = true },
        cwd = function()
          return ctx.exrc_dir
        end,
      }),
    },
  })
)
```

## TODO

- Make a simpler wrapper for this.
- Runtime install of jest adapters?
