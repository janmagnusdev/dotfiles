local ok, null_ls = pcall(require, "null-ls")
if not ok then
   return
end

-- for conciseness
local code_actions = null_ls.builtins.code_actions -- to setup formatters
local formatting = null_ls.builtins.formatting -- to setup formatters
local diagnostics = null_ls.builtins.diagnostics -- to setup linters

-- To setup format on save
-- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- configure null_ls
null_ls.setup({
   -- setup formatters & linters
   -- diagnostics_format = "[#{c}] #{m} (#{s})",
   sources = {
      -- ...with({ prefer_local = ".venv/bin" }) arg to use executable from local .venv/bin
      --
      code_actions.gitsigns,
      formatting.trim_newlines,
      formatting.trim_whitespace,
      formatting.stylua.with({ -- lua formatter
         extra_args = {
            "--column-width=100",
            "--indent-type=Spaces",
            "--indent-width=3",
            "--quote-style=AutoPreferDouble",
         },
      }),
      formatting.black,
      formatting.ruff,
      diagnostics.mypy,
      diagnostics.ruff,
   },
   -- configure format on save
   -- on_attach = function(client, bufnr)
   --    if client.supports_method("textDocument/formatting") then
   --       vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
   --       vim.api.nvim_create_autocmd("BufWritePre", {
   --          group = augroup,
   --          buffer = bufnr,
   --          callback = function()
   --             vim.lsp.buf.format({
   --                filter = function(client)
   --                   --  only use null-ls for formatting instead of lsp server
   --                   return client.name == "null-ls"
   --                end,
   --                bufnr = bufnr,
   --             })
   --          end,
   --       })
   --    end
   -- end,
})
