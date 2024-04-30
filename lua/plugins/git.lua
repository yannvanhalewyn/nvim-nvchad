return {
  {
    "sindrets/diffview.nvim",
    cmd = "DiffviewOpen",
    config = function()
      require("diffview").setup({
        enhanced_diff_hl = true
      })
    end
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim", -- optional
      "nvim-telescope/telescope.nvim",
    },
    config = true
  },
  {
    "emmanueltouzery/agitator.nvim",
  },
}
