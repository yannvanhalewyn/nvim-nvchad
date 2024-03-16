require("nvchad.mappings")
local f = require("functions")

local M = {}

vim.g.maplocalleader = ","

local function telescope_cmd(cmd)
  return function()
    require("telescope.builtin")[cmd]()
  end
end

local disabled = {
  n = { "<C-n>", "<C-s>", "<leader>h", "<leader>n", "<leader>v", "<tab>", "<S-tab>" },
}

M.general = {
  i = {
    ["<C-k>"] = { vim.lsp.buf.signature_help, "LSP: Signature Help" },
    ["<C-y>"] = { "<C-o>p", "Put" },
  },
  n = {
    -- Rebind increment to not use tmux prefix
    ["+"] = { "<C-a>", "Increment" },
    ["-"] = { "<C-x>", "Decrement" },
    ["n"] = { "nzz", "Next Search Result" },
    ["N"] = { "Nzz", "Prev Search Result" },
    ["S"] = { ":%s/<C-r><C-w>/<C-r><C-w>/gI<left><left><left>", "Replace Current Word" },
    -- ["<leader>cd"] = { function() vim.lsp.buf.hover() end, "Show doc"},
    ["<leader>tp"] = { f.toggle_parinfer, "Toggle Parinfer" },
    ["<leader>td"] = { f.toggle_diagnostics, "Toggle Diagnostics" },
    ["<leader>tD"] = { f.toggle_diagnostics_virtual_text, "Toggle Diagnostics Virtual Text" },
    ["<leader>tb"] = { function() require("gitsigns").toggle_current_line_blame() end, "Toggle LineBlame", },
    ["gs"] = { function() require("luasnip.loaders").edit_snippet_files() end, "Goto Snippet file", },
    -- ["[b"] = {"<cmd>bprev<CR>", "Prev Buffer"},
    -- ["]b"] = {"<cmd>bnext<CR>", "Next Buffer"},
    ["[e"] = { vim.diagnostic.goto_prev, "Prev Error" },
    ["]e"] = { vim.diagnostic.goto_next, "Next Error" },
    ["[q"] = { vim.cmd.cprev, "Quickfix Prev" },
    ["]q"] = { vim.cmd.cnext, "Quickfix Next" },
    ["[w"] = { vim.cmd.tabprev, "Prev Tab" },
    ["]w"] = { vim.cmd.tabnext, "Next Tab" },
    ["<S-tab>"] = { vim.cmd.tabprev, "Prev Tab" },
    -- ["<tab>"] = {vim.cmd.tabnext, "Next Tab"},
    -- ["gr"] = { telescope_cmd("lsp_references"), "LSP References" },
    ["<C-k>"] = { vim.lsp.buf.signature_help, "LSP: Signature Help" },
    ["<leader>/"] = { telescope_cmd "current_buffer_fuzzy_find", "Find In Current Buffer" },
    -- ["<leader>/"] = {"Telescope live_grep search_dirs={\"%:p\"} vimgrep_arguments=rg,--color=never,--no-heading,--with-filename,--line-number,--column,--smart-case,--fixed-strings", "Find in Current Buffer"},
    ["<leader>x"] = { telescope_cmd "live_grep", "Grep" },
    ["<leader>d"] = { "<cmd>Explore %:h<CR>", "Open Directory" },
    ["<leader><tab>n"] = { vim.cmd.tabnew, "New Tab" },
    ["<leader><tab>d"] = { vim.cmd.tabclose, "Quit Tab" },
    ["<leader>wd"] = { vim.cmd.quit, "Window Quit" },
    ["<leader>wq"] = { ":wall<CR>:wq<CR>", "Window Quit" },
    ["<leader>wb"] = { vim.cmd.split, "Window Split Horizontally" },
    ["<leader>wv"] = { vim.cmd.vsplit, "Window Split Vertically" },
    -- ["<leader>n"] = {"<cmd>NvimTreeToggle<CR>", "NvimTree Toggle"},
    ["<leader>n"] = { f.open_netrw_filetree, "Open Filetree" },
    ["<leader> "] = { telescope_cmd "find_files", "Find files" },
    ["<leader>bb"] = { telescope_cmd "buffers", "Find buffers" },
    ["<leader>bm"] = { "<cmd>messages<CR>", "Messages" },
    ["<leader>cr"] = { telescope_cmd "lsp_references", "Code References" },
    ["<leader>cR"] = {
      function()
        require("nvchad.renamer").open()
      end,
      "LSP rename",
    },
    ["<leader>ce"] = { vim.diagnostic.setqflist, "Code Diagnostics (Buffer)" },
    ["<leader>fd"] = { telescope_cmd "diagnostics", "Find Diagnostics" },
    ["<leader>fr"] = { telescope_cmd "oldfiles", "Find Recent Files" },
    ["<leader>fg"] = { telescope_cmd "git_files", "Find Git Files" },
    ["<leader>fR"] = { telescope_cmd "lsp_references", "Find References" },
    ["<leader>fo"] = { ":Telescope file_browser path=%:p:h select_buffer=true<CR>", "File Browser" },
    ["<leader>fw"] = { f.grep_current_word, "Find Word at Point" },
    ["<leader>fW"] = { f.grep_current_WORD, "Find WORD at Point" },
    ["<leader>fs"] = { vim.cmd.write, "Save File" },
    ["<leader>fS"] = { "<CMD>wall<CR>", "Save All Files" },
    ["<leader>hk"] = { telescope_cmd "keymaps", "Help Keybindings" },
    ["<leader>hh"] = { telescope_cmd "help_tags", "Help Tags" },
    ["p"] = { ':norm "+]p<CR>', "Paste and indent" },
    ["P"] = { ':norm "+[p<CR>', "Paste and indent" },
    ["<leader>R"] = { f.refresh_chrome, "Refresh Google Chrome" },
    ["<leader>tc"] = { f.toggle_color_column, "Toggle Color Column" },
    ["<leader>tq"] = { f.toggle_quickfix_window, "Toggle Quickfix Window" },
    ["<leader>te"] = { vim.diagnostic.open_float, "Toggle Error Message" },
    ["<leader>w<C-o>"] = { vim.cmd.only, "Close other windows" },
    ["<leader>wh"] = { ":windo wincmd H<CR>", "Move Window Left" },
    ["<leader>wj"] = { ":windo wincmd J<CR>", "Move Window Right" },
    ["<leader>wk"] = { ":windo wincmd K<CR>", "Move Window Down" },
    ["<leader>wl"] = { ":windo wincmd L<CR>", "Move Window Up" },
  },

  v = {
    ["<A-j>"] = { ":m '>+1<CR>gv=gv", "Move Selection Down" },
    ["<A-k>"] = { ":m '<-2<CR>gv=gv", "Move Selection Up" },
    -- Actually pasting already does this in xmode so ¯\_(ツ)_/¯
    ["<leader>p"] = { '"_dP', "Paste without losing register" },
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

M.git = {
  n = {
    ["<leader>gg"] = { function() require("neogit").open() end, "Open Neogit" },
    ["<leader>gs"] = { function() require("gitsigns").stage_hunk() end, "Git Stage hunk", },
    ["<leader>gp"] = { function() require("gitsigns").preview_hunk_inline() end, "Git Preview hunk" },
  },
}

M.agitator = {
  n = {
    ["<leader>gB"] = { function() require("agitator").git_blame_toggle {} end, "Git Blame", },
    ["<leader>gf"] = { function() require("agitator").open_file_git_branch() end, "Git Find File", },
    ["<leader>gt"] = { function() require("agitator").git_time_machine() end, "Git Timemachine",
    },
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
    ["gt"] = { "<cmd>TodoQuickFix<CR>", "Show TODOs: Quickfix" },
    ["gT"] = { "<cmd>TodoTrouble<CR>", "Show TODOs: Trouble" },
    ["<leader>ft"] = { "<cmd>TodoTelescope<CR>", "Show TODOs: Telescope" },
  }
}

M.illuminate = {
  n = {
    ["[r"] = {
      function()
        require("illuminate").goto_prev_reference()
        -- vim.api.nvim_feedkeys("zz", "n", false)
      end,
      "Illuminate: Goto next reference"
    },
    ["]r"] = {
      function()
        require("illuminate").goto_next_reference()
        -- vim.api.nvim_feedkeys("zz", "n", false)
      end,
      "Illuminate: Goto next reference"
    }
  }
}

M.treesitter_playground = {
  plugin = true,
  -- TODO use same shape convention and transform
  n = {
    { "<leader>ht", "<cmd>TSHighlightCapturesUnderCursor<CR>", "Show Treesitter Type Popover" },
    { "<leader>hT", "<cmd>TSPlaygroundToggle<CR>", "Open Treesitter Playground" },
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
    ["<localleader>tt"] = { ":ConjureCljRunCurrentTest<CR>" },
    ["<localleader>ct"] = { "m'O<esc>80i;<esc>`'" }
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
    ["<A-H>"] = { function() require("nvim-paredit").api.slurp_backwards() end, "Slurp backwards" },
    ["<A-J>"] = { function() require("nvim-paredit").api.barf_backwards() end, "Barf backwards" },
    ["<A-K>"] = { function() require("nvim-paredit").api.barf_forwards() end, "Barf forwards" },
    ["<A-L>"] = { function() require("nvim-paredit").api.slurp_forwards() end, "Slurp forwards" },
    ["<localleader>w"] = { f.paredit_wrap("( ", ")", "inner_start"), "Wrap element insert head" },
    ["<localleader>W"] = { f.paredit_wrap("(", ")", "inner_end"), "Wrap element insert tail" },
    ["<localleader>i"] = { f.paredit_wrap("( ", ")", "inner_start"), "Wrap form insert head" },
    ["<localleader>I"] = { f.paredit_wrap("(", ")", "inner_end"), "Wrap form insert tail" },
  },
}

-- Clear disabled keymaps
for mode, mappings in pairs(disabled) do
  for _, keys in pairs(mappings) do
    vim.keymap.del(mode, keys)
  end
end

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

-- local mappings = vim.api.nvim_get_keymap("n")
-- for _, v in ipairs(mappings) do
--    -- get word before |
--   -- local desc = v.desc:match("([^|]+)%s*|")
--    -- map("n", v.lhs, v.rhs or v.callback, { desc = desc })
-- end


-- local map = vim.keymap.set

-- map(
--   "n", "<leader>fm",
--   function() require("conform").format() end,
--   { desc = "File Format with conform" }
-- )

return M
