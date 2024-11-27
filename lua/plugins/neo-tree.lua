return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    keys = require("mappings").neotree["n"],
    -- See all default configs with:
    -- :lua require("neo-tree").paste_default_config()
    opts = {
      sources = {
        "filesystem",
        "buffers",
        "git_status",
        "document_symbols",
      },
      enable_git_status = false,
      popup_border_style = "rounded",
      filesystem = {
        hijack_netrw_behavior = "disabled",
        window = {
          position = "float",
          mappings = {
            ["<tab>"] = "open",
            ["s"] = "open_split",
            ["v"] = "open_vsplit",
          }
        }
      },
      git_status = {
        window = {
          position = "float",
          mappings = {
            ["s"] = "git_add_file",
            ["u"] = "git_unstage_file",
            ["c"] = "git_add_file",
          }
        }
      },
      document_symbols = {
        follow_cursor = true
      },
      renderers = {
        directory = {
          { "indent" },
          { "icon" },
          { "current_filter" },
          {
            "container",
            content = {
              { "name", zindex = 10 },
              {
                "symlink_target",
                zindex = 10,
                highlight = "NeoTreeSymbolicLinkTarget",
              },
              { "clipboard", zindex = 10 },
              { "diagnostics", errors_only = true, zindex = 20, align = "right", hide_when_expanded = true },
              { "git_status", zindex = 10, align = "right", hide_when_expanded = true },
              -- { "file_size", zindex = 10, align = "right" },
              -- { "type", zindex = 10, align = "right" },
              -- { "last_modified", zindex = 10, align = "right" },
              -- { "created", zindex = 10, align = "right" },
            },
          },
        },
        file = {
          { "indent" },
          { "icon" },
          {
            "container",
            content = {
              {
                "name",
                zindex = 10
              },
              {
                "symlink_target",
                zindex = 10,
                highlight = "NeoTreeSymbolicLinkTarget",
              },
              { "clipboard", zindex = 10 },
              { "bufnr", zindex = 10 },
              { "modified", zindex = 20, align = "right" },
              { "diagnostics",  zindex = 20, align = "right" },
              { "git_status", zindex = 10, align = "right" },
              -- { "file_size", zindex = 10, align = "right" },
              -- { "type", zindex = 10, align = "right" },
              -- { "last_modified", zindex = 10, align = "right" },
              -- { "created", zindex = 10, align = "right" },
            },
          },
        },
      }
    }
  },
}
