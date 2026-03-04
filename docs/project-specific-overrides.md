# Project specific neovim overrides

## Project specific settings via [exrc.nvim](https://github.com/jedrzejboczar/exrc.nvim)

From readme:

```lua
local ctx = require('exrc').init()
local path_to_this_file = ctx.exrc_path

-- to load first exrc from directories above
ctx:source_up()
```

### setting up project templates

```lua
local ctx = require('exrc').init()
local path_to_this_file = ctx.exrc_path

-- registering a task template using overseer
local overseer = require('overseer')
overseer.register_template {
    name = 'my local task template',
    condition = { dir = ctx.exrc_dir },
    builder = function(params)
        return {
            name = 'my local task',
            cwd = ctx.exrc_dir,
            cmd = 'echo "running task command"',
        }
    end,
}

overseer.register_template {
    name = 'my local complex task template',
    tags = { overseer.TAG.BUILD },
    params = {
        -- ...
    },
    condition = { dir = ctx.exrc_dir },
    builder = function(params)
        local task = {
            name = 'my local complex task',
            cwd = ctx.exrc_dir,
            strategy = {
                'orchestrator',
                tasks = {
                    { 'shell', name = 'stage 1', cmd = 'echo "setting something up in directory $PWD"' },
                    { 'shell', name = 'stage 2', cmd = 'echo "running build process"' },
                },
            },
        }
        return task
    end,
}
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
