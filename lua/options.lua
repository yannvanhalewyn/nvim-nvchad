require "nvchad.options"

vim.opt.relativenumber = true
vim.opt.timeoutlen = 500 -- Delay whichkey a bit
vim.opt.inccommand = "split"
vim.wo.wrap = false
vim.g.lua_snippets_path = vim.fn.stdpath("config") .. "/lua/snippets"

-- Fix cursorline not showing with NVChad
-- vim.o.cursorlineopt = "both"

local autocmd = vim.api.nvim_create_autocmd

-- Cleanup whitespace on save
autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local save_cursor = vim.fn.getpos(".")
    -- pcall catches errors
    pcall(function() vim.cmd [[%s/\s\+$//e]] end)
    vim.fn.setpos(".", save_cursor)
  end,
})

-- autocmd("InsertLeave", {
--   pattern = "*",
--   command = "if &aw | silent w | endif"
-- })
--
-- Save buffer on insert leave
-- Disabled because this breaks <c-q> in telescope
-- vim.api.nvim_create_autocmd({ "InsertLeave" }, {
--   callback = function()
--     if vim.api.nvim_buf_get_name(0) ~= 0 and vim.bo.buflisted then
--       vim.cmd "silent w"
--     end
--   end,
-- })

-- Highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Reopen buffer at last stored position
autocmd("BufReadPost", {
  pattern = "*",
  -- silent! because may fail with truncated file before stored point
  command = "silent! normal! g`\"zzzv"
  -- callback = function()
  --   print("CB" .. os.time(os.date("!*t")))
  -- end
})

vim.opt.foldmethod = "indent"
vim.opt.foldnestmax = 1
vim.opt.foldlevel = 1
-- autocmd("FileType", {
--   pattern = {"clojure", "lua"},
--   callback = function()
--     print("CALLED BACK")
--   end,
-- })

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.http",
  callback = function()
    vim.bo.filetype = "sh"
  end,
})

-- Setup HtmlToHiccup
-- vim.cmd("command! HtmlToHiccup '<,'>!xargs -0 hiccup-cli --html")
vim.api.nvim_create_user_command("HtmlToHiccup", "'<,'>!xargs -0 hiccup-cli --html", {range=true})
vim.api.nvim_create_user_command("CljfmtBuffer", "%!cljfmt fix --quiet -", {})
vim.api.nvim_create_user_command("Cljfmt", "'<,'>!cljfmt fix --quiet -", {range=true})
vim.api.nvim_create_user_command("JetPrettyEdn", "'<,'>!jet --from edn --to edn --pretty", {range=true})
-- vim.api.nvim_create_user_command("Cljfmt", "!cljfmt fix <C-r>=expand('%:p')<CR>", {})

-- GUI
vim.o.guifont = "JetBrainsMonoNL Nerd Font Mono:h14"

if vim.g.neovide then
  vim.g.neovide_cursor_animation_length = 0
  vim.g.neovide_cursor_trail_size = 0.4
  vim.g.neovide_cursor_animate_command_line = false
  vim.g.neovide_scroll_animation_length = 0.1

  -- Allow clipboard copy paste in neovim
  vim.g.neovide_input_use_logo = 1
  vim.api.nvim_set_keymap('', '<D-v>', '+p<CR>', { noremap = true, silent = true})
  vim.api.nvim_set_keymap('!', '<D-v>', '<C-R>+', { noremap = true, silent = true})
  vim.api.nvim_set_keymap('t', '<D-v>', '<C-R>+', { noremap = true, silent = true})
  vim.api.nvim_set_keymap('v', '<D-v>', '<C-R>+', { noremap = true, silent = true})
end

vim.cmd("abbreviate organisation organization")
vim.cmd("abbreviate Organisation Organization")

vim.g.yvh_obsidian_root_dir = "/Users/yannvanhalewyn/Library/Mobile Documents/iCloud~md~obsidian/Documents/"


-- In your init.lua file

-- Create an autocommand group for text file settings
-- local text_files = vim.api.nvim_create_augroup("text_file_settings", { clear = true })

-- Apply settings only to markdown and text files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text" },
  -- group = text_files,
  callback = function()
    -- Enable visual wrapping
    vim.opt_local.wrap = true
    -- Wrap at word boundaries
    vim.opt_local.linebreak = true
    -- Set the text width to 80 characters
    vim.opt_local.textwidth = 80
    -- Configure automatic text formatting
    vim.opt_local.formatoptions:append("t")
  end,
})
