local ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not ok then
   return
end

treesitter.setup({
   highlight = { enable = true },
   indent = { enable = true },
   autotag = { enable = true }, -- enable autotagging (w/ nvim-ts-autotag plugin)
   -- ensure these language parsers are installed
   ensure_installed = {
      "bash",
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
      "make",
      "markdown",
      "python",
      "typescript",
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
})
