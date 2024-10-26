-- This doesnt work on startup somehow?
require("nvim-autopairs").remove_rule("'")
vim.bo.commentstring = ";;%s"
