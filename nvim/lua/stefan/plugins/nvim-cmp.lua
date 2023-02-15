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
require("luasnip.loaders.from_vscode").lazy_load()

vim.opt.completeopt = "menu,menuone,noselect"

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
         -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
         if cmp.visible() then
            local entry = cmp.get_selected_entry()
            if not entry then
               cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            else
               cmp.confirm()
            end
         else
            fallback()
         end
         -- end, {"i","s","c",}),
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
