{ pkgs, lib, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [
    grug-far-nvim
  ];

  extraConfigLua = ''
    local grug = require("grug-far")
    grug.setup({ headerMaxWidth = 80 })

    function _G.get_search_prefill()
      local search = vim.fn.getreg("/")
      if search == "" then
        search = vim.fn.expand("<cword>")
      end
      return (search ~= "" and search) or nil
    end

    function _G.open_transient_grug()
      local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
      grug.open({
        transient = true,
        prefills = {
          search = _G.get_search_prefill(),
          filesFilter = ext and ext ~= "" and "*." .. ext or nil,
        },
      })
    end
  '';

  keymaps = [
    {
      mode = [
        "n"
        "x"
      ];
      key = "<leader>sr";
      action = lib.nixvim.mkRaw "function() _G.open_transient_grug() end";
      options.desc = "Search/Replace (GrugFar)";
    }
    {
      mode = "n";
      key = "<leader>sR";
      action = "<cmd>GrugFarWithin<cr>";
      options.desc = "Search/Replace (GrugFar Within)";
    }
  ];
}
