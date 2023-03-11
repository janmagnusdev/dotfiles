local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
   vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
   })
end
vim.opt.rtp:prepend(lazypath)

return require("lazy").setup({
   { "wbthomason/packer.nvim" }, -- packer itself
   { "nvim-lua/plenary.nvim" }, -- lua functions that many plugins use

   -- Interface and file management
   { "nvim-tree/nvim-web-devicons" }, -- Icons used by other plugins (lualine, tree, ...,
   { "nvim-lualine/lualine.nvim" }, -- statusline
   { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }, -- dependency for better sorting performance
   { "nvim-telescope/telescope.nvim", branch = "0.1.x" }, -- fuzzy finder
   { "nvim-tree/nvim-tree.lua", tag = "nightly" }, -- updated every week (see issue #1193,
   -- { "tpope/vim-vinegar" }, -- Open slightly improved netrw on pressing "-"
   { "tpope/vim-eunuch" }, -- Helpers (:Rename, :Remove, :Delete, :SudoWrite, :SudoEdit,
   { "RRethy/vim-hexokinase", build = "make hexokinase" }, -- Display colors in-line
   { "lukas-reineke/indent-blankline.nvim" }, -- Indent guides
   { "zerowidth/vim-copy-as-rtf", cmd = "CopyRTF" },

   -- Window management
   { "vim-scripts/kwbdi.vim" }, -- Delete buffer w/o closing splits or windows
   -- use "moll/vim-bbye"  -- Delete buffer w/o closing splits or windows
   { "christoomey/vim-tmux-navigator" }, -- tmux & split window navigation
   { "szw/vim-maximizer" }, -- maximizes and restores current window

   -- Git integration
   { "tpope/vim-fugitive" },
   { "lewis6991/gitsigns.nvim" }, -- show line modifications on left hand side

   -- Syntax and text objects
   { -- Highlight, edit, and navigate code
      "nvim-treesitter/nvim-treesitter",
      dependencies = {
         "nvim-treesitter/nvim-treesitter-textobjects",
      },
      config = function()
         pcall(require("nvim-treesitter.install").update({ with_sync = true }))
      end,
   },
   -- use "michaeljsmith/vim-indent-object"
   { "wellle/targets.vim" }, -- Adds new text objects (e.g, func args)

   -- Searching and moving around
   { "rhysd/clever-f.vim" },
   { "nelstrom/vim-visual-star-search" },
   { "jremmen/vim-ripgrep" }, -- Run "rg", accepting all cmd line args.  Use quickfix window.
   --use "kyoh86/vim-ripgrep"  -- Run "rg" async, still experimental
   { "stefandtw/quickfix-reflector.vim" }, -- Change code right in the quickfix window

   -- Editing plug-ins
   { "tpope/vim-repeat" }, -- Enable repeating with "." for vim-surround
   { "tpope/vim-surround" }, -- Add, delete, change surroundings
   { "flwyd/vim-conjoin" },
   { "numToStr/Comment.nvim" }, -- Comment lines/blocks with "gc"
   -- use "mg979/vim-visual-multi"
   -- {"inkarkat/vim-ReplaceWithRegister"}, -- replace with register contents using motion (gr + motion
   { "windwp/nvim-autopairs" }, -- Autoclose parens, brackets, quotes, etc...
   { "windwp/nvim-ts-autotag", dependencies = {"nvim-treesitter"} }, -- Autoclose tags

   -- Autocompletion
   { "hrsh7th/nvim-cmp" }, -- completion plugin
   { "hrsh7th/cmp-buffer" }, -- source for text in buffer
   { "hrsh7th/cmp-path" }, -- source for file system paths
   { "L3MON4D3/LuaSnip" }, -- snippet engine
   { "saadparwaiz1/cmp_luasnip" }, -- for autocompletion
   { "rafamadriz/friendly-snippets" }, -- useful snippets

   -- Managing & installing lsp servers, linters & formatters
   { "williamboman/mason.nvim" }, -- in charge of managing lsp servers, linters & formatters
   { "williamboman/mason-lspconfig.nvim" }, -- bridges gap b/w mason & lspconfig
   { "neovim/nvim-lspconfig" }, -- easily configure language servers
   { "hrsh7th/cmp-nvim-lsp" }, -- for autocompletion
   { "jose-elias-alvarez/null-ls.nvim" }, -- configure formatters & linters
   { "jay-babu/mason-null-ls.nvim" }, -- bridges gap b/w mason & null-ls
   { "glepnir/lspsaga.nvim" }, -- enhanced lsp uis
   { "onsails/lspkind.nvim" }, -- vs-code like icons for autocompletion

   -- Tools
   -- use "~/Projects/zettel.vim"
   -- use "sjl/splice.vim", {"on": "SpliceInit"}
   --
   -- Filetype plug-ins
   -- use {"othree/html5.vim",             ft = "html"}
   -- use {"Glench/Vim-Jinja2-Syntax",     ft = "jinja"}
   -- use {"chr4/nginx.vim",               ft = "nginx"}
   { "mgedmin/coverage-highlight.vim", ft = "python" },
   { "Vimjas/vim-python-pep8-indent", ft = "python" },
   { "kalekundert/vim-coiled-snake", ft = "python" },
   -- use {"rust-lang/rust.vim",           ft = "rust"}
   -- use {"cespare/vim-toml",             ft = "toml"}
   -- use {"stephpy/vim-yaml",             ft = "yaml"}
})
