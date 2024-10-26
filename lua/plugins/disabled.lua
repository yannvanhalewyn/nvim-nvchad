return {
  {
    "NvChad/nvim-colorizer.lua",
    enabled = false
  },
  {
    "nvim-tree/nvim-tree.lua",
    enabled = true,
    keys = require("mappings").nvimtree["n"],
    opts = function()
      local config = require "nvchad.configs.nvimtree"
      config.renderer.highlight_git = false
      return config
    end
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = false
  },
  {
    "folke/which-key.nvim",
    enabled = true,
  },
}
