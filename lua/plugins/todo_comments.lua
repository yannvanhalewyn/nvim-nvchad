return {
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      highlight = {
        -- Don't highlight rest of TODO body
        after = "",
        -- No need for semicolon
        pattern = [[.*<(KEYWORDS)\s*]],
      },
      search = {
        pattern = [[\b(KEYWORDS)]]
      }
    },
  },
}
