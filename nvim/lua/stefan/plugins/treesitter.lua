--
-- Treesitter configuration and addons
--
return {
  -- Highlight, edit, and navigate code
  -- Also see: https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua#L287-L351
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    -- keys = {
    --   { "<c-space>", desc = "Increment selection" },
    --   { "<bs>", desc = "Decrement selection", mode = "x" },
    -- },
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      context_commentstring = { enable = true, enable_autocmd = false },
      autotag = { enable = true }, -- enable autotagging (w/ nvim-ts-autotag plugin)
      -- ensure these language parsers are installed
      ensure_installed = {
        "bash",
        "c",
        "css",
        "diff",
        "dockerfile",
        "git_rebase",
        "gitcommit",
        "gitignore",
        "html",
        "javascript",
        "json",
        "lua",
        "luadoc",
        "luap",
        "make",
        "markdown",
        "markdown_inline",
        "python",
        "typescript",
        "regex",
        "rego",
        "rst",
        "rust",
        "scss",
        "sql",
        "vim",
        "yaml",
        "toml",
      },
      -- auto install above language parsers
      auto_install = true,
      -- incremental_selection = {
      --   enable = true,
      --   keymaps = {
      --     init_selection = "<C-space>",
      --     node_incremental = "<C-space>",
      --     scope_incremental = "<nop>",
      --     node_decremental = "<bs>",
      --   },
      -- },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
