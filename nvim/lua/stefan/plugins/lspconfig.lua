local ok, lspconfig = pcall(require, "lspconfig")
if not ok then
   return
end

local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not ok then
   return
end

-- nvim-cmp suppohts additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

-- Change the Diagnostic symbols in the sign column (gutter)
-- local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
   local hl = "DiagnosticSign" .. type
   vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- See https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua#L404-L449
-- for an alternative way to setup mason-lspconfig and the individual LSPs
lspconfig.lua_ls.setup({
   capabilities = capabilities,
   settings = { -- custom settings for lua
      Lua = {
         -- make the language server recognize "vim" global
         diagnostics = {
            globals = { "vim" },
         },
         workspace = {
            -- make language server aware of runtime files
            library = {
               [vim.fn.expand("$VIMRUNTIME/lua")] = true,
               [vim.fn.stdpath("config") .. "/lua"] = true,
            },
         },
      },
   },
})

lspconfig.jedi_language_server.setup({
   capabilities = capabilities,
})

lspconfig.taplo.setup({
   capabilities = capabilities,
})
