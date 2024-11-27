local f = require("functions")

local M = {}

vim.g.maplocalleader = ","

local function telescope_cmd(cmd)
  return function()
    require("telescope.builtin")[cmd]()
  end
end

M.editing = {
  i = {
    ["<C-y>"] = { "<C-o>p", "Insert Paste" },
  },
  n = {
    ["j"] = { "gj" },
    ["k"] = { "gk" },
    -- Rebind increment to not use tmux prefix
    ["<esc>"] = { "<cmd>noh<CR>", "Nav Clear highlights" },
    ["+"] = { "<C-a>", "Edit Increment" },
    ["-"] = { "<C-x>", "Edit Decrement" },
    ["S"] = { ":%s/<C-r><C-w>/<C-r><C-w>/gI<left><left><left>", "Replace Current Word" },
  },

  v = {
    ["<A-J>"] = { ":m '>+1<CR>gv=gv", "Edit Move Selection Down" },
    ["<A-K>"] = { ":m '<-2<CR>gv=gv", "Edit Move Selection Up" },
    -- Actually pasting already does this in xmode so ¯\_(ツ)_/¯
    ["<leader>p"] = { '"_dP', "Edit Paste without losing register" },
    [">"] = { ">gv"},
    ["<"] = { "<gv"},
    -- [":"] = { "y:<C-r>*<C-b>" }, -- Yank selection and put it in a command
  },

  c = {
    ["<C-a>"] = { "<Home>" },
    ["<C-e>"] = { "<End>" },
    ["<C-p>"] = { "<Up>" },
    ["<C-n>"] = { "<Down>" },
    ["<C-b>"] = { "<Left>" },
    ["<C-f>"] = { "<Right>" },
    ["<M-b>"] = { "<S-Left>" },
    ["<M-f>"] = { "<S-Right>" },
  },
}

M.align = {
  plugin = true,
  x = {
    ["aa"] = {
      function() require("align").align_to_char({ length = 1 }) end,
      "Align to char"
    },
    ["as"] = {
      function()
        require("align").align_to_string({ preview = true, regex = false })
      end,
      "Align to word"
    },
  },
  n = {
    -- Example: gaaap
    ["gaa"] = {
      function()
        local a = require("align")
        a.operator(a.align_to_char)
      end,
      "Align to char motion"
    },
  }
}

M.buffer = {
  n = {
    ["<C-t>"] = {"<C-^>", "Buffer Alternate"},
    ["[b"] = {"<cmd>bprev<CR>", "Buffer Previous"},
    ["]b"] = {"<cmd>bnext<CR>", "Buffer Next"},
		["<leader>bb"] = { telescope_cmd "buffers", "Buffer Find" },
		["<leader>bd"] = { ":bd<CR>", "Buffer Delete" },
		["<leader>bm"] = { "<cmd>messages<CR>", "Buffer Show Messages" },
  }
}

M.window = {
  n = {
    [ "<C-h>"] = { "<C-w>h", "Window Switch left" },
    [ "<C-l>"] = { "<C-w>l", "Window Switch Right" },
    [ "<C-j>"] = { "<C-w>j", "Window Switch Down" },
    [ "<C-k>"] = { "<C-w>k", "Window Switch Up" },
    ["<leader>wd"] = { vim.cmd.quit, "Window Quit" },
    ["<leader>wq"] = { "<cmd>wq<CR>", "Window Save and Quit" },
    ["<leader>wQ"] = { "<cmd>wall<cr><cmd>qall<CR>", "Window Quit All" },
    ["<leader>wb"] = { vim.cmd.split, "Window Split Horizontally" },
    ["<leader>wv"] = { vim.cmd.vsplit, "Window Split Vertically" },
    ["<leader>wo"] = { vim.cmd.only, "Window Close other windows" },
    ["<leader>wh"] = { ":windo wincmd H<CR>", "Window Move Left" },
    ["<leader>wj"] = { ":windo wincmd J<CR>", "Window Move Right" },
    ["<leader>wk"] = { ":windo wincmd K<CR>", "Window Move Down" },
    ["<leader>wl"] = { ":windo wincmd L<CR>", "Window Move Up" },
  }
}

M.tab = {
  n = {
    ["[w"] = { vim.cmd.tabprev, "Tab Previous" },
    ["]w"] = { vim.cmd.tabnext, "Tab Next" },
    ["<leader><tab>n"] = { vim.cmd.tabnew, "Tab New" },
    ["<leader><tab>d"] = { vim.cmd.tabclose, "Tab Delete" },
    ["<S-tab>"] = { vim.cmd.tabprev, "Tab Previous" },
  }
}

M.find = {
  n = {
    ["<leader> "] = { telescope_cmd "find_files", "Find Project Files" },
    ["<leader>fa"] = { "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>", "Find All Files" },
    ["<leader>fd"] = { telescope_cmd "diagnostics", "Find Diagnostics" },
    ["<leader>fg"] = { telescope_cmd "git_files", "Find Git Files" },
    ["<leader>fr"] = { telescope_cmd "oldfiles", "Find Recent Files" },
    ["<leader>fs"] = { vim.cmd.write, "File Save" },
    ["<leader>fS"] = { "<CMD>wall<CR>", "File Save All" },
    ["<leader>fT"] = { "<CMD>Telescope themes<CR>", "Find Themes"},
    ["<leader>fw"] = { f.grep_current_word, "Find Word at Point" },
    ["<leader>fW"] = { f.grep_current_WORD, "Find WORD at Point" },
    -- ["<leader>d"] = { "<cmd>Explore %:h<CR>", "Find Current Directory" },
    ["<leader>d"] = { "<cmd>Oil<CR>", "Find Current Directory" },
    -- ["<leader>n"] = { f.open_netrw_filetree, "Find Filetree" },
  }
}

M.help = {
  n = {
    ["<leader>hk"] = { telescope_cmd "keymaps", "Help Keybindings" },
    ["<leader>hh"] = { telescope_cmd "help_tags", "Help Tags" },
    ["<leader>hc"] = { telescope_cmd "highlights", "Help Highlights" },
  }
}

M.go = {
  n = {
    ["gs"] = { function() require("luasnip.loaders").edit_snippet_files() end, "Goto Snippet file", },
  }
}

M.toggle = {
  n = {
    ["<leader>ch"] = { ":vs<cr><cmd>NvCheatsheet<CR>", "Toggle NvCheatsheet" },
    ["<leader>tb"] = { function() require("gitsigns").toggle_current_line_blame() end, "Toggle LineBlame", },
    ["<leader>tc"] = { function() require("minty.shades").open() end , "Toggle ColorPicker" },
    ["<A-c>"] = { f.toggle_color_column, "Toggle Color Column" },
    ["<A-C>"] = { ":set cursorline!<CR>:set cursorcolumn!<CR>", "Toggle Cursor Highlight" },
    ["<leader>td"] = { f.toggle_diagnostics, "Toggle Diagnostics" },
    ["<leader>tD"] = { f.toggle_diagnostics_virtual_text, "Toggle Diagnostics Virtual Text" },
    ["<leader>te"] = { vim.diagnostic.open_float, "Toggle Error Message" },
    ["<leader>tf"] = { ":set formatexpr=<cr>", "Toggle Format Expression" },
    ["<leader>tp"] = { f.toggle_parinfer, "Toggle Parinfer" },
    ["<leader>tq"] = { f.toggle_quickfix_window, "Toggle Quickfix Window" },
    ["<leader>tr"] = { "<cmd>set rnu!<CR>", "Toggle Relative number" },
    ["<leader>tt"] = { function() require("base46").toggle_theme() end, "Toggle Theme" },
  }
}

M.code = {
  i = {
    ["<C-k>"] = { vim.lsp.buf.signature_help, "LSP: Signature Help" },
  },
  v = {
    ["<leader>cf"] = {":'<,'>!cljfmt fix --quiet -<CR>", "Clojure Format"}
  },
  n = {
    ["[e"] = { vim.diagnostic.goto_prev, "Code Prev Error" },
    ["]e"] = { vim.diagnostic.goto_next, "Code Next Error" },
    ["[c"] = { function() require("gitsigns").prev_hunk() end, "Code Next Unstanged Hunk" },
    ["]c"] = { function() require("gitsigns").next_hunk() end, "Code Previous Unstanged Hunk" },
    ["[q"] = { "<CMD>cprev<CR>zz", "Quickfix Prev" },
    ["]q"] = { "<CMD>cnext<CR>zz", "Quickfix Next" },
    ["<C-k>"] = { vim.lsp.buf.signature_help, "Code Signature Help" },
    ["<leader>cf"] = { ":w<CR>:silent exec \"!cljfmt fix <C-r>=expand('%:p')<CR>\"<CR>", "Clojure Format" },
    -- ["<leader>cf"] = { ":%!cljfmt fix --quiet -<CR>", "Clojure Format" },
    -- ["<leader>cf"] = { function() vim.lsp.buf.format({ async = true }) end, "Code Format" },
    ["<leader>cr"] = { telescope_cmd "lsp_references", "Code Telescope References" },
    ["<leader>cR"] = { function() require("nvchad.lsp.renamer")() end, "Code Rename", },
    ["<leader>ce"] = { vim.diagnostic.setqflist, "Code Project Diagnostics Quickfix" },
    ["<leader>ca"] = { vim.lsp.buf.code_action, "Code LSP Code Actions" },
    ["<leader>/"] = {
      ":Telescope live_grep search_dirs={\"%:p\"} vimgrep_arguments=rg,--color=never,--no-heading,--with-filename,--line-number,--column,--smart-case,--fixed-strings<cr>",
      "Code Search File"
    },
    ["<leader>x"] = { telescope_cmd "live_grep", "Code Search Project" },
  }
}

local session = require("tools.session")

M.sessions = {
  n = {
    ["<leader>sw"] = { session.save_project_session, "Session Write"},
    ["<leader>sl"] = { session.load_project_session, "Session Load" }
  }
}

M.tools = {
  n = {
    ["<leader>R"] = { f.refresh_arc, "Tools Refresh Browser" },
  }
}

-- Plugins
----------
M.git = {
  [{ "n", "v" }] = {
    ["<leader>gll"] = { ":GitLink current_branch<cr>", "Git Link" },
    ["<leader>glL"] = { ":GitLink! current_branch<cr>", "Git Link (Open)" },
    ["<leader>glm"] = { ":GitLink default_branch<cr>", "Git Link Master" },
    ["<leader>glM"] = { ":GitLink! default_branch<cr>", "Git Link Master (Open)" },
    ["<leader>glc"] = { ":GitLink commit file=./ rev=<c-r><c-w><cr>", "Git Link Commit" },
    ["<leader>glC"] = { ":GitLink! commit file=./ rev=<c-r><c-w><cr>", "Git Link Commit (Open)" },
    ["<leader>gld"] = { ":GitLink compare file=./ rev=master..<c-r><c-w>", "Git Link Diff" },
    ["<leader>glD"] = { ":GitLink! compare file=./ rev=master..<c-r><c-w>", "Git Link Diff (Open)" },
  },
  n = {
    ["<leader>gg"] = { function() require("neogit").open() end, "Git Open" },
    ["<leader>gr"] = { function() require("gitsigns").reset_hunk() end, "Git Reset Hunk", },
    ["<leader>gs"] = { function() require("gitsigns").stage_hunk() end, "Git Stage Hunk", },
    ["<leader>gS"] = { function() require("gitsigns").stage_buffer() end, "Git Stage Buffer", },
    ["<leader>gy"] = { function() require("gitsigns").undo_stage_hunk() end, "Git Undo Stage Hunk", },
    ["<leader>gp"] = { function() require("gitsigns").preview_hunk_inline() end, "Git Preview Hunk Inline" },
    ["<leader>gP"] = { function() require("gitsigns").preview_hunk() end, "Git Preview Hunk" },
    ["<leader>gB"] = { function() require("agitator").git_blame_toggle {} end, "Git Blame", },
    -- Somehow this is set already
    -- ["<leader>gb"] = { function() require("agitator").git_blame() end, "Browse File on Github", },
    ["<leader>gd"] = { ":DiffviewOpen<CR>", "Git Diff current index", },
    ["<leader>gD"] = { ":DiffviewOpen master..HEAD", "Git diff something else", },
    ["<leader>gf"] = { function() require("agitator").open_file_git_branch() end, "Git Find File", },
    ["<leader>gt"] = { function() require("agitator").git_time_machine() end, "Git Timemachine", }
  },
}

-- M.nvimtree = {
--   plugin = true,
--   n = {
--     { "<leader>n", ":NvimTreeToggle<cr>", mode = "n", desc = "Toggle NVTree"}
--   }
-- }

M.neotree = {
  plugin = true,
  n = {
    { "<leader>n", ":Neotree reveal<cr>", mode = "n", desc = "Toggle Neotree"},
    { "<leader>gn", ":Neotree git_status<cr>", mode = "n", desc = "Toggle Neotree Document Symbols"},
    { "<leader>N", ":Neotree document_symbols right<cr>", mode = "n", desc = "Toggle Neotree Document Symbols"}
  }
}

M.harpoon = {
  n = {
    ["<leader>ha"] = { function() require("harpoon"):list():add() end, "Harpoon Add File" },
    ["<leader>H"] = {
      function()
        require("harpoon").ui:toggle_quick_menu(
          require("harpoon"):list(),
          { border = "rounded", title_pos = "center" })
      end,
      "Harpoon Quick Menu"
    },
    ["<A-h>"] = { f.harpoon_select(1), "Harpoon Browse File (1)" },
    ["<A-j>"] = { f.harpoon_select(2), "Harpoon Browse File (2)" },
    ["<A-k>"] = { f.harpoon_select(3), "Harpoon Browse File (3)" },
    ["<A-l>"] = { f.harpoon_select(4), "Harpoon Browse File (4)" },
    ["<A-;>"] = { f.harpoon_select(5), "Harpoon Browse File (5)" },
    ["<leader>1"] = { f.harpoon_select(1), "Harpoon Browse File (1)" },
    ["<leader>2"] = { f.harpoon_select(2), "Harpoon Browse File (2)" },
    ["<leader>3"] = { f.harpoon_select(3), "Harpoon Browse File (3)" },
    ["<leader>4"] = { f.harpoon_select(4), "Harpoon Browse File (4)" },
    ["<leader>5"] = { f.harpoon_select(5), "Harpoon Browse File (5)" },
    ["<leader>6"] = { f.harpoon_select(6), "Harpoon Browse File (6)" },
    ["<leader>7"] = { f.harpoon_select(7), "Harpoon Browse File (7)" },
    ["<leader>8"] = { f.harpoon_select(8), "Harpoon Browse File (8)" },
    ["<leader>9"] = { f.harpoon_select(9), "Harpoon Browse File (9)" },
    ["<leader>0"] = { f.harpoon_select(10), "Harpoon Browse File (10)" },
    ["<A-p>"] = { function() require("harpoon"):list():prev() end, "Harpoon Next" },
    ["<A-n>"] = { function() require("harpoon"):list():next() end, "Harpoon Prev" },
  }
}

M.todo_comments = {
  n = {
    ["gt"] = { "<cmd>TodoQuickFix<CR>", "TODOS Quickfix" },
    ["<leader>ft"] = { "<cmd>TodoTelescope<CR>", "TODOS Telescope" },
  }
}

M.illuminate = {
  n = {
    ["[r"] = {
      function()
        require("illuminate").goto_prev_reference()
        -- vim.api.nvim_feedkeys("zz", "n", false)
      end,
      "Code Next Reference"
    },
    ["]r"] = {
      function()
        require("illuminate").goto_next_reference()
        -- vim.api.nvim_feedkeys("zz", "n", false)
      end,
      "Code Prev Reference"
    }
  }
}

M.treesitter_playground = {
  plugin = true,
  -- TODO use same shape convention and transform
  n = {
    { "<leader>ht", "<cmd>TSHighlightCapturesUnderCursor<CR>", "Treesitter Type Popover" },
    { "<leader>hT", "<cmd>TSPlaygroundToggle<CR>", "Treesitter Playground" },
  },
}

local scroll_speed = "50"
M.neoscroll = {
  plugin = true,
  n = {
    ["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", scroll_speed } },
    ["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", scroll_speed } },
    ["<C-b>"] = { "scroll", { "-vim.api.nvim_win_get_height(0)", "true", scroll_speed } },
    ["<C-f>"] = { "scroll", { "vim.api.nvim_win_get_height(0)", "true", scroll_speed } },
    ["<C-y>"] = { "scroll", { "-0.10", "false", scroll_speed } },
    ["<C-e>"] = { "scroll", { "0.10", "false", scroll_speed } },
    ["zt"] = { "zt", { scroll_speed } },
    ["zz"] = { "zz", { scroll_speed } },
    ["zb"] = { "zb", { scroll_speed } },
  },
}

M.conjure = {
  n = {
    ["<localleader>tt"] = { "<cmd>ConjureCljRunCurrentTest<CR>", "Clojure Run Test at Point" },
    ["<localleader>ct"] = { "m'O<esc>80i;<esc>`'", "Clojure Comment Title" },
    ["<localleader>cr"] = { "<cmd>ConjureCljRefreshChanged<CR>", "Clojure Refresh Changed" },
    ["<localleader>cR"] = { "<cmd>ConjureCljRefreshAll<CR>", "Clojure Refresh All" }
  }
}

M.parpar = {
  n = {
    -- Fix J breaking multiline sexps
    -- https://github.com/gpanders/nvim-parinfer/issues/11
    -- This sometimes deletes following lines causing a mess
    -- ["J"] = { "A<space><esc>J" },
  },
}

M.paredit = {
  plugin = true,
  n = {
    -- ["W"] = {},
    ["<A-H>"] = { function() require("nvim-paredit").api.slurp_backwards() end, "Paredit Slurp backwards" },
    ["<A-J>"] = { function() require("nvim-paredit").api.barf_backwards() end, "Paredit Barf backwards" },
    ["<A-K>"] = { function() require("nvim-paredit").api.barf_forwards() end, "Paredit Barf forwards" },
    ["<A-L>"] = { function() require("nvim-paredit").api.slurp_forwards() end, "Paredit Slurp forwards" },
    ["<A-]>"] = { f.paredit_wrap("[", "]", "inner_start"), "Paredit Wrap Element ]" },
    ["<A-}>"] = { f.paredit_wrap("{", "}", "inner_start"), "Paredit Wrap Element }" },
    ["<localleader>w"] = { f.paredit_wrap("( ", ")", "inner_start"), "Paredit Wrap Element Insert Head" },
    ["<localleader>W"] = { f.paredit_wrap("(", ")", "inner_end"), "Paredit Wrap Element Insert Tail" },
    ["<localleader>i"] = { f.paredit_wrap("( ", ")", "inner_start"), "Paredit Wrap Form Insert Head" },
    ["<localleader>I"] = { f.paredit_wrap("(", ")", "inner_end"), "Paredit Wrap Form Insert Tail" },
  },
}

M.term = {
  [{ "n", "t" }] = {
    ["<A-i>"] = {
      function()
        require("nvchad.term").toggle({ pos = "float", id = "floatTerm" })
      end, "Terminal Toggle Floating term"
    }
  }
}

-- Setup enabled keymaps
for _, config in pairs(M) do
  if not config.plugin then
    for mode, mappings in pairs(config) do
      for lhs, mapping in pairs(mappings) do
        vim.keymap.set(mode, lhs, mapping[1], { desc = mapping[2] })
      end
    end
  end
end

return M

-- ["p"] = { ':norm "+]p<CR>', "Paste and indent" },
-- ["P"] = { ':norm "+[p<CR>', "Paste and indent" },
-- ["<tab>"] = {vim.cmd.tabnext, "Next Tab"}, -- Conflicts with <C-i>
-- ["<leader>/"] = { telescope_cmd "current_buffer_fuzzy_find", "Find In Current Buffer" },
