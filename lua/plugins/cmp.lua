local cmp = require("cmp")

return {
  {
    "hrsh7th/nvim-cmp",
    opts = {
      mapping = {
        ["<C-q>"] = cmp.mapping.close(),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.confirm()
          elseif require("luasnip").expand_or_jumpable() then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
          else
            fallback()
          end
        end, { "i", "s", }),
      },
    }
  },
}
