local ensure_packer = function()
   local fn = vim.fn
   local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
   if fn.empty(fn.glob(install_path)) > 0 then
      fn.system({
         "git",
         "clone",
         "--depth",
         "1",
         "https://github.com/wbthomason/packer.nvim",
         install_path,
      })
      vim.cmd([[packadd packer.nvim]])
      return true
   end
   return false
end

local packer_bootstrap = ensure_packer()

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

return require("packer").startup(function(use)
   use("wbthomason/packer.nvim") -- packer itself
   use("nvim-lua/plenary.nvim") -- lua functions that many plugins use

   -- Interface plug-ins
   use({ "RRethy/vim-hexokinase", run = "make hexokinase" }) -- Display colors in-line
   use("jremmen/vim-ripgrep") -- Run "rg", accepting all cmd line args.  Use quickfix window.
   --use "kyoh86/vim-ripgrep"  -- Run "rg" async, still experimental
   use("stefandtw/quickfix-reflector.vim") -- Change code right in the quickfix window
   use("tpope/vim-eunuch") -- Helpers (:Rename, :Remove, :Delete, :SudoWrite, :SudoEdit)
   use("vim-scripts/kwbdi.vim") -- Delete buffer w/o closing splits or windows
   -- use "moll/vim-bbye"  -- Delete buffer w/o closing splits or windows
   use({ "zerowidth/vim-copy-as-rtf", cmd = "CopyRTF" })
   use("lukas-reineke/indent-blankline.nvim") -- Indent guides
   -- use "akinsho/toggleterm.nvim"  -- Toggle terminal windows
   use("nvim-tree/nvim-web-devicons") -- Icons used by other plugins (lualine, tree, ...)
   use("tpope/vim-vinegar") -- Open slightly improved netrw on pressing "-"
   use("nvim-lualine/lualine.nvim") -- statusline
   use({
      "nvim-tree/nvim-tree.lua",
      tag = "nightly", -- optional, updated every week. (see issue #1193)
   })
   use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting performance
   use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" }) -- fuzzy finder

   -- Window management
   use("christoomey/vim-tmux-navigator") -- tmux & split window navigation
   use("szw/vim-maximizer") -- maximizes and restores current window

   -- Editing plug-ins
   -- use "flwyd/vim-conjoin"
   -- use "mg979/vim-visual-multi"
   -- use "michaeljsmith/vim-indent-object"
   -- use "nelstrom/vim-visual-star-search"
   use("numToStr/Comment.nvim") -- Comment lines/blocks with "gc"
   use("rhysd/clever-f.vim")
   use("tpope/vim-repeat") -- enable repeating with "." for vim-surround
   use("tpope/vim-surround") -- add, delete, change surroundings
   use("wellle/targets.vim") -- Adds new text objects (e.g, func args)
   -- use "nvim-treesitter/nvim-treesitter-textobjects"  -- Text objects from treesitter nodes
   -- autocompletion
   use("hrsh7th/nvim-cmp") -- completion plugin
   use("hrsh7th/cmp-buffer") -- source for text in buffer
   use("hrsh7th/cmp-path") -- source for file system paths

   -- Tools
   -- use "~/Projects/zettel.vim"
   -- use "sjl/splice.vim", {"on": "SpliceInit"}
   --
   -- Filetype plug-ins
   -- use "othree/html5.vim",             {"for": "html"}
   -- use "Glench/Vim-Jinja2-Syntax",     {"for": "jinja"}
   -- use "chr4/nginx.vim",               {"for": "nginx"}
   -- use "mgedmin/coverage-highlight.vim", {"for": "python"}
   -- use "davidhalter/jedi-vim",         {"for": "python"}
   -- use "vim-python/python-syntax",     {"for": "python"}
   -- use "Vimjas/vim-python-pep8-indent",{"for": "python"}
   -- use "kalekundert/vim-coiled-snake", {"for": "python"}
   -- use "rust-lang/rust.vim",           {"for": "rust"}
   -- use "cespare/vim-toml",             {"for": "toml"}
   -- use "stephpy/vim-yaml",             {"for": "yaml"}

   -- Josean's plugins here
   --
   -- -- essential plugins
   -- use "inkarkat/vim-ReplaceWithRegister") -- replace with register contents using motion (gr + motion

   -- -- snippets
   use("L3MON4D3/LuaSnip") -- snippet engine
   use("saadparwaiz1/cmp_luasnip") -- for autocompletion
   use("rafamadriz/friendly-snippets") -- useful snippets

   -- managing & installing lsp servers, linters & formatters
   use("williamboman/mason.nvim") -- in charge of managing lsp servers, linters & formatters
   use("williamboman/mason-lspconfig.nvim") -- bridges gap b/w mason & lspconfig

   -- configuring lsp servers
   use("neovim/nvim-lspconfig") -- easily configure language servers
   use("hrsh7th/cmp-nvim-lsp") -- for autocompletion
   use({ "glepnir/lspsaga.nvim", branch = "main" }) -- enhanced lsp uis
   use("onsails/lspkind.nvim") -- vs-code like icons for autocompletion

   -- formatting & linting
   use("jose-elias-alvarez/null-ls.nvim") -- configure formatters & linters
   use("jay-babu/mason-null-ls.nvim") -- bridges gap b/w mason & null-ls

   -- treesitter configuration
   use({
      "nvim-treesitter/nvim-treesitter",
      run = function()
         local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
         ts_update()
      end,
   })

   -- auto closing
   use("windwp/nvim-autopairs") -- autoclose parens, brackets, quotes, etc...
   use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- autoclose tags

   -- Git integration
   use("tpope/vim-fugitive")
   -- use "rhysd/git-messenger.vim", {"on": "GitMessenger"}
   use("lewis6991/gitsigns.nvim") -- show line modifications on left hand side

   if packer_bootstrap then
      require("packer").sync()
   end
end)
