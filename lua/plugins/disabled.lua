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
      config.git.enable = false
      return config
    end
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = false
  }
}
