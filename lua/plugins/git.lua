return {
  {
    "sindrets/diffview.nvim",
    cmd = "DiffviewOpen",
    config = function()
      dofile(vim.g.base46_cache .. "git")
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
