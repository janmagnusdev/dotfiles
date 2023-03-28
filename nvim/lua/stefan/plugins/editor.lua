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

  {
    "nvim-tree/nvim-tree.lua",
    tag = "nightly", -- updated every week (see issue #1193,
    keys = {
      { "-", ":NvimTreeToggleReplace<cr>" }, -- Show file explorer, replace current buffer
      { "<leader>e", ":NvimTreeFindFileToggle<cr>" }, -- toggle file explorer, show current file
    },
    opts = function(plugin)
      local api = require("nvim-tree.api")
      local function on_attach(bufnr)
        local function opts(desc)
          return {
            desc = "nvim-tree: " .. desc,
            buffer = bufnr,
            noremap = true,
            silent = true,
            nowait = true,
          }
        end
        vim.keymap.set("n", "<CR>", api.node.open.replace_tree_buffer, opts("Open in-place"))
      end

      return {
        on_attach = on_attach,
        actions = {
          open_file = {
            window_picker = {
              enable = false, -- Open file in window from which you opend n.t.
            },
          },
        },
        -- git = {
        --    ignore = false,
        -- },
      }
    end,
    init = function()
      local nvimtree = require("nvim-tree")
      local view = require("nvim-tree.view")
      local api = require("nvim-tree.api")

      -- Recommended settings from nvim-tree documentation
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      -- Configure nvim-tree to behave like vim-vinegar:
      -- - Open current file's parent directory via "-" and replace current buffer
      -- - Open file with <CR> and replace current buffer
      -- - But keep <leader>e (Toggle nvim-tree in vsplit) intact

      local function toggle_replace()
        if view.is_visible() then
          api.tree.close()
        else
          nvimtree.open_replacing_current_buffer()
        end
      end
      vim.api.nvim_create_user_command(
        "NvimTreeToggleReplace",
        toggle_replace,
        { desc = "nvim-tree: Open nvim-tree in-place" }
      )
    end,
  },
  -- { "nvim-neo-tree/neo-tree.nvim",
  --   branch = "v2.x",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
  --     "MunifTanjim/nui.nvim",
  --   }
  -- },
  -- { "tpope/vim-vinegar" }, -- Open slightly improved netrw on pressing "-"

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
