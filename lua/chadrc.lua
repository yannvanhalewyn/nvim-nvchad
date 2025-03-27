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

local function abbreviate_path(path)
  local terms = {
    "src",
    "com",
    "arqiver"
  }

  local segments = {}
  for segment in path:gmatch("[^/]+") do
    table.insert(segments, segment)
  end

  for i, segment in ipairs(segments) do
    for _, term in ipairs(terms) do
      if segment == term then
        -- segments[i] = "%#Comment#" .. term:sub(1,1) .. "%#StatusLine#"
        segments[i] = term:sub(1,1)
        break
      end
    end
  end

  return table.concat(segments, "/")
end

M.ui = {
  tabufline = {
    enabled = false,
  },

  statusline = {
    theme = "default",
    -- order = { "mode", "file", "harpoon", "git", "%=", "lsp_msg", "diagnostics", "lsp", "cwd", "cursor" },
    order = { "mode", "file", "harpoon", "%=", "lsp_msg", "diagnostics", "cwd", "cursor" },
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
        return "%#St_file# " .. icon .. " " .. abbreviate_path(relative_path) .. " " .. "%#St_file_sep#" .. ""
      end,
      cursor = "%#St_pos_sep#" .. "" .. "%#St_pos_icon# %#St_pos_text# %l/%c ",
      harpoon = harpoon_segment,
    },
  },
}


-- Snippet to load colors from current theme
-- local colors = dofile(vim.g.base46_cache .. "colors")
-- print(colors.black2)

M.base46 = {
  theme = "onedark",
  theme_toggle = { "onedark", "everforest_light"},
  -- Use :Inspect to view highlight groups
  hl_override = {
    Comment = { italic = true },
    ["@spell"] = { italic = true },
    ["@comment"] = { italic = true },
    ["@symbol"] = { fg = "blue" },
    ["@function"] = { fg = "yellow" },
    -- Used heavily by vim diff
    DiffAdd = { fg = "NONE", bg = "#31352b" },
    DiffDelete = { fg = "NONE", bg = "#511c21" },
    -- Part of changed line that actually changed
    -- DiffText = { fg = "NONE", bg = "#373b43", bold = true },
  },

  hl_add = {
    ["@function.call.clojure"] = { fg = "yellow" },
    ["function.call"] = { fg = "yellow" },
    ["function.call.lua"] = { fg = "yellow" },
    -- ["@function.call"] = { fg = "yellow" },
    ["@string.special.symbol"] = { fg = "blue" },

    -- Deleted line in git status when not higlighted
    NeogitDiffDelete = { fg = "#e06c75" },
    -- Deleted line in git status when higlighted
    NeogitDiffDeleteHighlight = { link = "DiffDelete" },
    -- Shows 'midified' in yellow in git status
    NeogitChangeModified = { fg = "yellow" },
    -- Shows 'deleted' in red in git status
    NeogitChangeDeleted = { fg = "red" },
    --
    -- DiffviewDiffChange = { bg = "#2d3139" },
    -- DiffviewDiffAddAsDelete = { link = "DiffDelete" },
  },
}

M.colorify = {
  enabled = false,
}

return M
