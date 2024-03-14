local cmp = require("cmp")

return {
  {
    "hrsh7th/nvim-cmp",
    opts = {
      mapping = {
        ["<C-q>"] = cmp.mapping.close(),
      },
    }
  },
}
