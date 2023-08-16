local util = require("stefan.util")

-- Return a function that calls Telescope
-- cwd is a function that returns the cwd to use for the given command.
---@param builtin string|nil
---@param opts table|nil
local function telescope(builtin, opts)
  local params = { builtin = builtin, opts = opts }
  return function()
    builtin = params.builtin
    opts = params.opts
    if opts and opts.use_root then
      opts.cwd = util.get_root()
    end
    if builtin == nil then
      -- Open ":Telescope" without preview window
      require("telescope.builtin").builtin(require("telescope.themes").get_dropdown({
        previewer = false,
      }))
    elseif builtin == "find_in_file" then
      require("telescope.builtin").current_buffer_fuzzy_find()
      -- require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
      --   previewer = false,
      -- }))
    else
      require("telescope.builtin")[builtin](opts)
    end
  end
end

--
-- Editor plugins add commands for window management and normal mode file operations
--
return {
  -- Delete buffer w/o closing splits or windows
  {
    "moll/vim-bbye",
    keys = {
      { "<leader>bd", "<cmd>Bdelete<cr>", desc = "[B]uffer [d]elete" },
    },
  },

  -- Tmux & Split window navigation
  { "christoomey/vim-tmux-navigator", event = "VeryLazy" },

  -- Maximizes and restores current window
  {
    "szw/vim-maximizer",
    keys = {
      { "<leader>wm", ":MaximizerToggle<cr>", "[W]indow: toggle [m]aximization" },
    },
  },

  -- Helpers (:Rename, :Remove, :Delete, :SudoWrite, :SudoEdit, ...},
  -- ft autodetect after shebang is typed
  { "tpope/vim-eunuch", event = "VeryLazy" },

  -- Copy text as RTF (only macOS)
  { "zerowidth/vim-copy-as-rtf", cmd = "CopyRTF" },

  -- File browser
  -- Behave like netrw/vinegar, see:
  -- https://github.com/nvim-neo-tree/neo-tree.nvim/discussions/813
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    keys = {
      {
        "<leader>e",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = require("stefan.util").get_root() })
        end,
        desc = "File browser: [E]xplore project root dir",
      },
      {
        "<leader>E",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
        end,
        desc = "File browser: [E]xplore cwd",
      },
      {
        "-",
        function()
          if vim.bo.filetype ~= "neo-tree" then
            require("neo-tree.command").execute({
              position = "current",
              reveal = true, -- follow_current_file doesn't work since we replace the buffer
              dir = require("stefan.util").get_root(),
            })
          end
        end,
        desc = "File browser: Open in current buffer (like netrw/vinegar)",
      },
      {
        "<leader>gS", -- "<leader>gs" is used by telescope
        function()
          require("neo-tree.command").execute({ toggle = true, source = "git_status" })
        end,
        desc = "File browser: [G]it [S]tatus",
      },
    },
    init = function()
      vim.g.neo_tree_remove_legacy_commands = 1
      if vim.fn.argc() == 1 then
        local stat = vim.loop.fs_stat(vim.fn.argv(0))
        if stat and stat.type == "directory" then
          require("neo-tree")
        end
      end
    end,
    opts = function()
      local function reveal_parent(state)
        require("neo-tree.ui.renderer").focus_node(state, state.tree:get_node():get_parent_id())
      end

      return {
        default_component_configs = {
          indent = {
            with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
            expander_collapsed = "",
            expander_expanded = "",
            expander_highlight = "NeoTreeExpander",
          },
          modified = {
            symbol = require("stefan.icons").file.modified,
          },
          git_status = {
            symbols = require("stefan.icons").git,
          },
        },
        filesystem = {
          follow_current_file = true,
          bind_to_cwd = false, -- Don't let neo-tree change the cwd
          hijack_netrw_behavior = "open_current",
          window = {
            mappings = {
              ["-"] = reveal_parent,
            },
          },
        },
        window = {
          mappings = {
            -- TODO: keep default or use one of the other two choices?
            -- ["<space>"] = { "toggle_node", nowait = false },  -- default
            -- ["<space>"] = "none",
            -- ["<space>"] = { "toggle_node", nowait = true },
          },
        },
      }
    end,
    config = function(_, opts)
      require("neo-tree").setup(opts)
      -- Removes the "Window settings restored" message
      vim.api.nvim_del_augroup_by_name("NeoTree_BufLeave")
      local bufenter = function(data)
        local pattern = "neo%-tree [^ ]+ %[1%d%d%d%]"
        if string.match(data.file, pattern) then
          vim.w.neo_tree_alternate_nr = vim.fn.bufnr("#") ---@diagnostic disable-line: param-type-mismatch
        end
      end
      vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
        group = vim.api.nvim_create_augroup("NeoTree_BufEnter", { clear = true }),
        pattern = "neo-tree *",
        callback = bufenter,
      })
    end,
  },

  -- Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    -- branch = "0.1.x",
    version = false, -- alternative to branch 0.1
    dependencies = {
      -- dependency for better sorting performance
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    cmd = "Telescope",
    keys = {
      -- Telescope itself
      { "<leader>tl", telescope(), desc = "[T]e[l]escope" },
      { "<leader>tr", telescope("resume"), desc = "[T]elescope: [R]esume" },
      -- Short short cuts for most important commands
      {
        "<leader>,",
        telescope("buffers", { sort_mru = true, ignore_current_buffer = true }),
        desc = "[,] Find buffer (ignore current)",
      },
      { "<leader>.", telescope("find_files"), desc = "[F]ind [f]iles (cwd)" },
      { "<leader>/", telescope("find_in_file"), desc = "[/] Fuzy search in current buffer" },
      { "<leader>:", telescope("command_history"), desc = "[:] Search command history" },
      -- Finding files
      -- lower case means: project's root dir
      -- upper case means: cwd
      {
        "<leader>fb",
        telescope("buffers", { sort_mru = true, show_all_buffers = true }),
        desc = "[F]ind [b]uffer (show all)",
      },
      { "<leader>ff", telescope("find_files", { use_root = true }), desc = "[F]ind [f]iles (project root)" },
      { "<leader>fF", telescope("find_files"), desc = "[F]ind [f]iles (cwd)" },
      { "<leader>fg", telescope("live_grep", { use_root = true }), desc = "[F]ind by [g]rep (project root)" },
      { "<leader>fG", telescope("live_grep"), desc = "[F]ind by [g]rep (cwd)" },
      {
        "<leader>fw",
        telescope("grep_string", { use_root = true }),
        desc = "[F]ind [w]word under cursor (project root)",
      },
      { "<leader>fW", telescope("grep_string"), desc = "[F]ind [w]word under cursor (cwd)" },
      -- { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Find Recent" },
      -- Git
      -- "<leader>gS" is used by neo-tree
      { "<leader>gs", telescope("git_status"), desc = "[G]it: [s]tatus with diff preview" },
      { "<leader>gc", telescope("git_commits"), desc = "[G]it: Find [c]ommits" },
      { "<leader>gc", telescope("git_bcommits"), desc = "[G]it: Find current [f]ile's commits" },
      { "<leader>gb", telescope("git_branches"), desc = "[G]it: Find [b]ranches" },
      -- Find help and Vim internals
      { "<leader>fh", telescope("command_history"), desc = "[:] Search command history" },
      { "<leader>fh", telescope("help_tags"), desc = "[F]ind [h]elp" },
      { "<leader>fM", telescope("man_pages"), desc = "Man Pages" },
      { "<leader>ft", telescope("filetypes"), desc = "[F]ind file [t]ypes" },
      -- Find notificatiosn / messages
      -- { "<leader>fn", "<cmd>Telescope notify<cr>", { desc = "[f]ind [n]otifications" } },
      { "<leader>fN", "<cmd>Telescope noice<cr>", { desc = "[f]ind [n]oice messages" } },
      -- LSP
      { "<leader>ld", telescope("diagnostics", { buf = 0 }), desc = "[L]SP: [d]iagnostics (current buffer)" },
      { "<leader>lD", telescope("diagnostics"), desc = "[L]SP: [d]iagnostics (all buffers)" },
      { "<leader>lr", telescope("lsp_references"), desc = "[L]SP: [r]eferences" },
      {
        "<leader>ls",
        telescope("lsp_document_symbols", {
          -- symbols = {
          --   "Class",
          --   "Function",
          --   "Method",
          --   "Constructor",
          --   "Interface",
          --   "Module",
          --   "Struct",
          --   "Trait",
          --   "Field",
          --   "Property",
          -- },
        }),
        desc = "[L]SP: Goto [s]ymbol (current file)",
      },
      {
        "<leader>lS",
        telescope("lsp_workspace_symbols", {
          -- symbols = {
          --   "Class",
          --   "Function",
          --   "Method",
          --   "Constructor",
          --   "Interface",
          --   "Module",
          --   "Struct",
          --   "Trait",
          --   "Field",
          --   "Property",
          -- },
        }),
        desc = "[L]SP: Goto [s]ymbol (Workspace)",
      },
    },
    opts = function()
      -- require("telescope").load_extension("notify")
      require("telescope").load_extension("noice")
      local actions = require("telescope.actions")
      return {
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          layout_config = { prompt_position = "top" },
          sorting_strategy = "ascending",
          mappings = {
            i = {
              ["<C-k>"] = actions.move_selection_previous, -- move to prev result
              ["<C-j>"] = actions.move_selection_next, -- move to next result
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
              ["<C-s>"] = actions.cycle_previewers_next, -- Cycle previewers (e.g., git diff, commit message, ...)
              ["<C-a>"] = actions.cycle_previewers_prev, -- Cycle previewers (e.g., git diff, commit message, ...)
            },
          },
        },
      }
    end,
    init = function()
      require("telescope").load_extension("fzf")
    end,
  },

  -- Which-key
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = { spelling = { enabled = true } },
      window = {
        border = "rounded",
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      local keymaps = {
        mode = { "n", "v" },
        ["g"] = { name = "+goto/comment" },
        ["z"] = { name = "+fold/spelling" },
        ["]"] = { name = "+next" },
        ["["] = { name = "+prev" },
        ["<leader>b"] = { name = "+buffer" },
        ["<leader>c"] = { name = "+code" },
        ["<leader>f"] = { name = "+find" },
        ["<leader>g"] = { name = "+git" },
        ["<leader>n"] = { name = "+noice/..." },
        ["<leader>q"] = { name = "+quit/session" },
        ["<leader>s"] = { name = "+spelling/..." },
        ["<leader>u"] = { name = "+ui" },
        ["<leader>w"] = { name = "+window" },
        -- ["<leader>x"] = { name = "+diagnostics/quickfix" },
      }
      wk.register(keymaps)
    end,
  },

  -- Extended and improved f, F, t and T key mappings
  { "rhysd/clever-f.vim", event = "VeryLazy" },

  -- Start */# search from visual selections
  { "nelstrom/vim-visual-star-search", event = "VeryLazy" },

  -- Run "rg", accepting all cmd line args.  Use quickfix window.
  {
    "jremmen/vim-ripgrep",
    -- "kyoh86/vim-ripgrep"  -- Run "rg" async, still experimental
    cmd = { "Rg", "RgRoot" },
  },

  -- Change code right in the quickfix window
  { "stefandtw/quickfix-reflector.vim", event = "VeryLazy" },

  -- Git integration
  { "tpope/vim-fugitive", event = "VeryLazy" },

  -- show line modifications on left hand side
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      { "<leader>gn", "<cmd>Gitsigns next_hunk<cr>", desc = "[G]itsigns: [n]ext hunk" },
      { "<leader>gp", "<cmd>Gitsigns prev_hunk<cr>", desc = "[G]itsigns: [p]rev. hunk" },
      { "<leader>ga", "<cmd>Gitsigns stage_hung<cr>", desc = "[G]itsigns: [a]dd (stage) hunk" },
    },
    opts = {
      preview_config = {
        border = "rounded",
      },
    },
  },
}
