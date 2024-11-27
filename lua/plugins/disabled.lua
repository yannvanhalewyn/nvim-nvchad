return {
  {
    "NvChad/nvim-colorizer.lua",
    enabled = false
  },
  {
    "nvim-tree/nvim-tree.lua",
    enabled = false,
    -- keys = require("mappings").nvimtree["n"],
    opts = {
      git = {
        enable = false,
      }
    },
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
