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
    -- Rebind increment to not use tmux prefix
    ["<esc>"] = { "<cmd>noh<CR>", "Nav Clear highlights" },
    ["+"] = { "<C-a>", "Edit Increment" },
    ["-"] = { "<C-x>", "Edit Decrement" },
    ["S"] = { ":%s/<C-r><C-w>/<C-r><C-w>/gI<left><left><left>", "Replace Current Word" },
    -- ["p"] = { ':norm "+]p<CR>', "Paste and indent" },
    -- ["P"] = { ':norm "+[p<CR>', "Paste and indent" },
  },

  v = {
    ["<A-j>"] = { ":m '>+1<CR>gv=gv", "Edit Move Selection Down" },
    ["<A-k>"] = { ":m '<-2<CR>gv=gv", "Edit Move Selection Up" },
    -- Actually pasting already does this in xmode so ¯\_(ツ)_/¯
    ["<leader>p"] = { '"_dP', "Edit Paste without losing register" },
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

M.buffer = {
  n = {
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
    ["<leader>wQ"] = { "<cmd>qall<CR>", "Window Quit All" },
    ["<leader>wb"] = { vim.cmd.split, "Window Split Horizontally" },
    ["<leader>wv"] = { vim.cmd.vsplit, "Window Split Vertically" },
    ["<leader>w<C-o>"] = { vim.cmd.only, "Window Close other windows" },
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
    -- ["<tab>"] = {vim.cmd.tabnext, "Next Tab"}, -- Conflicts with <C-i>
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
    ["<leader>ft"] = { telescope_cmd "themes", { "Find Themes" }},
    ["<leader>fw"] = { f.grep_current_word, "Find Word at Point" },
    ["<leader>fW"] = { f.grep_current_WORD, "Find WORD at Point" },
    ["<leader>d"] = { "<cmd>Explore %:h<CR>", "Find Current Directory" },
    ["<leader>n"] = { f.open_netrw_filetree, "Find Filetree" },
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
    ["<leader>tc"] = { f.toggle_color_column, "Toggle Color Column" },
    ["<leader>td"] = { f.toggle_diagnostics, "Toggle Diagnostics" },
    ["<leader>tD"] = { f.toggle_diagnostics_virtual_text, "Toggle Diagnostics Virtual Text" },
    ["<leader>te"] = { vim.diagnostic.open_float, "Toggle Error Message" },
    ["<leader>tp"] = { f.toggle_parinfer, "Toggle Parinfer" },
    ["<leader>tq"] = { f.toggle_quickfix_window, "Toggle Quickfix Window" },
    ["<leader>tr"] = { "<cmd>set rnu!<CR>", "Toggle Relative number" },
  }
}

M.code = {
  i = {
    ["<C-k>"] = { vim.lsp.buf.signature_help, "LSP: Signature Help" },
  },
  n = {
    ["[e"] = { vim.diagnostic.goto_prev, "Code Prev Error" },
    ["]e"] = { vim.diagnostic.goto_next, "Code Next Error" },
    ["[c"] = { function() require("gitsigns").prev_hunk() end, "Code Next Unstanged Hunk" },
    ["]c"] = { function() require("gitsigns").next_hunk() end, "Code Previous Unstanged Hunk" },
    ["[q"] = { vim.cmd.cprev, "Quickfix Prev" },
    ["]q"] = { vim.cmd.cnext, "Quickfix Next" },
    ["<C-k>"] = { vim.lsp.buf.signature_help, "Code Signature Help" },
    ["<leader>cr"] = { telescope_cmd "lsp_references", "Code Telescope References" },
    ["<leader>cR"] = { function() require("nvchad.renamer").open() end, "Code Rename", },
    ["<leader>ce"] = { vim.diagnostic.setqflist, "Code Project Diagnostics Quickfix" },
    -- ["<leader>/"] = { telescope_cmd "current_buffer_fuzzy_find", "Find In Current Buffer" },
    ["<leader>/"] = {
      "Telescope live_grep search_dirs={\"%:p\"} vimgrep_arguments=rg,--color=never,--no-heading,--with-filename,--line-number,--column,--smart-case,--fixed-strings",
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
    ["<leader>R"] = { f.refresh_chrome, "Tools Refresh Google Chrome" },
  }
}

-- Plugins
----------
M.git = {
  n = {
    ["<leader>gg"] = { function() require("neogit").open() end, "Git Open" },
    ["<leader>gs"] = { function() require("gitsigns").stage_hunk() end, "Git Stage hunk", },
    ["<leader>gp"] = { function() require("gitsigns").preview_hunk_inline() end, "Git Preview hunk" },
    ["<leader>gB"] = { function() require("agitator").git_blame_toggle {} end, "Git Blame", },
    ["<leader>gf"] = { function() require("agitator").open_file_git_branch() end, "Git Find File", },
    ["<leader>gt"] = { function() require("agitator").git_time_machine() end, "Git Timemachine", }
  },
}

M.harpoon = {
  n = {
    ["<leader>ha"] = { function() require("harpoon"):list():append() end, "Harpoon Add File" },
    ["<leader>H"] = {
      function()
        require("harpoon").ui:toggle_quick_menu(
          require("harpoon"):list(),
          { border = "rounded", title_pos = "center" })
      end,
      "Harpoon Quick Menu"
    },
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
    ["<localleader>tt"] = { ":ConjureCljRunCurrentTest<CR>", "Clojure Run Test at Point" },
    ["<localleader>ct"] = { "m'O<esc>80i;<esc>`'", "Clojure Comment Title" }
  }
}

M.parpar = {
  n = {
    -- Fix J breaking multiline sexps
    -- https://github.com/gpanders/nvim-parinfer/issues/11
    ["J"] = { "A<space><esc>J" },
  },
}

M.paredit = {
  plugin = true,
  n = {
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

-- Setup enabled keymaps
for _name, config in pairs(M) do
  if not config.plugin then
    for mode, mappings in pairs(config) do
      for lhs, mapping in pairs(mappings) do
        vim.keymap.set(mode, lhs, mapping[1], { desc = mapping[2] })
      end
    end
  end
end

return M
