return {
  {
    "tpope/vim-surround",
    lazy = false,
  },
  {
    'stevearc/oil.nvim',
    lazy = false, -- So we can start up with nvim .
    opts = {
      default_file_explorer = true,
      -- view_options = {
      --   show_hidden = true,
      -- },
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-s>"] = "actions.select_vsplit",
        ["<C-h>"] = "actions.select_split",
        ["<C-t>"] = "actions.select_tab",
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = "actions.close",
        ["<C-r>"] = "actions.refresh", -- Changed this for window switching as it was <C-l>
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = "actions.tcd",
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["g."] = "actions.toggle_hidden",
        ["g\\"] = "actions.toggle_trash",
      },
    },
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
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
  }
}
