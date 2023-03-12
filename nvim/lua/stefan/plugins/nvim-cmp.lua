local ok, cmp = pcall(require, "cmp")
if not ok then
   return
end

local ok, luasnip = pcall(require, "luasnip")
if not ok then
   return
end

-- import lspkind plugin safely
local ok, lspkind = pcall(require, "lspkind")
if not ok then
   return
end

-- load vs-code like snippets from plugins (e.g. friendly-snippets)
-- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip
require("luasnip.loaders.from_vscode").lazy_load()

-- Helper for <Tab> completion
local has_words_before = function()
   unpack = unpack or table.unpack
   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
   return col ~= 0
      and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
   snippet = {
      expand = function(args)
         luasnip.lsp_expand(args.body)
      end,
   },
   mapping = cmp.mapping.preset.insert({
      ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
      ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
      ["<C-e>"] = cmp.mapping.abort(), -- close completion window
      ["<CR>"] = cmp.mapping.confirm({ select = false }),
      ["<Tab>"] = cmp.mapping(function(fallback)
         if cmp.visible() then
            -- cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            cmp.select_next_item()
         -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
         -- they way you will only jump inside the snippet region
         elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
         elseif has_words_before() then
            cmp.complete()
         else
            fallback()
         end
      end, { "i", "s" }),

      ["<S-Tab>"] = cmp.mapping(function(fallback)
         if cmp.visible() then
            cmp.select_prev_item()
         elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
         else
            fallback()
         end
      end, { "i", "s" }),
   }),
   -- sources for autocompletion
   sources = cmp.config.sources({
      { name = "nvim_lsp" }, -- lsp
      { name = "luasnip" }, -- snippets
      { name = "buffer" }, -- text within current buffer
      { name = "path" }, -- file system paths
   }),
   -- configure lspkind for vs-code like icons
   formatting = {
      format = lspkind.cmp_format({
         maxwidth = 50,
         -- ellipsis_char = "...",
         ellipsis_char = "…",
      }),
   },
})
