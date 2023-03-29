--
-- LSP Configuration & Plugins
--
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { "j-hui/fidget.nvim", opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      "folke/neodev.nvim",
    },
    init = function(plugin)
      local ok, lspconfig = pcall(require, "lspconfig")
      if not ok then
        return
      end

      ----- mason setup
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
        PATH = "append", -- Give precedence to (Python) tools installed in the current venv
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
      -----
      local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      if not ok then
        return
      end

      -- nvim-cmp suppohts additional completion capabilities, so broadcast that to servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

      -- Change the Diagnostic symbols in the sign column (gutter)
      local signs = require("stefan.icons").diagnostics
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
    end,
  },

  -- LSP-like interface for formatters & linters
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = {
      -- Automatically install linters/formatters for null-ls
      "williamboman/mason.nvim",
      "jay-babu/mason-null-ls.nvim",
    },
    opts = function(plugin)
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
      return {
        -- setup formatters & linters
        -- diagnostics_format = "[#{c}] #{m} (#{s})",
        sources = {
          -- ...with({ prefer_local = ".venv/bin" }) arg to use executable from local .venv/bin
          --
          code_actions.gitsigns,
          formatting.trim_newlines,
          formatting.trim_whitespace,
          formatting.stylua,
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
      }
    end,
  },

  -- Enhanced LSP UIs
  {
    "glepnir/lspsaga.nvim",
    opts = {
      -- keybinds for navigation in lspsaga window
      scroll_preview = { scroll_down = "<C-f>", scroll_up = "<C-b>" },
      code_action = {
        extend_gitsigns = false, -- explicitly add this in null-ls.lua
      },
      definition = {
        edit = "<CR>",
      },
      lightbulb = {
        enable = false,
      },
      outline = {
        keys = {
          expand_collapse = "<space>",
        },
      },
      ui = {
        border = "rounded",
      },
    },
    init = function()
      -- Many examples/guides wrap this in an "on_attach" function for an actual LSP
      -- server.  We can do this here, because
      -- - we currently don't map to "vim.lsp...."
      -- - we use null-ls with Gitsigns and formatters for *all* filetypes
      -- These bindings also make more sense in this file.
      local opts = { noremap = true, silent = true }
      vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<cr>", opts) -- show documentation for what is under cursor
      vim.keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<cr>", opts) -- see definition and make edits in window
      vim.keymap.set("n", "gD", "<cmd>Lspsaga goto_definition<cr>", opts) -- see definition and make edits in window
      vim.keymap.set("n", "<leader>ld", "<Cmd>lua vim.lsp.buf.declaration()<cr>", opts) -- got to declaration
      vim.keymap.set("n", "<leader>li", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts) -- go to implementation
      vim.keymap.set("n", "<leader>lf", "<cmd>Lspsaga lsp_finder<cr>", opts) -- show definition, references
      vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<cr>", opts) -- see available code actions
      vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<cr>", opts) -- smart rename
      vim.keymap.set("n", "<leader>df", "<cmd>Lspsaga show_buf_diagnostics<cr>", opts) -- show diagnostics for cursor
      vim.keymap.set("n", "<leader>dl", "<cmd>Lspsaga show_line_diagnostics<cr>", opts) -- show  diagnostics for line
      vim.keymap.set("n", "<leader>dc", "<cmd>Lspsaga show_cursor_diagnostics<cr>", opts) -- show diagnostics for cursor
      vim.keymap.set("n", "<leader>dp", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opts) -- jump to previous diagnostic in buffer
      vim.keymap.set("n", "<leader>dn", "<cmd>Lspsaga diagnostic_jump_next<cr>", opts) -- jump to next diagnostic in buffer
      vim.keymap.set("n", "<leader>o", "<cmd>Lspsaga outline<cr>", opts) -- see outline on right hand side
      vim.keymap.set("n", "<leader>fm", function()
        vim.lsp.buf.format({
          timeout_ms = 5000, -- Some formatters taker longer than 1000ms
          filter = function(lsp_client)
            --  only use null-ls for formatting instead of lsp server
            return lsp_client.name == "null-ls"
          end,
        })
      end, opts)
    end,
  },

  -- VS-code like icons for autocompletion
  -- TODO: Manually add icons? https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance
  { "onsails/lspkind.nvim" },
}
