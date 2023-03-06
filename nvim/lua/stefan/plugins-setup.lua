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

   -- Interface and file management
   use({ "nvim-tree/nvim-web-devicons" }) -- Icons used by other plugins (lualine, tree, ...)
   use({ "nvim-lualine/lualine.nvim" }) -- statusline
   use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting performance
   use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" }) -- fuzzy finder
   use({ "nvim-tree/nvim-tree.lua", tag = "nightly" }) -- updated every week (see issue #1193)
   -- use({ "tpope/vim-vinegar" }) -- Open slightly improved netrw on pressing "-"
   use({ "tpope/vim-eunuch" }) -- Helpers (:Rename, :Remove, :Delete, :SudoWrite, :SudoEdit)
   use({ "RRethy/vim-hexokinase", run = "make hexokinase" }) -- Display colors in-line
   use({ "lukas-reineke/indent-blankline.nvim" }) -- Indent guides
   use({ "zerowidth/vim-copy-as-rtf", cmd = "CopyRTF" })

   -- Window management
   use("vim-scripts/kwbdi.vim") -- Delete buffer w/o closing splits or windows
   -- use "moll/vim-bbye"  -- Delete buffer w/o closing splits or windows
   use("christoomey/vim-tmux-navigator") -- tmux & split window navigation
   use("szw/vim-maximizer") -- maximizes and restores current window

   -- Git integration
   use("tpope/vim-fugitive")
   use("lewis6991/gitsigns.nvim") -- show line modifications on left hand side

   -- Syntax and text objects
   use({
      "nvim-treesitter/nvim-treesitter",
      run = function()
         local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
         ts_update()
      end,
   })
   -- use "michaeljsmith/vim-indent-object"
   use("wellle/targets.vim") -- Adds new text objects (e.g, func args)
   -- use "nvim-treesitter/nvim-treesitter-textobjects"  -- Text objects from treesitter nodes

   -- Searching and moving around
   use("rhysd/clever-f.vim")
   use("nelstrom/vim-visual-star-search")
   use("jremmen/vim-ripgrep") -- Run "rg", accepting all cmd line args.  Use quickfix window.
   --use "kyoh86/vim-ripgrep"  -- Run "rg" async, still experimental
   use("stefandtw/quickfix-reflector.vim") -- Change code right in the quickfix window

   -- Editing plug-ins
   use("tpope/vim-repeat") -- Enable repeating with "." for vim-surround
   use("tpope/vim-surround") -- Add, delete, change surroundings
   use("flwyd/vim-conjoin")
   use("numToStr/Comment.nvim") -- Comment lines/blocks with "gc"
   -- use "mg979/vim-visual-multi"
   -- use("inkarkat/vim-ReplaceWithRegister") -- replace with register contents using motion (gr + motion
   use("windwp/nvim-autopairs") -- Autoclose parens, brackets, quotes, etc...
   use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- Autoclose tags

   -- Autocompletion
   use("hrsh7th/nvim-cmp") -- completion plugin
   use("hrsh7th/cmp-buffer") -- source for text in buffer
   use("hrsh7th/cmp-path") -- source for file system paths
   use("L3MON4D3/LuaSnip") -- snippet engine
   use("saadparwaiz1/cmp_luasnip") -- for autocompletion
   use("rafamadriz/friendly-snippets") -- useful snippets

   -- Managing & installing lsp servers, linters & formatters
   use("williamboman/mason.nvim") -- in charge of managing lsp servers, linters & formatters
   use("williamboman/mason-lspconfig.nvim") -- bridges gap b/w mason & lspconfig
   use("neovim/nvim-lspconfig") -- easily configure language servers
   use("hrsh7th/cmp-nvim-lsp") -- for autocompletion
   use("jose-elias-alvarez/null-ls.nvim") -- configure formatters & linters
   use("jay-babu/mason-null-ls.nvim") -- bridges gap b/w mason & null-ls
   use("glepnir/lspsaga.nvim") -- enhanced lsp uis
   use("onsails/lspkind.nvim") -- vs-code like icons for autocompletion

   -- Tools
   -- use "~/Projects/zettel.vim"
   -- use "sjl/splice.vim", {"on": "SpliceInit"}
   --
   -- Filetype plug-ins
   -- use {"othree/html5.vim",             ft = "html"}
   -- use {"Glench/Vim-Jinja2-Syntax",     ft = "jinja"}
   -- use {"chr4/nginx.vim",               ft = "nginx"}
   use({ "mgedmin/coverage-highlight.vim", ft = "python" })
   use({ "Vimjas/vim-python-pep8-indent", ft = "python" })
   use({ "kalekundert/vim-coiled-snake", ft = "python" })
   -- use {"rust-lang/rust.vim",           ft = "rust"}
   -- use {"cespare/vim-toml",             ft = "toml"}
   -- use {"stephpy/vim-yaml",             ft = "yaml"}

   if packer_bootstrap then
      require("packer").sync()
   end
end)
