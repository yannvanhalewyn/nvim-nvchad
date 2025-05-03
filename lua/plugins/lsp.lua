return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "nvimtools/none-ls.nvim",
        config = function()
          local null_ls = require("null-ls")

          local sources = {
            null_ls.builtins.formatting.prettier.with({
              filetypes = { "html", "markdown", "css", "clojure", "rust", "slint" },
            }),
            null_ls.builtins.formatting.stylua,
          }

          null_ls.setup({
            -- debug = true,
            sources = sources,
          })
        end,
      },
    },

    config = function()
      local nvchad_lspconfig = require("nvchad.configs.lspconfig")
      local lspconfig = require("lspconfig")
      nvchad_lspconfig.defaults()

      local servers = { "html", "cssls", "lua_ls", "clojure_lsp", "rust_analyzer", "slint_lsp" }

      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup({
          on_init = nvchad_lspconfig.on_init,
          on_attach = nvchad_lspconfig.on_attach,
          capabilities = nvchad_lspconfig.capabilities,
          -- Not sure if this is necessary, it's in the blink docs but works with the nvchad one as well.
          -- capabilities = require('blink.cmp').get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities()),
          -- capabilities = require('blink.cmp').get_lsp_capabilities(nil),
        })
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
        "slint-lsp",
        "rust-analyzer"
      },
    },
  },
}
