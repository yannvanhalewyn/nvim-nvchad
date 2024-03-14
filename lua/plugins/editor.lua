return {
  {
    "tpope/vim-surround",
    lazy = false,
  },
  {
    "karb94/neoscroll.nvim",
    enabled = not vim.g.neovide,
    -- ~2ms, not worth lazy loading
    lazy = false,
    config = function ()
      local mappings = require("mappings").neoscroll["n"]
      require("neoscroll").setup({
        performance_mode = false
      })
      require('neoscroll.config').set_mappings(mappings)
    end
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
  },
  {
    "theprimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup()
    end
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      highlight = {
        -- Don't highlight rest of TODO body
        after = "",
        -- No need for semicolon
        pattern = [[.*<(KEYWORDS)\s*]],
      },
      search = {
        pattern = [[\b(KEYWORDS)]]
      }
    },
  },
  {
    "RRethy/vim-illuminate",
    -- 16ms loading time, lazy load on clojure
    -- Consider using keys with a toggle
    ft = { "clojure", "lua" }
  },
}
