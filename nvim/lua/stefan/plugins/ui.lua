--
-- User interface plugins that only add visuals
--
return {
  -- Icons used by other plugins (lualine, tree, ...,
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(plugin)
      --- Return name of current virtual env
      local function get_venvname()
        for _, v in pairs({ vim.env.VIRTUAL_ENV, vim.env.CONDA_PREFIX }) do
          if vim.fn.isdirectory(v) == 1 then
            return vim.fn.fnamemodify(v, ":t")
          end
        end
        return ""
      end

      -- Return indentation info:
      -- "s:3" means "3 spaces", "t:4" means tabs with 4 spaces width
      local indentinfo = function()
        local et = vim.opt.expandtab:get()
        local ts = vim.opt.tabstop:get()
        local text = (et and "s" or "t") .. ":" .. ts
        return text
      end
      vim.g.venvname = get_venvname() -- Only call once, venv does not change

      local get_color = require("lualine.utils.utils").extract_highlight_colors

      return {
        options = {
          -- theme = require("stefan.stylo").lualine_theme,
          theme = "stylo",
          globalstatus = true,
          component_separators = { left = "|", right = "|" },
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = {
            "g:venvname",
            "branch",
            {
              "diff",
              -- colored = false,
              diff_color = {
                added = { fg = get_color("diffAdded", "fg") },
                modified = { fg = get_color("diffChanged", "fg") },
                removed = { fg = get_color("diffRemoved", "fg") },
              },
              symbols = { added = " ", modified = " ", removed = " " },
            },
            "diagnostics",
            {
              "filename",
              path = 1,
              -- shorting_target = 40, -- Shortens path to leave 40 spaces in the window
              symbols = {
                -- modified = "",
                modified = "",
                -- modified = "  ",
                readonly = "",
              },
            },
            -- -- stylua: ignore
            -- {
            --   function() return require("nvim-navic").get_location() end,
            --   cond = function() return package.loaded["nvim-navic"] and require("nvim-navic").is_available() end,
            -- },
          },
          lualine_c = {},
          lualine_x = {
            -- -- stylua: ignore
            -- {
            --   function() return require("noice").api.status.command.get() end,
            --   cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
            --   color = get_color("Statement", "fg")
            -- },
            -- -- stylua: ignore
            -- {
            --   function() return require("noice").api.status.mode.get() end,
            --   cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
            --   color = get_color("Constant", "fg") ,
            -- },
            -- { require("lazy.status").updates, cond = require("lazy.status").has_updates, color = fg("Special") },
          },
          lualine_y = { "filetype", "encoding", "fileformat", indentinfo, "progress", "location" },
          -- lualine_y = {
          --   { "progress", separator = " ", padding = { left = 1, right = 0 } },
          --   { "location", padding = { left = 0, right = 1 } },
          -- },
          lualine_z = {
            -- function()
            --   return " " .. os.date("%R")
            -- end,
          },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {
            {
              "filename",
              path = 1,
              -- shorting_target = 40, -- Shortens path to leave 40 spaces in the window
              symbols = {
                modified = "",
                readonly = "",
              },
            },
          },
          lualine_c = {},
          lualine_x = {},
          lualine_y = { "progress", "location" },
          lualine_z = {},
        },
        -- extensions = { "neo-tree" },
      }
    end,
  },

  -- indent guides
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
    init = function()
      vim.g.Hexokinase_highlighters = { "virtual" }
      vim.g.Hexokinase_optInPatterns = "full_hex,rgb,rgba,hsl,hsla"
      vim.g.Hexokinase_ftOptInPatterns = {
        css = "full_hex,rgb,rgba,hsl,hsla,colour_names",
      }
    end,
  },
}
