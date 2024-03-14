local M = {}

vim.cmd("highlight NeogitDiffDelete guifg='#e06c75' guibg='#431a1e'")
vim.cmd("highlight NeogitDiffDeleteHighlight guifg='#e06c75' guibg='#511c21'")
vim.cmd("highlight TabLineFill guifg=#2d3139 guibg=black" )
vim.cmd("highlight TabLine guifg=#6f737b guibg=#2d3139")

M.ui = {
  theme = "onedark",
  tabufline = {
    enabled = false
  },

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
    ["@symbol"] = { fg = "blue" },
    ["@string.special.symbol"] = { fg = "blue" },
    ["@function"] = { fg = "yellow" },
    ["@function.call"] = { fg = "yellow" },

  },

  statusline = {
    theme = "default",
    order = { "mode", "file", "git", "%=", "lsp_msg", "diagnostics", "lsp", "cwd", "cursor" },
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

        local relative_path = vim.fn.expand('%:~:.')
        return "%#St_file# " .. icon .. " " .. relative_path .. " " .. "%#St_file_sep#" .. ""
      end,
      cursor = "%#St_pos_sep#" .. "" .. "%#St_pos_icon# %#St_pos_text# %l/%c "
    },
  },
}

return M
