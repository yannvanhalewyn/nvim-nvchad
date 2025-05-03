return {
  {
    "tpope/vim-surround",
    lazy = false,
  },
  -- Make vim-surround repeatable
  {
    "tpope/vim-repeat",
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
        ["<A-v>"] = "actions.select_vsplit",
        ["<A-s>"] = "actions.select_split",
        ["<A-t>"] = "actions.select_tab",
        ["<C-r>"] = "actions.refresh", -- Changed to this as it was <C-l>
        ["<C-l>"] = false, -- Disable for window navigation keybinds
        ["<C-h>"] = false,
      },
    },
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "karb94/neoscroll.nvim",
    enabled = false, -- not vim.g.neovide,
    -- ~2ms, not worth lazy loading
    lazy = false,
    config = function()
      local mappings = require("mappings").neoscroll["n"]
      require("neoscroll").setup({
        performance_mode = false
      })
      require('neoscroll.config').set_mappings(mappings)
    end
  },
  {
    "windwp/nvim-autopairs",
    lazy = false,
    opts = {
      fast_wrap = {},
    },
    config = function(_, opts)
      require("nvim-autopairs").setup(opts)
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    lazy = false,
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
  {
    'Vonr/align.nvim',
    branch = "v2",
    init   = function()
      for mode, mappings in pairs(require("mappings").align) do
        if not (mode == "plugin") then
          for lhs, config in pairs(mappings) do
            vim.keymap.set(mode, lhs, config[1],
              { noremap = true, silent = true, desc = config[2] }
            )
          end
        end
      end
    end
  }
}
