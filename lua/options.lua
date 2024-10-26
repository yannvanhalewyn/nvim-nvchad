require "nvchad.options"

vim.opt.relativenumber = true
vim.opt.timeoutlen = 500 -- Delay whichkey a bit
vim.opt.inccommand = "split"
vim.g.lua_snippets_path = vim.fn.stdpath("config") .. "/lua/snippets"

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
-- vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
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

