local M = {}

M.grep_current_word = function()
  local word = vim.fn.expand("<cword>")
  require("telescope.builtin").grep_string({ search = word})
end

M.grep_current_WORD = function()
  local word = vim.fn.expand("<cWORD>")
  require("telescope.builtin").grep_string({ search = word})
end

M.toggle_color_column = function()
  if vim.api.nvim_get_option_value("colorcolumn", {}) == "" then
    vim.api.nvim_set_option_value("colorcolumn", "80", {})
  else
    vim.api.nvim_set_option_value("colorcolumn", "", {})
  end
end

M.toggle_quickfix_window = function()
  local qf_exists = false

  for _, win in pairs(vim.fn.getwininfo()) do
    if win["quickfix"] == 1 then
      qf_exists = true
    end
  end

  if qf_exists then
    vim.cmd.cclose()
  elseif not vim.tbl_isempty(vim.fn.getqflist()) then
    vim.cmd.copen()
  end
end

M.toggle_diagnostics = function()
  if vim.g.diagnostics_active then
    vim.g.diagnostics_active = false
    vim.diagnostic.hide()
  else
    vim.g.diagnostics_active = true
    vim.diagnostic.show()
  end
end

M.toggle_diagnostics_virtual_text = function()
  if vim.g.diagnostics_virtual_text_active then
    vim.g.diagnostics_virtual_text_active = false
    vim.diagnostic.config({virtual_text = false})
  else
    vim.g.diagnostics_virtual_text_active = true
    vim.diagnostic.config({virtual_text = true})
  end
end

M.refresh_chrome = function()
  -- Append '& active' to activate Chrome
  local script = 'tell application "Google Chrome" to (reload (active tab of (window 1)))'
  local cmd = string.format("osascript -e '%s' 2>&1", script)
  os.execute(cmd)
end

local function pause_parinfer()
  if vim.b.parinfer_enabled then
    local prev_mode = vim.g.parinfer_mode
    vim.b.parinfer_enabled = false
    print("Parinfer Paused")
    return function()
      vim.g.parinfer_mode = "paren"
      vim.b.parinfer_enabled = true
      -- "parinfer.setup" exposes parinfer global
      --- @diagnostic disable-next-line: undefined-global
      parinfer.text_changed(vim.fn.bufnr())
      vim.g.parinfer_mode = prev_mode
      print("Parinfer Resumed")
    end
  else
    return function() end
  end
end

local resume_parinfer = nil

M.toggle_parinfer = function()
  if resume_parinfer then
    resume_parinfer()
    resume_parinfer = nil
  else
    resume_parinfer = pause_parinfer()
  end
end

M.paste_without_parinfer = function()
  require("parpar").wrap(function()
    vim.api.nvim_feedkeys('"+[p')
  end)
end

M.paredit_wrap = function(l, r, placement)
  return function()
    -- place cursor and set mode to `insert`
    local paredit = require("nvim-paredit")
    paredit.cursor.place_cursor(
      -- wrap element under cursor with `( ` and `)`
      paredit.wrap.wrap_element_under_cursor(l, r),
      -- cursor placement opts
      { placement = placement, mode = "insert" }
    )
  end
end

M.open_netrw_filetree = function()
  local prev_size = vim.g.netrw_winsize
  vim.g.netrw_winsize = -30
  vim.cmd("Lexplore")
  vim.g.netrw_winsize = prev_size
end

M.harpoon_select = function(n)
  return function()
    require("harpoon"):list():select(n)
  end
end

return M
