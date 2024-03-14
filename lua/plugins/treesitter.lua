return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "javascript",
        "markdown",
        "markdown_inline",
        "clojure",
      },
      highlight = {
        additional_vim_regex_highlighting = false
      }
    },
  },
  {
    "nvim-treesitter/playground",
    keys = require("mappings").treesitter_playground["n"]
  },
}
