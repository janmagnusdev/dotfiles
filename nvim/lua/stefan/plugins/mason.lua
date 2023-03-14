-- import mason plugin safely
local mason_ok, mason = pcall(require, "mason")
if not mason_ok then
   return
end

-- import mason-lspconfig plugin safely
local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_ok then
   return
end

-- import mason-null-ls plugin safely
local mason_null_ls_ok, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_ok then
   return
end

-- enable mason
mason.setup({
   PATH = "append",  -- Give precedence to (Python) tools installed in the current venv
})

mason_lspconfig.setup({
   -- list of servers for mason to install
   ensure_installed = {
      -- "bashls",  -- https://github.com/bash-lsp/bash-language-server
      -- "cssls",
      -- "html",
      "lua_ls",
      -- Markdown:
      -- "marksman",
      -- "prosemd_lsp",
      -- "remark_ls",
      -- "zk",
      "jedi_language_server",
      -- "rust_analyzer",
      "taplo",
      -- "yamlls",
   },
   -- auto-install configured servers (with lspconfig)
   automatic_installation = true, -- not the same as ensure_installed
})

mason_null_ls.setup({
   -- list of formatters & linters for mason to install
   ensure_installed = {
      "stylua",
      "black",
      "mypy",
      "ruff",
   },
   -- auto-install configured formatters & linters (with null-ls)
   automatic_installation = true,
})
