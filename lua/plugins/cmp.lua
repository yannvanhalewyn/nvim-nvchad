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

return {
  {
    "hrsh7th/nvim-cmp",
    enabled = false,
    opts = function()
      local config = copy(require "nvchad.configs.cmp")
      -- table.insert(config.sources, { name = "supermaven" })
      config.mapping["<CR>"] = nil
      config.mapping["<Tab>"] = tab_complete()
      return config
    end,
  },

  {
    "saghen/blink.cmp",
    version = "1.*",
    event = "InsertEnter",
    dependencies = {
      "L3MON4D3/LuaSnip",
      dependencies = { "rafamadriz/friendly-snippets" },
      version = "v2.*",
      config = function ()
        -- Loads json snippets like the markdown ones
        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_lua").lazy_load({
          paths = vim.g.lua_snippets_path or ""
        })
      end
    },
    opts = {
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },

      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = {
        preset = 'super-tab',
      },

      snippets = { preset = "luasnip" },

      -- Auto show the cmdline completion
      cmdline = {
        keymap = {
          ["<tab>"] = { "select_and_accept" }
        },

        completion = {
          menu = {
            auto_show = function(ctx)
              -- Don't immediately open on ':', search and other input menus
              return vim.fn.getcmdtype() == ':'
            end,
          }
        },
      },

      -- I've overwritten Pmenu in chadrc to disable default grey background
      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 0,
          window = {
            border = "single"
          }
        },
        menu = {
          -- Don't show auto-complete menu when there's a snippet active
          -- Note: this is a bit buggy if you don't terminate the snippet with
          -- <tab>. In that case the snippet_active function will keep
          -- returning true
          auto_show = function(ctx)
            return not require("blink.cmp").snippet_active({ direction = 1})
          end,
          border = "single",
          draw = {
            -- Aligns the keyword you've typed to a component in the menu
            -- align_to = 'none', -- or 'none' to disable, or 'cursor' to align to the cursor
            -- Left and right padding, optionally { left, right } for different padding on each side
            padding = 1,
            -- Gap between columns
            gap = 1,
            -- Use treesitter to highlight the label text for the given list of sources
            treesitter = { "lsp" },

            columns = {
              { 'kind_icon' },
              { 'label', 'label_description', gap = 1 },
              { 'kind' },
              { 'source_name'} },
          },

        },
      },
      signature = { enabled = true },

      -- signature


      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
        use_nvim_cmp_as_default = true,
      },

      -- (Default) Rust fuzzy matcher for typo resistance and significantly
      -- better performance You may use a lua implementation instead by using
      -- `implementation = "lua"` or fallback to the lua implementation, when
      -- the Rust fuzzy matcher is not available, by using `implementation =
      -- "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = "prefer_rust_with_warning" }
      -- fuzzy = { implementation = "lua" }
    },
    opts_extend = { "sources.default" }
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
    enabled = true,
    event = "VeryLazy",
    -- lazy = false,
    version = false,
    opts = {
      provider = "claude",
      claude = {
        endpoint = "https://api.anthropic.com",
        model = "claude-3-5-sonnet-20241022",
        temperature = 0,
        max_tokens = 4096,
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
