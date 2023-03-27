--
-- Editing plugins add text manipulation functionality (autocompletion, surrounds, ...)
--
return {
  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- LSP completion
      "hrsh7th/cmp-buffer", -- Completion for text in buffer
      "hrsh7th/cmp-path", -- Completion for file system paths
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      -- "rafamadriz/friendly-snippets", -- useful snippets
    },
    opts = function(plugin)
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
      -- require("luasnip.loaders.from_vscode").lazy_load()
      -- I don't currently use friendly-snippets, so this should suffice:
      luasnip.config.setup()

      -- Helper for <Tab> completion
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      return {
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
          -- ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          -- ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
          ["<C-e>"] = cmp.mapping.abort(), -- close completion window
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace, -- https://github.com/hrsh7th/nvim-cmp/issues/664#issuecomment-999993360
            select = false, -- Don't auto-select 1st item if nothing is selected
          }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
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
      }
    end,
  },

  -- Editing plug-ins
  { "tpope/vim-repeat" }, -- Enable repeating with "." for vim-surround
  { "tpope/vim-surround" }, -- Add, delete, change surroundings
  { "flwyd/vim-conjoin" },
  { "numToStr/Comment.nvim", opts = {} }, -- Comment lines/blocks with "gc"
  -- use "mg979/vim-visual-multi"
  -- {"inkarkat/vim-ReplaceWithRegister"}, -- replace with register contents using motion (gr + motion
  {
    "windwp/nvim-autopairs",
    opts = {
      check_ts = true, -- enable treesitter
      ts_config = {
        lua = { "string" }, -- don't add pairs in lua string treesitter nodes
        javascript = { "template_string" }, -- don't add pairs in javscript template_string treesitter nodes
        java = false, -- don't check treesitter on java
      },
    },
    init = function()
      local cmp_autopairs_ok, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
      if not cmp_autopairs_ok then
        return
      end

      -- make autopairs and completion work together
      local cmp_ok, cmp = pcall(require, "cmp")
      if not cmp_ok then
        return
      end
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  }, -- Autoclose parens, brackets, quotes, etc...
  { "windwp/nvim-ts-autotag", dependencies = { "nvim-treesitter" } }, -- Autoclose tags
}
