local function is_inside_parent_directory(parent_dir)
  local cwd = vim.fn.getcwd()

  if not parent_dir:match("/$") then
    parent_dir = parent_dir .. "/"
  end

  if not cwd:match("/$") then
    cwd = cwd .. "/"
  end

  return cwd:sub(1, #parent_dir) == parent_dir
end

return {
  {
    "epwalsh/obsidian.nvim",
    lazy = false, -- Completion and links not working when lazy
    enabled = is_inside_parent_directory("/Users/yannvanhalewyn/Library/Mobile Documents/iCloud~md~obsidian/"),
    filetype = "markdown",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      disable_frontmatter = true,
      completion = {
        nvim_cmp = true,  -- disable for using blink
      },
      workspaces = {
        {
          name = "ArQiver",
          path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/ArQiver",
        },
        {
          name = "Personal",
          path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Personal",
        },
        {
          name = "Songbook",
          path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Songbook",
        },
      },
    },
    config = function(_, opts)
      require("obsidian").setup(opts)

      -- HACK: register sources taken from https://github.com/epwalsh/obsidian.nvim/issues/770#issuecomment-2516398527
      -- local cmp = require("cmp")
      -- cmp.register_source("obsidian", require("cmp_obsidian").new())
      -- cmp.register_source("obsidian_new", require("cmp_obsidian_new").new())
      -- cmp.register_source("obsidian_tags", require("cmp_obsidian_tags").new())
    end,
  },
  -- {
  --   "saghen/blink.cmp",
  --   version = "1.*",
  --   event = "InsertEnter",
  --   dependencies = {
  --     {
  --       "L3MON4D3/LuaSnip",
  --       dependencies = { "rafamadriz/friendly-snippets" },
  --       version = "v2.*",
  --       config = function ()
  --         -- Loads json snippets like the markdown ones
  --         require("luasnip.loaders.from_vscode").lazy_load()
  --         require("luasnip.loaders.from_lua").lazy_load({
  --           paths = vim.g.lua_snippets_path or ""
  --         })
  --       end
  --     },
  --     "saghen/blink.compat" --for obsidian.nvim
  --   },
  --   opts = {
  --     sources = {
  --       default = { "obsidian", "obsidian_new", "obsidian_tags" },
  --       providers = {
  --         obsidian = {
  --           name = "obsidian",
  --           module = "blink.compat.source",
  --         },
  --         obsidian_new = {
  --           name = "obsidian_new",
  --           module = "blink.compat.source",
  --         },
  --         obsidian_tags = {
  --           name = "obsidian_tags",
  --           module = "blink.compat.source",
  --         },
  --       },
  --     },
  --     keymap = { preset = 'super-tab', },
  --     snippets = { preset = "luasnip" },
  --     fuzzy = { implementation = "prefer_rust_with_warning" }
  --   },
  -- },
}
