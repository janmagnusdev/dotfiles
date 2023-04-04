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

require("lazy").setup(
  "stefan.plugins",
  {
    ui = { border = "rounded" },
    change_detection = { notify = false },
    checker = {
      enabled = true,
      notify = false,
    },
  }
)
vim.keymap.set("n", "<leader>t", require("lazy.util").float_term)
-- return require("lazy").setup({
--   -- Syntax and text objects
--   -- use "michaeljsmith/vim-indent-object"
--   { "wellle/targets.vim" }, -- Adds new text objects (e.g, func args)
--
--   -- Tools
--   -- use "~/Projects/zettel.vim"
--   -- use "sjl/splice.vim", {"on": "SpliceInit"}
--   --
--   -- Filetype plug-ins
--   -- use {"othree/html5.vim",             ft = "html"}
--   -- use {"Glench/Vim-Jinja2-Syntax",     ft = "jinja"}
--   -- use {"chr4/nginx.vim",               ft = "nginx"}
--   { "mgedmin/coverage-highlight.vim", ft = "python" },
--   { "Vimjas/vim-python-pep8-indent", ft = "python" },
--   { "kalekundert/vim-coiled-snake", ft = "python" },
--   -- use {"rust-lang/rust.vim",           ft = "rust"}
--   -- use {"cespare/vim-toml",             ft = "toml"}
--   -- use {"stephpy/vim-yaml",             ft = "yaml"}
-- })
