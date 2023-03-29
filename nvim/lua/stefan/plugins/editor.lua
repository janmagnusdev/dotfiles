--
-- Editor plugins add commands for window management and normal mode file operations
--
return {
  -- Window management
  -- Delete buffer w/o closing splits or windows
  { "vim-scripts/kwbdi.vim", event = "VeryLazy" },
  -- use "moll/vim-bbye"  -- Delete buffer w/o closing splits or windows
  -- tmux & split window navigation
  { "christoomey/vim-tmux-navigator", event = "VeryLazy" },
  -- maximizes and restores current window
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
        desc = "Explorer NeoTree (root dir)",
      },
      {
        "<leader>E",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
        end,
        desc = "Explorer NeoTree (cwd)",
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
        desc = "Open NeoTree in current buffer (like netrw/vinegar)",
      },
      {
        "<C-^",
        function()
          local alternate_nr = vim.w.neo_tree_alternate_nr or vim.fn.bufnr("#") ---@diagnostic disable-line: param-type-mismatch
          vim.w.neo_tree_alternate_nr = nil
          vim.cmd.buffer(alternate_nr)
        end,
        desc = "Switch to alternate file",
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
      -- removes the "Window settings restored" message
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

  -- fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    -- version = false,  # alternative to branch 0.1
    dependencies = {
      -- dependency for better sorting performance
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    cmd = "Telescope",
    keys = {
      -- See https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua#L361-L402
      -- for additional bindings
      -- Maybe create a utility func "get_root" to open telescope from the
      -- current buffer's project instead of the cwd.  See:
      -- - https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/util/init.lua#L49
      -- - https://github.com/LazyVim/LazyVim/discussions/83
      {
        "<leader>,",
        "<cmd>lua require('telescope.builtin').buffers({ sort_mru = true, ignore_current_buffer = true })<cr>",
      },
      {
        "<leader>fb",
        "<cmd>lua require('telescope.builtin').buffers({ sort_mru = true, ignore_current_buffer = true })<cr>",
      },
      { "<leader>/", "<cmd>Telescope find_in_file<cr>" }, -- TODO
      { "<leader>:", "<cmd>Telescope command_history<cr>" },
      { "<leader>.", "<cmd>Telescope find_files<cr>" }, -- find files within current working directory, respects .gitignore
      { "<leader>ff", "<cmd>Telescope find_files<cr>" }, -- find files within current working directory, respects .gitignore
      { "<leader>fs", "<cmd>Telescope live_grep<cr>" }, -- find string in current working directory as you type
      { "<leader>fc", "<cmd>Telescope grep_string<cr>" }, -- find string under cursor in current working directory
      { "<leader>fh", "<cmd>Telescope help_tags<cr>" }, -- list available help tags
      { "<leader>ft", "<cmd>Telescope filetypes<cr>" }, -- list available filetypes tags

      -- telescope git commands (not on youtube nvim video)
      { "<leader>gc", "<cmd>Telescope git_commits<cr>" }, -- list all git commits (use <cr> to checkout) ["gc" for git commits]
      { "<leader>gf", "<cmd>Telescope git_bcommits<cr>" }, -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
      { "<leader>gb", "<cmd>Telescope git_branches<cr>" }, -- list git branches (use <cr> to checkout) ["gb" for git branch]
      { "<leader>gs", "<cmd>Telescope git_status<cr>" }, -- list current changes per file with diff preview ["gs" for git status]
    },
    opts = function()
      local actions = require("telescope.actions")
      return {
        defaults = {
          layout_config = { prompt_position = "top" },
          sorting_strategy = "ascending",
          mappings = {
            i = {
              ["<C-k>"] = actions.move_selection_previous, -- move to prev result
              ["<C-j>"] = actions.move_selection_next, -- move to next result
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
            },
          },
        },
      }
    end,
    -- init = function(plugin)
    --   plugin.load_extension("fzf")
    -- end
  },

  -- which-key
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    -- opts = {
    --   plugins = { spelling = true },
    -- },
    -- config = function(_, opts)
    --   local wk = require("which-key")
    --   wk.setup(opts)
    --   local keymaps = {
    --     mode = { "n", "v" },
    --     ["g"] = { name = "+goto" },
    --     ["gz"] = { name = "+surround" },
    --     ["]"] = { name = "+next" },
    --     ["["] = { name = "+prev" },
    --     ["<leader><tab>"] = { name = "+tabs" },
    --     ["<leader>b"] = { name = "+buffer" },
    --     ["<leader>c"] = { name = "+code" },
    --     ["<leader>f"] = { name = "+file/find" },
    --     ["<leader>g"] = { name = "+git" },
    --     ["<leader>gh"] = { name = "+hunks" },
    --     ["<leader>q"] = { name = "+quit/session" },
    --     ["<leader>s"] = { name = "+search" },
    --     ["<leader>u"] = { name = "+ui" },
    --     ["<leader>w"] = { name = "+windows" },
    --     ["<leader>x"] = { name = "+diagnostics/quickfix" },
    --   }
    --   if Util.has("noice.nvim") then
    --     keymaps["<leader>sn"] = { name = "+noice" }
    --   end
    --   wk.register(keymaps)
    -- end,
  },

  -- Searching and moving around
  { "rhysd/clever-f.vim" },
  { "nelstrom/vim-visual-star-search" },
  { "jremmen/vim-ripgrep" }, -- Run "rg", accepting all cmd line args.  Use quickfix window.
  --use "kyoh86/vim-ripgrep"  -- Run "rg" async, still experimental
  { "stefandtw/quickfix-reflector.vim" }, -- Change code right in the quickfix window

  -- Git integration
  { "tpope/vim-fugitive", event = "VeryLazy" },

  -- show line modifications on left hand side
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      preview_config = {
        border = "rounded",
      },
    },
  },
}
