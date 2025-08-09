local function copy(tbl)
  local c = {}
  for k, v in pairs(tbl) do
    c[k] = v
  end
  return c
end

-- DEPRECATED replaced by blink.cmp
local function tab_complete()
  local cmp = require("cmp")
  return cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.confirm()
    elseif require("luasnip").expand_or_jumpable() then
      vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
    else
      fallback()
    end
  end, { "i", "s" })
end

-- Obsidian completion creates problem with [{:}]
return {
  {
    "hrsh7th/nvim-cmp",
    enabled = true,
    dependencies = {},
    opts = function()
      local config = copy(require "nvchad.configs.cmp")
      config.mapping["<CR>"] = nil
      config.mapping["<Tab>"] = function ()
        require("cmp").confirm()
      end
      config.sources = {
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "async_path" },
      }
      return config
    end,
  },

  -- { import = "nvchad.blink.lazyspec" },
  {
    "saghen/blink.cmp",
    enabled = false,
    opts = {
      keymap = {
        -- preset = "super-tab",
        ["<tab>"] = { "select_and_accept", "snippet_forward", "fallback" },
        ["<CR>"] = { nil },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
      completion = {
        ghost_text = {
          enabled = false,
        }
      }
    }
  },

  {
    "supermaven-inc/supermaven-nvim",
    event = "InsertEnter",
    enabled = true,
    config = function()
      require("supermaven-nvim").setup({
        keymaps = {
          accept_suggestion = "<C-c>",
        }
      })
    end,
  },
  {
    "augmentcode/augment.vim",
    enabled = false,
    cmd = "Augment",
    config = function()
      vim.g.augment_disable_tab_mapping = true
      vim.keymap.set("i", "<c-c>", "<cmd>call augment#Accept()<cr>")
      vim.g.augment_workspace_folders = {"~/spronq/arqiver"}
    end
  },
  {
    "yetone/avante.nvim",
    enabled = false,
    event = "VeryLazy",
    -- lazy = false,
    version = false,
    opts = {
      provider = "claude",
      providers = {
        claude = {
          endpoint = "https://api.anthropic.com",
          model = "claude-3-5-sonnet-20241022",
          temperature = 0,
          max_tokens = 4096,
        },
      },
      -- openai = {
      --   endpoint = "https://api.openai.com/v1",
      --   model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
      --   timeout = 30000, -- timeout in milliseconds
      --   temperature = 0, -- adjust if needed
      --   max_tokens = 4096,
      --   reasoning_effort = "high" -- only supported for "o" models
      -- },
      hints = { enabled = false }
    },
    build = "make",
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      -- {
      --   -- Make sure to set this up properly if you have lazy=true
      --   'MeanderingProgrammer/render-markdown.nvim',
      --   opts = {
      --     file_types = { "markdown", "Avante" },
      --   },
      --   ft = { "markdown", "Avante" },
      -- },
    },
  }
}
