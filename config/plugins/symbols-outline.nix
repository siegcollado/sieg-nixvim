{
  lib,
  config,
  pkgs,
  ...
}:
{
  # outline.nvim - A better code outline sidebar (fork of symbols-outline.nvim)
  # Actively maintained, fixes treesitter compatibility issues
  extraPlugins = with pkgs.vimPlugins; [
    outline-nvim
  ];

  extraConfigLua = ''
    require("outline").setup({
      outline_window = {
        position = "right",
        relative_width = true,
        width = 25,
        auto_close = false,
        auto_jump = false,
        show_numbers = false,
        show_relative_numbers = false,
        wrap = false,
      },
      outline_items = {
        show_symbol_details = true,
        show_symbol_lineno = false,
        highlight_hovered_item = true,
        auto_set_cursor = true,
        auto_update_events = {
          follow = { "CursorMoved" },
          items = { "InsertLeave" },
        },
      },
      preview_window = {
        auto_preview = false,
        open_hover_on_preview = false,
        width = 50,
        height = 15,
        border = "rounded",
        winhl = "Normal:NormalFloat",
        winblend = 0,
      },
      guides = {
        enabled = true,
        markers = {
          bottom = "└",
          middle = "├",
          vertical = "│",
        },
      },
      symbol_folding = {
        autofold_depth = nil,
        auto_unfold = {
          hovered = true,
          only = 0,
        },
        markers = { "", "" },
      },
      keymaps = {
        close = { "<Esc>", "q" },
        goto_location = "<Cr>",
        goto_and_close = "<S-Cr>",
        hover_symbol = "K",
        toggle_preview = "P",
        rename_symbol = "r",
        code_actions = "a",
        fold = "h",
        unfold = "l",
        fold_all = "W",
        unfold_all = "E",
        fold_reset = "R",
        down_and_jump = "<C-j>",
        up_and_jump = "<C-k>",
      },
      providers = {
        priority = { "lsp", "markdown", "norg", "man" },
        lsp = {
          blacklist_clients = {},
        },
        markdown = {
          filetypes = { "markdown" },
        },
      },
      symbols = {
        icons = {
          File = { icon = "", hl = "@text.uri" },
          Module = { icon = "", hl = "@namespace" },
          Namespace = { icon = "", hl = "@namespace" },
          Package = { icon = "", hl = "@namespace" },
          Class = { icon = "𝓒", hl = "@type" },
          Method = { icon = "ƒ", hl = "@method" },
          Property = { icon = "", hl = "@method" },
          Field = { icon = "", hl = "@field" },
          Constructor = { icon = "", hl = "@constructor" },
          Enum = { icon = "ℰ", hl = "@type" },
          Interface = { icon = "ﰮ", hl = "@type" },
          Function = { icon = "", hl = "@function" },
          Variable = { icon = "", hl = "@constant" },
          Constant = { icon = "", hl = "@constant" },
          String = { icon = "𝓐", hl = "@string" },
          Number = { icon = "#", hl = "@number" },
          Boolean = { icon = "⊨", hl = "@boolean" },
          Array = { icon = "", hl = "@constant" },
          Object = { icon = "⦿", hl = "@type" },
          Key = { icon = "🔐", hl = "@type" },
          Null = { icon = "NULL", hl = "@type" },
          EnumMember = { icon = "", hl = "@field" },
          Struct = { icon = "𝓢", hl = "@type" },
          Event = { icon = "🗲", hl = "@type" },
          Operator = { icon = "+", hl = "@operator" },
          TypeParameter = { icon = "𝙏", hl = "@parameter" },
          Component = { icon = "", hl = "@function" },
          Fragment = { icon = "", hl = "@constant" },
        },
      },
    })
  '';

  # Keymaps for outline
  keymaps = [
    {
      mode = "n";
      key = "<leader>cs";
      action = "<cmd>Outline<CR>";
      options.desc = "Symbols Outline";
    }
  ];

  # Add which-key group
  plugins.which-key.settings.spec = lib.mkAfter [
    {
      __unkeyed-1 = "<leader>c";
      group = "+code";
    }
  ];

  # Add outline highlight groups to transparent plugin
  plugins.transparent = lib.mkIf config.sieg-nixvim.theme.transparent {
    settings.extra_groups = [
      "Outline"
    ];
  };
}
