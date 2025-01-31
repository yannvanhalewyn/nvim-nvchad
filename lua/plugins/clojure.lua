local function lsp_indent(event, opts)
  local traversal = require("nvim-paredit.utils.traversal")
  local utils = require("nvim-paredit.indentation.utils")
  local langs = require("nvim-paredit.lang")

  local lang = langs.get_language_api()

  local parent = event.parent

  local child
  if event.type == "slurp-forwards" then
    child = parent:named_child(parent:named_child_count() - 1)
  elseif event.type == "slurp-backwards" then
    child = parent:named_child(1)
  elseif event.type == "barf-forwards" then
    child = traversal.get_next_sibling_ignoring_comments(event.parent, { lang = lang })
  elseif event.type == "barf-backwards" then
    child = event.parent
  else
    return
  end

  local child_range = { child:range() }
  local lines = utils.find_affected_lines(child, utils.get_node_line_range(child_range))

  print("LSP INDENT",  lines[1] + 1, lines[#lines])
  vim.lsp.buf.format({
    bufnr = opts.buf or 0,
    range = {
      ["start"] = { lines[1] + 1, 0 },
      ["end"] = { lines[#lines] + 1, 0 },
    },
  })
end

local function setup_clojure_indentation()
  vim.g.clojure_align_multiline_strings = 1
  vim.g.clojure_align_subforms = 0
  vim.g.clojure_fuzzy_indent = 1
  vim.g.clojure_fuzzy_indent_patterns = { ".*" }
  vim.g.clojure_fuzzy_indent_blacklist = {
    "^or$", "^and$", "=", "^+$", "^-$", "^str$"
  }

  -- Define the custom indentation function
  vim.cmd([[
    function! GetClojureIndent()
      let lnum = v:lnum
      let prev_lnum = prevnonblank(lnum - 1)
      let prev_line = getline(prev_lnum)

      " Check if the previous line starts with a keyword
      echo prev_line
      if prev_line =~ '^\s*(:\w'
        return indent(prev_lnum) + 1
      endif

      " Use default Lisp indentation for other cases
      return lispindent(lnum)
    endfunction
  ]])

  -- Set up an autocommand to apply the custom indentation function
  -- vim.cmd([[
  --   augroup ClojureIndent
  --     autocmd!
  --     autocmd FileType clojure setlocal indentexpr=GetClojureIndent()
  --   augroup END
  -- ]])


  -- local autocmd = vim.api.nvim_create_autocmd
  --
  -- -- Cleanup whitespace on save
  -- autocmd("FileType", {
  --   pattern = "*",
  --   callback = function()
  --     local save_cursor = vim.fn.getpos(".")
  --     -- pcall catches errors
  --     pcall(function() vim.cmd [[%s/\s\+$//e]] end)
  --     vim.fn.setpos(".", save_cursor)
  --   end,
  -- })

end

vim.api.nvim_create_user_command('CheckClojureIndent', function()
  print(vim.inspect(vim.fn.GetClojureIndent()))
end, {})

return {
  {
    "Olical/conjure",
    ft = { "clojure" },
    config = function()
      vim.g["conjure#highlight#enabled"] = true
      setup_clojure_indentation()
      -- vim.g.clojure_align_subforms = 0
      -- vim.g.clojure_fuzzy_indent_patterns = { "^with", "^def", "^let", "^assoc$", "go-loop", "^or$", "^and$", "^=$"}
      -- vim.g.clojure_fuzzy_indent_patterns = { "^.*(?!or)$" }
      -- vim.g.clojure_fuzzy_indent_patterns = { ".*" }
      -- vim.g.clojure_fuzzy_indent_blacklist = { "^or$", "^and$", "^=", "^+", "^-" }
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "clojure",
        callback = function()
          require("nvim-autopairs").remove_rule("'")
        end,
      })
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
          keys = require("mappings").paredit["n"],
          -- indent = {
          --   enabled = true,
          --   indentor = lsp_indent
          -- }
        },
      })
    end
  },
  {
    "julienvincent/clojure-test.nvim",
    -- Trying to get UI to work but not working
    dependencies = { "MunifTanjim/nui.nvim", "nvim-neotest/nvim-nio" },
    ft = { "clojure" },
    config = function()
      require("clojure-test").setup(
        -- list of default keybindings
        {
          keys = {
            ui = {
              expand_node = { "l", "<Right>" },
              collapse_node = { "h", "<Left>" },
              go_to = { "<Cr>", "gd" },

              cycle_focus_forwards = "<Tab>",
              cycle_focus_backwards = "<S-Tab>",

              quit = { "q", "<Esc>" },
            },
          },

          hooks = {
            -- This is a hook that will be called with a table of tests that are about to be run. This
            -- can be used as an opportunity to save files and/or reload clojure namespaces.
            --
            -- This combines really well with https://github.com/tonsky/clj-reload
            before_run = function(tests)
              -- Save all modified buffers
              vim.api.nvim_command("wa")

              local client = require("conjure.client")
              local fn = require("conjure.eval")["eval-str"]
              print("RERESHING ALL NSES")
              print(fn)
              client["with-filetype"]("clojure", fn, {
                origin = "clojure_test.hooks.before_run",
                context = "user",
                code = [[ ((requiring-resolve 'clojure.tools.namespace.repl/refresh)) ]],
              })
            end
          }
        }
      )
      local api = require("clojure-test.api")
      -- 'ta' is overwritten by Conjure. I don't think it's possible to only disable one of them
      -- (see clojure/nrepl/init.fnl in Conjure) but we can disable all of them using
      -- vim.g["conjure#mapping#enable_defaults"] = false
      -- And rebinding the defaults that I did use.
      vim.keymap.set("n", "<localleader>tA", api.run_all_tests, { desc = "Run all tests" })
      vim.keymap.set("n", "<localleader>tt", api.run_tests, { desc = "Run tests" })
      vim.keymap.set("n", "<localleader>tf", api.run_tests_in_ns, { desc = "Run tests in file" })
      vim.keymap.set("n", "<localleader>tl", api.rerun_previous, { desc = "Rerun the most recently run tests" })
      vim.keymap.set("n", "<localleader>tL", api.load_tests, { desc = "Find and load test namespaces in classpath" })
      vim.keymap.set("n", "<localleader>!", function() api.analyze_exception("*e") end, { desc = "Inspect the most recent exception" })
    end
  }
}
