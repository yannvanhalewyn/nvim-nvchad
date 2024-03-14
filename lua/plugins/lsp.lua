return {
  {
    "neovim/nvim-lspconfig",
    -- dependencies = {
    --   -- format & linting
    --   {
    --     "nvimtools/none-ls.nvim",
    --     config = function()
    --       local null_ls = require "null-ls"
    --
    --       local b = null_ls.builtins
    --
    --       local sources = {
    --         -- webdev stuff
    --         -- so prettier works only on these filetypes
    --         b.formatting.prettier.with { filetypes = { "html", "markdown", "css" } },
    --
    --         -- Lua
    --         b.formatting.stylua,
    --       }
    --
    --       null_ls.setup {
    --         debug = true,
    --         sources = sources,
    --       }
    --     end,
    --   },
    -- },

    config = function()
      local nvchad_lspconfig = require("nvchad.configs.lspconfig")
      local lspconfig = require("lspconfig")
      nvchad_lspconfig.defaults()

      local servers = { "html", "cssls", "lua_ls", "clojure_lsp" }

      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup {
          on_init = nvchad_lspconfig.on_init,
          on_attach = nvchad_lspconfig.on_attach,
          capabilities = nvchad_lspconfig.capabilities,
        }
      end

      vim.diagnostic.config({
        virtual_text = false,
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- lua stuff
        "lua-language-server",
        "stylua",

        -- web dev stuff
        "css-lsp",
        "html-lsp",
        "prettier",
      },
    }
  },
}
