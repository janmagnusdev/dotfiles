--
-- User interface plugins that only add visuals
--
return {
  -- Icons used by other plugins (lualine, tree, ...,
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- -- Better `vim.notify()`
  -- {
  --   "rcarriga/nvim-notify",
  --   event = "VeryLazy",
  --   keys = {
  --     {
  --       "<leader>un",
  --       function()
  --         require("notify").dismiss({ silent = true, pending = true })
  --       end,
  --       desc = "Delete all Notifications",
  --     },
  --   },
  --   opts = {
  --     timeout = 3000,
  --   },
  -- },

  -- -- Use notify for LSP status messages
  -- {
  --   "mrded/nvim-lsp-notify",
  --   lazy = true,
  --   dependencies = { "rcarriga/nvim-notify" },
  --   init = function()
  --     require("lsp-notify").setup({
  --       notify = require("notify"),
  --     })
  --   end,
  -- },

  -- Better vim.ui
  {
    "stevearc/dressing.nvim",
    lazy = true,
    opts = {
      input = {
        win_options = {
          winblend = 0,
        },
      },
    },
    init = function()
      vim.ui.select = function(...) ---@diagnostic disable-line
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      vim.ui.input = function(...) ---@diagnostic disable-line
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  },

  -- Noicer UI
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      -- "rcarriga/nvim-notify",
    },
    opts = {
      cmdline = {
        format = {
          search_down = { icon = " " },
          search_up = { icon = " " },
        },
      },
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        -- -- Disable lsp-progress in bottom-right corner, use nvim-lsp-notify instead
        -- progress = { enabled = false },
      },
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        -- inc_rename = false, -- enables an input dialog for inc-rename.nvim
        -- lsp_doc_border = false, -- add a border to hover docs and signature help
      },
      messages = {
        view_search = false, -- disable virtualtext overlays for search count msg.
      },
      -- routes = {
      --   { -- Don't show "<file> written"
      --     filter = { event = "msg_show", kind = "", find = "written" },
      --     opts = { skip = true },
      --   },
      -- },
    },
    -- stylua: ignore
    keys = {
      { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
      { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll forward", mode = {"i", "n", "s"} },
      { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll backward", mode = {"i", "n", "s"}},
      { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
      { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
      { "<leader>sne", function() require("noice").cmd("errors") end, desc = "Noice Errors" },
    },
  },

  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      -- Only call once, venv does not change
      vim.g.venvname = require("stefan.util").get_venvname()

      local icons = require("stefan.icons")
      local get_color = require("lualine.utils.utils").extract_highlight_colors

      -- Not sure yet whether I like the rounded status bar or not:
      local rounded = true
      local component_separators, section_separators, outer_separators
      if rounded then
        component_separators = { left = "|", right = "|" }
        section_separators = { left = "", right = "" }
        outer_separators = { left = "", right = "" }
      else
        component_separators = { left = "|", right = "|" }
        section_separators = { left = "", right = "" }
        outer_separators = nil
      end

      -- Return indentation info:
      -- "s:3" means "3 spaces", "t:4" means tabs with 4 spaces width
      ---@return string
      local function indentinfo()
        local et = vim.opt.expandtab:get()
        local ts = vim.opt.tabstop:get()
        local text = (et and "s" or "t") .. ":" .. ts
        return text
      end

      -- Return the current time
      -- That whole function is obsolete if I stopped using fancy separators
      ---@return table
      local function time()
        local component = { "datetime", style = "%H:%M", icon = "" }
        if rounded then
          component.separator = outer_separators
          component.padding = 0
        end
        return component
      end

      -- Fix extensions by adjusting separators and adding missing components
      -- that I added to my "normal" statusline.
      ---@param name string
      ---@return table
      local function fix_extension(name)
        local ext = require("lualine.extensions." .. name)
        local s = ext.sections

        if rounded then
          if type(s.lualine_a[1]) ~= "table" then
            s.lualine_a = { { s.lualine_a[1] } }
          end
          ext.sections.lualine_a[1].separator = outer_separators
        end

        if s.lualine_z ~= nil then
          if s.lualine_y == nil then
            s.lualine_y = {}
          end
          for _, i in pairs(s.lualine_z) do
            table.insert(s.lualine_y, i)
          end
        end
        s.lualine_z = { time() }
        return ext
      end

      return {
        options = {
          theme = require("stefan.stylo").lualine_theme,
          globalstatus = true,
          component_separators = component_separators,
          section_separators = section_separators,
        },
        sections = {
          lualine_a = { { "mode", separator = outer_separators } },
          lualine_b = {
            {
              "filename",
              path = 1,
              icon = require("stefan.util").strip(icons.kinds.File),
              symbols = icons.file,
            },
            {
              "diff",
              diff_color = {
                added = { fg = get_color("diffAdded", "fg") },
                modified = { fg = get_color("diffChanged", "fg") },
                removed = { fg = get_color("diffRemoved", "fg") },
              },
              symbols = icons.git_lines,
            },
            "diagnostics",
          },
          lualine_c = {
            "branch",
            { "g:venvname", icon = "" },
          },
          lualine_x = {
            -- {
            --   require("noice").api.status.message.get,
            --   cond = function()
            --     return package.loaded["noice"] and require("noice").api.status.message.has()
            --   end,
            --   icon = "",
            -- },
            { "searchcount", icon = "" },
            {
              require("noice").api.status.mode.get,
              cond = function()
                return package.loaded["noice"] and require("noice").api.status.mode.has()
              end,
              icon = "",
            },
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
            },
          },
          lualine_y = {
            { "filetype", colored = false },
            "encoding",
            "fileformat",
            indentinfo,
            "progress",
            "location",
          },
          lualine_z = { time() },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = { { "filename", path = 1, symbols = icons.file } },
          lualine_c = {},
          lualine_x = {},
          lualine_y = { "progress", "location" },
          lualine_z = {},
        },
        extensions = {
          fix_extension("neo-tree"),
          fix_extension("quickfix"),
        },
      }
    end,
  },

  -- Indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      -- char = "▏",
      -- char = "│",
      -- filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
      -- show_trailing_blankline_indent = false,
      show_current_context = true,
    },
  },

  -- Display colors in-line
  {
    "RRethy/vim-hexokinase",
    build = "make hexokinase",
    event = "VeryLazy",
    init = function()
      vim.g.Hexokinase_highlighters = { "virtual" }
      vim.g.Hexokinase_optInPatterns = "full_hex,rgb,rgba,hsl,hsla"
      vim.g.Hexokinase_ftOptInPatterns = {
        css = "full_hex,rgb,rgba,hsl,hsla,colour_names",
      }
    end,
  },
}
