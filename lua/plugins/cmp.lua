local function copy(tbl)
  local c = {}
  for k, v in pairs(tbl) do
    c[k] = v
  end
  return c
end

local function tab_complete()
  local cmp = require("cmp")
  return cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.confirm()
    elseif require("luasnip").expand_or_jumpable() then
      vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
    else
      fallback()
    end
  end, { "i", "s" })
end

return {
  {
    "hrsh7th/nvim-cmp",
    opts = function()
      local config = copy(require "nvchad.configs.cmp")
      -- table.insert(config.sources, { name = "supermaven" })
      config.mapping["<CR>"] = nil
      config.mapping["<Tab>"] = tab_complete()
      return config
    end,
  },
  {
    "supermaven-inc/supermaven-nvim",
    event = "InsertEnter",
    config = function()
      require("supermaven-nvim").setup({
        keymaps = {
          accept_suggestion = "<C-c>",
        }
      })
    end,
  },
}
