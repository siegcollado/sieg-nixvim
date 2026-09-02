{ lib, ... }:
{
  globals.markdown_recommended_style = 0;

  plugins.conform-nvim.settings.formatters_by_ft = {
    markdown = [ "prettier" ];
    "markdown.mdx" = [ "prettier" ];
  };

  lsp.servers.marksman.enable = true;

  keymaps = [
    {
      mode = "n";
      key = "<leader>uc";
      action = lib.nixvim.mkRaw ''
        function()
          if vim.wo.conceallevel > 0 then
            vim.w.old_conceallevel = vim.wo.conceallevel
            vim.wo.conceallevel = 0
          else
            vim.wo.conceallevel = vim.w.old_conceallevel or 2
          end
        end
      '';
      options.desc = "Toggle Conceal";
    }
  ];
}
