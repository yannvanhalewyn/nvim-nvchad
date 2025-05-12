return {
  -- Create own compare and commit routers with
  -- https://github.com/linrongbin16/gitlinker.nvim?tab=readme-ov-file#create-your-own-router
  {
    "linrongbin16/gitlinker.nvim",
    cmd = "GitLink",
    opts = {
      router = {
        -- Usage :GitLink commit [rev=... file=./] This is a change
        commit = {
          ["^github%.com"] = "https://github.com/"
            .. "{_A.ORG}/"
            .. "{_A.REPO}/"
            .. "commit/"
            .. "{_A.REV}"
        },
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
  -- -kajsfakjsfsakj kajsakjs
  -- askfjasfkj
  -- akjsfaksjf
  -- Change
  -- FOO
  --   {
  --
  --
  --   }
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
    "julienvincent/hunk.nvim",
    cmd = { "DiffEditor" },
    -- branch = "jv/ref-sukovkyyzvpp",
    config = function()
      require("hunk").setup({
        keys = {
          global = {
            quit = { "q" },
            accept = { "<C-c><C-c>" },
            focus_tree = { "<leader>n" },
          },

          tree = {
            toggle_node = { "o"},
            expand_node = { "l", "<Right>" },
            collapse_node = { "h", "<Left>" },
            open_file = { "<Cr>" },
            toggle_file = { "s" },
          },

          diff = {
            -- toggles both left and right diff on line.
            -- Use `toggle_line` if you desire to select only one side.
            toggle_line_pair = { "s" },
            toggle_hunk = { "S" },
          },
        },
      })
    end,
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
  -- {
  --   'tanvirtin/vgit.nvim', branch = 'v1.0.x',
  --   dependencies = { 'nvim-lua/plenary.nvim', 'nvim-tree/nvim-web-devicons' },
  --   -- Copied from README, supposed to be necessary
  --   event = 'VimEnter',
  --   config = function()
  --     require("vgit").setup({
  --       settings = {
  --         live_blame = {
  --           enabled = false
  --         }
  --       }
  --     })
  --   end,
  -- }
}
