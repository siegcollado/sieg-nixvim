{
  globals = {
    mapleader = " ";
    maplocalleader = "\\";
    root_spec = [
      "lsp"
      [
        ".git"
        "lua"
      ]
      "cwd"
    ];
    root_lsp_ignore = [ "copilot" ];
  };

  opts = {
    autowrite = true;
    completeopt = [
      "menu"
      "menuone"
      "noselect"
    ];
    conceallevel = 2;
    confirm = true;
    cursorline = true;
    expandtab = true;
    fillchars = {
      foldopen = "";
      foldclose = "";
      fold = " ";
      foldsep = " ";
      diff = "╱";
      eob = " ";
    };
    foldlevel = 99;
    foldmethod = "expr";
    foldexpr = "v:lua.vim.lsp.foldexpr()";
    foldtext = "";
    formatoptions = "jcroqlnt";
    grepformat = "%f:%l:%c:%m";
    grepprg = "rg --vimgrep";
    hlsearch = false;
    ignorecase = true;
    inccommand = "nosplit";
    jumpoptions = "view";
    laststatus = 3;
    linebreak = true;
    list = true;
    mouse = "a";
    number = true;
    pumblend = 10;
    pumheight = 10;
    relativenumber = true;
    ruler = false;
    scrolloff = 4;
    sessionoptions = [
      "buffers"
      "curdir"
      "tabpages"
      "winsize"
      "help"
      "globals"
      "skiprtp"
      "folds"
    ];
    shiftround = true;
    shiftwidth = 2;
    showmode = false;
    showcmd = false;
    showtabline = 1;
    sidescrolloff = 8;
    signcolumn = "yes";
    smartcase = true;
    smartindent = true;
    smoothscroll = true;
    spelllang = [ "en" ];
    splitbelow = true;
    splitkeep = "screen";
    splitright = true;
    tabstop = 2;
    termguicolors = true;
    title = false;
    undofile = true;
    undolevels = 10000;
    updatetime = 200;
    virtualedit = "block";
    wildmode = "longest:full,full";
    winminwidth = 5;
    wrap = false;
  };

  # Runtime-dependent options
  extraConfigLuaPre = ''
    vim.opt.clipboard = vim.env.SSH_CONNECTION and "" or "unnamedplus"
    vim.opt.timeoutlen = vim.g.vscode and 1000 or 300
    vim.opt.shortmess:append({ W = true, I = true, c = true, C = true })
  '';
}
