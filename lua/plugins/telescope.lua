return {
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      extensions_list = { "themes", "terms", "ui-select" },
    },
    config = function()
      local opts = require("nvchad.configs.telescope")
      -- opts.defaults.preview = false
      opts.extensions_list = { "themes", "terms", "ui-select" }
      require("telescope").setup(opts)
      require("telescope").load_extension("ui-select")
    end,
    dependencies = { "BurntSushi/ripgrep" }
  }
}
