local ok, null_ls = pcall(require, "null-ls")
if not ok then
   return
end

-- for conciseness
local code_actions = null_ls.builtins.code_actions -- to setup formatters
local formatting = null_ls.builtins.formatting -- to setup formatters
local diagnostics = null_ls.builtins.diagnostics -- to setup linters

-- to setup format on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- configure null_ls
null_ls.setup({
   -- setup formatters & linters
   sources = {
      -- to disable file types use
      -- "formatting.prettier.with({disabled_filetypes = {}})" (see null-ls docs)
      -- diagnostics.eslint_d.with({ -- js/ts linter
      --   -- only enable eslint if root has .eslintrc.js (not in youtube nvim video)
      --   condition = function(utils)
      --     return utils.root_has_file(".eslintrc.js") -- change file extension if you use something else
      --   end,
      -- }),
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
      formatting.autoflake,
      formatting.isort,
      formatting.black,
      diagnostics.flake8,
      diagnostics.mypy,
   },
   -- configure format on save
   on_attach = function(current_client, bufnr)
      if current_client.supports_method("textDocument/formatting") then
         vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
         vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
               vim.lsp.buf.format({
                  filter = function(client)
                     --  only use null-ls for formatting instead of lsp server
                     return client.name == "null-ls"
                  end,
                  bufnr = bufnr,
               })
            end,
         })
      end
   end,
})