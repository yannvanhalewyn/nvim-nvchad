-- Normal "v" command opens an extra split within the bounds of the current
-- netrw window. Which isn't great if you have a buffer open and want to add an
-- extra split to the right. This will (hack) it by opening in an awkward
-- split, noting the filepath, closing the window and opening a new vsplit on
-- that file.
local function ntrw_open_to_right()
  vim.cmd.normal("v")
  local path = vim.fn.expand("%")
  vim.cmd.quit()
  vim.cmd.vsplit(path)
end

local function is_empty(str)
  return str == "" or str == nil
end

-- This sucks remove
local function draw_icons()
  if vim.bo.filetype ~= "netrw" then
    return
  end
  local is_devicons_available, devicons = xpcall(require, debug.traceback, "nvim-web-devicons")
  if not is_devicons_available then
    return
  end

  local default_signs = {
    netrw_dir = {
      text = "",
      texthl = "netrwDir",
    },
    netrw_file = {
      text = "",
      texthl = "netrwPlain",
    },
    netrw_exec = {
      text = "",
      texthl = "netrwExe",
    },
    netrw_link = {
      text = "",
      texthl = "netrwSymlink",
    },
  }
  local bufnr = vim.api.nvim_win_get_buf(0)

  -- Unplace all signs
  vim.fn.sign_unplace("*", { buffer = bufnr })

  -- Define default signs
  for sign_name, sign_opts in pairs(default_signs) do
    vim.fn.sign_define(sign_name, sign_opts)
  end

  local cur_line_nr = 1
  local total_lines = vim.fn.line("$")
  while cur_line_nr <= total_lines do
    -- Set default sign
    local sign_name = "netrw_file"

    -- Get line contents
    local line = vim.fn.getline(cur_line_nr)

    if is_empty(line) or string.sub(line, 0, 1) == "\"" then
      -- If current line is an empty line (newline) then increase current line count
      -- without doing nothing more
      cur_line_nr = cur_line_nr + 1
    else
      if line:find("/$") then
        sign_name = "netrw_dir"
      elseif line:find("@%s+-->") then
        sign_name = "netrw_link"
      elseif line:find("*$") then
        sign_name:find("netrw_exec")
      else
        local filetype = line:match("^.*%.(.*)")
        if not filetype and line:find("LICENSE") then
          filetype = "md"
        elseif line:find("rc$") then
          filetype = "conf"
        end

        -- If filetype is still nil after manually setting extensions
        -- for unknown filetypes then let's use 'default'
        if not filetype then
          filetype = "default"
        end

        local icon, icon_highlight = devicons.get_icon(line, filetype, { default = "" })
        sign_name = "netrw_" .. filetype
        vim.fn.sign_define(sign_name, {
          text = icon,
          texthl = icon_highlight,
        })
      end
      vim.fn.sign_place(cur_line_nr, sign_name, sign_name, bufnr, {
        lnum = cur_line_nr,
      })
      cur_line_nr = cur_line_nr + 1
    end
  end
end

-- This sucks
vim.api.nvim_create_autocmd("FileType", {
  pattern = "netrw",
  callback = function()
    draw_icons()
  end
})

vim.api.nvim_create_autocmd("TextChanged", {
  pattern = "*",
  callback = function()
    draw_icons()
  end
})

vim.keymap.set("n", "V", ntrw_open_to_right, { buffer = true, desc = "Open file in split to the right" })
vim.keymap.set("n", "<C-q>", vim.cmd.quit, {buffer = true, desc = 'Quit (or Close) help, quickfix, netrw, etc windows', })
