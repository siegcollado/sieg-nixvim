{
  extraConfigLua = ''
    vim.keymap.set("n", " ", "<Nop>", { silent = true, remap = false })
    vim.g.mapleader = " "

    ---@param mode string|string[]
    ---@param lhs string
    ---@param rhs string|function
    ---@param opts table|nil
    local function map(mode, lhs, rhs, opts)
      local defaults = { noremap = true, silent = true }
      vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", defaults, opts or {}))
    end

    -- escape
    map("i", "jk", "<Esc>")
    map("i", "kj", "<Esc>")

    -- better up/down
    map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true })
    map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true })
    map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true })
    map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true })

    -- window navigation
    map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
    map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
    map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
    map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })
    map("n", "<leader>w/", "<C-w>v", { desc = "Split Window Right" })

    -- window resize
    map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
    map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
    map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
    map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

    -- move lines
    map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
    map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
    map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
    map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
    map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
    map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

    -- buffers
    map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
    map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
    map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
    map("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })
    map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
    map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

    -- clear search
    map({ "i", "n", "s" }, "<esc>", function()
      vim.cmd("noh")
      return "<esc>"
    end, { expr = true, desc = "Escape and Clear hlsearch" })

    -- redraw / clear
    map(
      "n",
      "<leader>ur",
      "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
      { desc = "Redraw / Clear hlsearch / Diff Update" }
    )

    -- saner n/N
    map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
    map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
    map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
    map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
    map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
    map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

    -- undo breakpoints
    map("i", ",", ",<c-g>u")
    map("i", ".", ".<c-g>u")
    map("i", ";", ";<c-g>u")

    -- save file
    map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })
    map("n", "<leader>fs", ":w<cr>", { desc = "Save Buffer" })

    -- keywordprg
    map("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

    -- better indenting
    map("x", "<", "<gv")
    map("x", ">", ">gv")

    -- new file
    map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

    -- recenter on scroll
    map("n", "<C-d>", "<C-d>zz")
    map("n", "<C-u>", "<C-u>zz")

    -- copy file path
    map("n", "<leader>fy", ":let @+=expand('%:p')<cr>", { desc = "Copy File Path" })
    map("n", "<leader>fY", ':let @+=expand("%:p") . ":" . line(".")<cr>', { desc = "Copy File Path + Line" })

    -- formatting
    map({ "n", "x" }, "<leader>cf", function()
      if require("utils.features").safe_require("conform", function(conform)
        conform.format({ lsp_fallback = true })
      end) then
        return
      end
      vim.lsp.buf.format({ timeout_ms = 3000 })
    end, { desc = "Format" })

    -- format toggles
    map("n", "<leader>uf", function()
      vim.g.autoformat = not vim.g.autoformat
      vim.notify("Autoformat: " .. (vim.g.autoformat and "on" or "off"))
    end, { desc = "Toggle Auto Format (Global)" })
    map("n", "<leader>uF", function()
      vim.b.autoformat = not vim.b.autoformat
      vim.notify("Buffer Autoformat: " .. (vim.b.autoformat and "on" or "off"))
    end, { desc = "Toggle Auto Format (Buffer)" })

    -- location list
    map("n", "<leader>xl", function()
      local success, err = pcall(vim.fn.getloclist(0, { winid = 0 }).winid ~= 0 and vim.cmd.lclose or vim.cmd.lopen)
      if not success and err then
        vim.notify(err, vim.log.levels.ERROR)
      end
    end, { desc = "Location List" })

    -- quickfix list
    map("n", "<leader>xq", function()
      local success, err = pcall(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and vim.cmd.cclose or vim.cmd.copen)
      if not success and err then
        vim.notify(err, vim.log.levels.ERROR)
      end
    end, { desc = "Quickfix List" })
    map("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
    map("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })

    -- diagnostics
    local diagnostic_goto = function(next, severity)
      return function()
        vim.diagnostic.jump({
          count = (next and 1 or -1) * vim.v.count1,
          severity = severity and vim.diagnostic.severity[severity] or nil,
          float = true,
        })
      end
    end
    map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
    map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
    map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
    map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
    map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
    map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
    map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

    -- windows
    map("n", "<leader>-", "<C-W>s", { desc = "Split Window Below", remap = true })
    map("n", "<leader>|", "<C-W>v", { desc = "Split Window Right", remap = true })
    map("n", "<leader>wd", "<C-W>c", { desc = "Delete Window", remap = true })

    -- tabs
    map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
    map("n", "<leader><tab>o", "<cmd>tabonly<cr>", { desc = "Close Other Tabs" })
    map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
    map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
    map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
    map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
    map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

    -- avante
    map("n", "<leader>aa", "<cmd>AvanteAsk<CR>", { desc = "Ask Avante" })
    map("n", "<leader>ac", "<cmd>AvanteChat<CR>", { desc = "Chat with Avante" })
    map("n", "<leader>ae", "<cmd>AvanteEdit<CR>", { desc = "Edit Avante" })
    map("n", "<leader>af", "<cmd>AvanteFocus<CR>", { desc = "Focus Avante" })
    map("n", "<leader>ah", "<cmd>AvanteHistory<CR>", { desc = "Avante History" })
    map("n", "<leader>am", "<cmd>AvanteModels<CR>", { desc = "Select Avante Model" })
    map("n", "<leader>an", "<cmd>AvanteChatNew<CR>", { desc = "New Avante Chat" })
    map("n", "<leader>ap", "<cmd>AvanteSwitchProvider<CR>", { desc = "Switch Avante Provider" })
    map("n", "<leader>ar", "<cmd>AvanteRefresh<CR>", { desc = "Refresh Avante" })
    map("n", "<leader>as", "<cmd>AvanteStop<CR>", { desc = "Stop Avante" })
    map("n", "<leader>at", "<cmd>AvanteToggle<CR>", { desc = "Toggle Avante" })
  '';
}
