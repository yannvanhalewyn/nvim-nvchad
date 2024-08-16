return {
  -- Create own compare and commit routers with
  -- https://github.com/linrongbin16/gitlinker.nvim?tab=readme-ov-file#create-your-own-router
  {
    "linrongbin16/gitlinker.nvim",
    cmd = "GitLink",
    opts = {
      router = {
        -- Usage :GitLink commit [rev=... file=./]
        commit = {
          ["^github%.com"] = "https://github.com/"
            .. "{_A.ORG}/"
            .. "{_A.REPO}/"
            .. "commit/"
            .. "{_A.REV}"
        },
        -- Usage :GitLink compare [rev=ref1..ref2 file=./]
        compare = {
          ["^github%.com"] = "https://github.com/"
            .. "{_A.ORG}/"
            .. "{_A.REPO}/"
            .. "compare/"
            .. "{_A.REV}"
        },
      },
    }
  },
  {
    "sindrets/diffview.nvim",
    cmd = "DiffviewOpen",
    config = function()
      dofile(vim.g.base46_cache .. "git")
      require("diffview").setup({
        enhanced_diff_hl = true,
        view = {
          merge_tool = {
            layout = "diff3_mixed",
            -- disable_diagnostics = true,
            -- winbar_info = true
          }
        }
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
