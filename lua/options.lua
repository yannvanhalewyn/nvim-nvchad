require "nvchad.options"

vim.opt.relativenumber = true
vim.opt.timeoutlen = 500 -- Delay whichkey a bit
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

-- Reopen buffer at last stored position
autocmd("BufReadPost", {
  pattern = "*",
  -- silent! because may fail with truncated file before stored point
  command = "silent! normal! g`\"zzzv"
})

-- Setup HtmlToHiccup
vim.cmd("command! HtmlToHiccup '<,'>!xargs -0 hiccup-cli --html")
vim.api.nvim_create_user_command("HtmlToHiccup", "'<,'>!xargs -0 hiccup-cli --html", {range=true})
