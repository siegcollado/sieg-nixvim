{
  extraConfigLua = ''
    ---@type CoreRoot
    local root = require("utils.root")

    ---@type integer
    local root_group = vim.api.nvim_create_augroup("CoreRoot", { clear = true })

    vim.api.nvim_create_autocmd({ "LspAttach", "BufWritePost", "DirChanged", "BufEnter" }, {
      group = root_group,
      ---@param args { buf: number }
      callback = function(args)
        root.clear_cache(args.buf)
      end,
    })

    ---@type integer
    local group = vim.api.nvim_create_augroup("CoreAutocmds", { clear = true })

    ---@type integer
    local numbertoggle = vim.api.nvim_create_augroup("CoreNumberToggle", { clear = true })

    vim.api.nvim_create_autocmd("TermOpen", {
      group = group,
      callback = function()
        vim.wo.relativenumber = false
        vim.wo.number = false
      end,
    })

    vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter", "CmdlineLeave" }, {
      group = numbertoggle,
      callback = function()
        if vim.wo.number and vim.api.nvim_get_mode().mode ~= "i" then
          vim.wo.relativenumber = true
        end
      end,
    })

    vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave", "CmdlineEnter" }, {
      group = numbertoggle,
      callback = function()
        if vim.wo.number then
          vim.wo.relativenumber = false
          vim.cmd("redraw")
        end
      end,
    })

    vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
      group = group,
      callback = function()
        if vim.bo.buftype ~= "nofile" then
          vim.cmd("checktime")
        end
      end,
    })

    vim.api.nvim_create_autocmd("TextYankPost", {
      group = group,
      callback = function()
        vim.highlight.on_yank()
      end,
    })

    vim.api.nvim_create_autocmd("VimResized", {
      group = group,
      callback = function()
        local tab = vim.fn.tabpagenr()
        vim.cmd("tabdo wincmd =")
        vim.cmd("tabnext " .. tab)
      end,
    })

    vim.api.nvim_create_autocmd("BufReadPost", {
      group = group,
      callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
          if vim.bo.filetype ~= "gitcommit" and vim.fn.line("'\"") > 1 then
            vim.cmd('normal! g`"')
          end
        end
      end,
    })

    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      pattern = {
        "PlenaryTestPopup",
        "help",
        "lspinfo",
        "man",
        "notify",
        "qf",
        "query",
        "spectre_panel",
        "grug-far",
        "startuptime",
        "tsplayground",
        "neotest-output",
        "checkhealth",
        "neotest-summary",
        "neotest-output-panel",
        "dbout",
        "gitsigns-blame",
        "tsplayground",
      },
      callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
      end,
    })

    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      pattern = { "man" },
      callback = function(event)
        vim.bo[event.buf].buflisted = false
      end,
    })

    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
      callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
      end,
    })

    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      pattern = { "json", "jsonc", "json5" },
      callback = function()
        vim.opt_local.conceallevel = 0
      end,
    })

    vim.api.nvim_create_autocmd("BufWritePre", {
      group = group,
      callback = function(event)
        if event.match:match("^%w%w+://") then
          return
        end
        local file = vim.uv.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
      end,
    })
  '';
}
