local M = {}

vim.cmd("highlight TabLineFill guifg=#2d3139 guibg=black")
vim.cmd("highlight TabLine guifg=#6f737b guibg=#2d3139")

local function harpoon_segment(number_opts)
  local harpoon = require("harpoon")

  local index
  local listSize

  -- Don't call harpoon:list() this when there is no list yet as it will pollute
  -- harpoon.json with every dir we visit.
  if next(harpoon.lists) then
    local Path = require("plenary.path")
    local list = harpoon:list()
    local display = list:display()
    listSize = #display

    local bufname = Path:new(
      vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
    ):make_relative(list.config.get_root_dir())

    for i, item in ipairs(display) do
      if item == bufname then
        index = i
        break
      end
    end
  end

  if index then
    return "%#St_gitIcons# 󰧻 " .. index .. "/" .. listSize
  else
    return ""
  end
end

M.ui = {
  theme = "onedark",
  tabufline = {
    enabled = false,
  },

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
    ["@symbol"] = { fg = "blue" },
    ["@function"] = { fg = "yellow" },
    ["@function.call"] = { fg = "yellow" },
    DiffAdd = { fg = "#7d9c53", bg = "#31352b" },
    DiffDelete = { fg = "#e06c75", bg = "#511c21" },
    -- DiffDelete = { bg = "#431a1e" },
    DiffChange = { fg = "NONE" },
    DiffText = { bg = "yellow", fg = "NONE", bold = true }, -- Part of changed line that actually changed
  },

  hl_add = {
    ["@string.special.symbol"] = { fg = "blue" },
    NeogitDiffAdd = { fg = "#7d9c53" },
    -- Neogit uses get_fg("Error"), which is dark in my theme not red.
    NeogitDiffDelete = { fg = "#e06c75" },
    NeogitDiffDeleteHighlight = { link = "DiffDelete" },

    -- NeogitDiffAdd = { bg = "none" },
    NeogitChangeModified = { fg = "yellow" },
    NeogitChangeDeleted = { fg = "red" }
  },

  statusline = {
    theme = "default",
    order = { "mode", "file", "harpoon", "git", "%=", "lsp_msg", "diagnostics", "lsp", "cwd", "cursor" },
    modules = {
      file = function()
        local icon = "󰈚"
        local path = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(vim.g.statusline_winid))
        local name = (path == "" and "Empty ") or path:match("([^/\\]+)[/\\]*$")

        if name ~= "Empty " then
          local devicons_present, devicons = pcall(require, "nvim-web-devicons")

          if devicons_present then
            local ft_icon = devicons.get_icon(name)
            icon = (ft_icon ~= nil and ft_icon) or icon
          end
        end

        local relative_path = vim.fn.expand("%:~:.")
        return "%#St_file# " .. icon .. " " .. relative_path .. " " .. "%#St_file_sep#" .. ""
      end,
      cursor = "%#St_pos_sep#" .. "" .. "%#St_pos_icon# %#St_pos_text# %l/%c ",
      harpoon = harpoon_segment,
    },
  },
}

return M
