return {
  {
    "Olical/conjure",
    ft = { "clojure" },
    config = function()
      -- vim.g["conjure#highlight#enabled"] = true
      vim.g.clojure_align_subforms = 1
      vim.g.clojure_fuzzy_indent_patterns = { "^with", "^def", "^let", "^assoc"}
    end
  },
  {
    "dundalek/parpar.nvim",
    ft = "clojure",
    dependencies = { "gpanders/nvim-parinfer", "julienvincent/nvim-paredit" },
    config = function()
      local parpar = require("parpar")
      parpar.setup({
        paredit = {
          keys = require("mappings").paredit["n"]
        }
      })
    end
  },
}
