local M = {}

-- Generated color values {{{
local colors = {
  dark = {
    gui = {
      base00 = "#18191A",
      base01 = "#222528",
      base02 = "#353B41",
      base03 = "#3D4751",
      base04 = "#68798B",
      base05 = "#96AEC7",
      base06 = "#C8DAEC",
      base07 = "#E4ECF5",
      red = "#CD7B82",
      orange = "#C88F70",
      yellow = "#B29D5A",
      green = "#6EAE8C",
      cyan = "#63ACB0",
      blue = "#70A3D6",
      purple = "#A191D9",
      magenta = "#BE85CB",
      bright_red = "#F34A67",
      bright_orange = "#EE7928",
      bright_yellow = "#CDA712",
      bright_green = "#2DA974",
      bright_cyan = "#1DAAB1",
      bright_blue = "#3395ED",
      bright_purple = "#9369F2",
      bright_magenta = "#BA59D0",
      dim_red = "#80142C",
      dim_orange = "#793807",
      dim_yellow = "#604D05",
      dim_green = "#0A5638",
      dim_cyan = "#04585C",
      dim_blue = "#054C85",
      dim_purple = "#4B288C",
      dim_magenta = "#601E6E",
    },
    cterm = {
      base00 = "234",
      base01 = "0",
      base02 = "8",
      base03 = "238",
      base04 = "243",
      base05 = "110",
      base06 = "7",
      base07 = "15",
      red = "1",
      orange = "137",
      yellow = "3",
      green = "2",
      cyan = "6",
      blue = "4",
      purple = "5",
      magenta = "140",
      bright_red = "9",
      bright_orange = "166",
      bright_yellow = "11",
      bright_green = "10",
      bright_cyan = "14",
      bright_blue = "12",
      bright_purple = "13",
      bright_magenta = "134",
      dim_red = "52",
      dim_orange = "52",
      dim_yellow = "58",
      dim_green = "23",
      dim_cyan = "23",
      dim_blue = "24",
      dim_purple = "54",
      dim_magenta = "53",
    },
  },
  light = {
    gui = {
      base00 = "#FBF6ED",
      base01 = "#ECE8E0",
      base02 = "#D4D4D4",
      base03 = "#C7C7C7",
      base04 = "#919191",
      base05 = "#5E5E5E",
      base06 = "#3C3C3C",
      base07 = "#191919",
      red = "#A43C31",
      orange = "#BA5C00",
      yellow = "#C78800",
      green = "#52751D",
      cyan = "#268389",
      blue = "#2F5F98",
      purple = "#874292",
      magenta = "#A63352",
      bright_red = "#CA4134",
      bright_orange = "#E27415",
      bright_yellow = "#EAA000",
      bright_green = "#618F00",
      bright_cyan = "#0D8D94",
      bright_blue = "#2F78CA",
      bright_purple = "#A54BB4",
      bright_magenta = "#C44164",
      dim_red = "#ECCCC7",
      dim_orange = "#ECCEBC",
      dim_yellow = "#E8D1B1",
      dim_green = "#C8DDB1",
      dim_cyan = "#AEDFE2",
      dim_blue = "#C5D6ED",
      dim_purple = "#E3CCE6",
      dim_magenta = "#EDCBD0",
    },
    cterm = {
      base00 = "231",
      base01 = "0",
      base02 = "8",
      base03 = "251",
      base04 = "246",
      base05 = "59",
      base06 = "7",
      base07 = "15",
      red = "1",
      orange = "130",
      yellow = "3",
      green = "2",
      cyan = "6",
      blue = "4",
      purple = "5",
      magenta = "125",
      bright_red = "9",
      bright_orange = "166",
      bright_yellow = "11",
      bright_green = "10",
      bright_cyan = "14",
      bright_blue = "12",
      bright_purple = "13",
      bright_magenta = "168",
      dim_red = "224",
      dim_orange = "224",
      dim_yellow = "223",
      dim_green = "151",
      dim_cyan = "152",
      dim_blue = "189",
      dim_purple = "225",
      dim_magenta = "224",
    },
  },
}

-- Set background and normal text color
local back = "base00"
local text = "base05"

-- Set neovim embedded terminal colors
local term_colors = {
  term0 = "base01",
  term1 = "red",
  term2 = "green",
  term3 = "yellow",
  term4 = "blue",
  term5 = "purple",
  term6 = "cyan",
  term7 = "base06",
  term8 = "base02",
  term9 = "bright_red",
  term10 = "bright_green",
  term11 = "bright_yellow",
  term12 = "bright_blue",
  term13 = "bright_purple",
  term14 = "bright_cyan",
  term15 = "base07",
}
-- }}} Generated color values

--- Return a table with the proper for the current mode (dark|light)
--- and GUI capabilities (vim.o.termguicolors)
function M.get_colors()
  local mode = vim.o.background
  local gui = vim.o.termguicolors and "gui" or "cterm"
  return colors[mode][gui]
end

--- Load the actual colorscheme and apply highlights
function M.load()
  local c = M.get_colors()

  vim.api.nvim_command("hi clear")
  if vim.fn.exists("syntax_on") then
    vim.api.nvim_command("syntax reset")
  end

  vim.g.colors_name = "stylo"

  local function hi(group, properties)
    vim.api.nvim_set_hl(0, group, properties)
  end

  local c_back, c_text
  if vim.fn.has("gui_running") == 1 then
    c_back = c[back]
    c_text = c[text]
  else
    c_back = nil
    c_text = nil
  end
  c_back = c[back]
  c_text = c[text]

  -- Set neovim embedded terminal colors
  hi("TermColor0", { fg = c[term_colors.term0] })
  hi("TermColor1", { fg = c[term_colors.term1] })
  hi("TermColor2", { fg = c[term_colors.term2] })
  hi("TermColor3", { fg = c[term_colors.term3] })
  hi("TermColor4", { fg = c[term_colors.term4] })
  hi("TermColor5", { fg = c[term_colors.term5] })
  hi("TermColor6", { fg = c[term_colors.term6] })
  hi("TermColor7", { fg = c[term_colors.term7] })
  hi("TermColor8", { fg = c[term_colors.term8] })
  hi("TermColor9", { fg = c[term_colors.term9] })
  hi("TermColor10", { fg = c[term_colors.term10] })
  hi("TermColor11", { fg = c[term_colors.term11] })
  hi("TermColor12", { fg = c[term_colors.term12] })
  hi("TermColor13", { fg = c[term_colors.term13] })
  hi("TermColor14", { fg = c[term_colors.term14] })
  hi("TermColor15", { fg = c[term_colors.term15] })

  -- General interface

  hi("Normal", { fg = c_text, bg = c_back })

  hi("FloatBorder", { fg = c.base04, bg = c.base00 })
  hi("NormalFloat", { fg = c.base05, bg = c.base00 })
  hi("Pmenu", { fg = c.base05, bg = c.base01 })
  hi("PmenuSbar", { fg = c.base05, bg = c.base02 })
  hi("PmenuThumb", { fg = c.base05, bg = c.base05 })
  hi("PmenuSel", { fg = c.base01, bg = c.green })
  hi("WildMenu", { fg = c.base01, bg = c.green })

  hi("Cursor", { fg = c.base00, bg = c.base03 })
  hi("CursorLineNr", { fg = c.red, bg = c.base01 })
  hi("CursorLine", { bg = c.base01 })
  hi("CursorColumn", { bg = c.base01 })
  hi("ColorColumn", { bg = c.base01 })

  hi("FoldColumn", { fg = c.base03 })
  hi("LineNr", { fg = c.base03 })
  hi("SignColumn", { fg = c.base03 })

  hi("VertSplit", { fg = c.base02 })
  hi("StatusLine", { fg = c.base06, bg = c.base02 })
  hi("StatusLineNC", { fg = c.base05, bg = c.base02 })
  hi("StatusLine", { fg = c.base06, bg = c_back })
  hi("StatusLineNC", { fg = c.base05, bg = c_back })
  hi("TabLine", { fg = c.base05, bg = c.base03 })
  hi("TabLineFill", { fg = c.base05, bg = c.base02 })
  hi("TabLineSel", { fg = c.base01, bg = c.blue })

  hi("Visual", { fg = c.base07, bg = c.base02 })
  hi("Folded", { fg = c.orange, bg = c.base01 })

  hi("MatchParen", { fg = c.bright_red, underline = true })
  hi("Directory", { fg = c.blue })
  hi("IncSearch", { fg = c.bright_orange, reverse = true })
  hi("Search", { fg = c.bright_yellow, reverse = true })

  hi("NonText", { fg = c.base02, bold = true })
  hi("SpecialKey", { fg = c.base02, bold = true })
  hi("Title", { fg = c.purple, bold = true })
  hi("ErrorMsg", { fg = c.bright_red, bold = true })
  hi("WarningMsg", { fg = c.yellow, bold = true })
  hi("Question", { fg = c.purple, bold = true })
  hi("MoreMsg", { fg = c.blue })
  hi("ModeMsg", { fg = c.green })

  hi("DiffFile", { fg = c.purple, bold = true })
  hi("DiffText", { fg = c.blue, reverse = true })
  hi("DiffAdd", { fg = c.green, reverse = true })
  hi("DiffDelete", { fg = c.red, reverse = true })
  hi("DiffChange", { fg = c.yellow, reverse = true })

  hi("Conceal", { fg = c.blue })
  hi("SpellBad", { sp = c.bright_red, undercurl = true })
  hi("SpellCap", { sp = c.blue, undercurl = true })
  hi("SpellRare", { sp = c.magenta, undercurl = true })
  hi("SpellLocal", { sp = c.cyan, undercurl = true })

  -- Highlighting
  hi("Comment", { fg = c.magenta, italic = true })

  hi("Constant", { fg = c.yellow })
  hi("String", { fg = c.green })
  hi("Character", { link = "Constant" })
  hi("Number", { link = "Constant" })
  hi("Boolean", { link = "Constant" })
  hi("Float", { link = "Constant" })

  hi("Identifier", { fg = c.blue })
  hi("Function", { fg = c.blue })

  hi("Statement", { fg = c.purple })
  hi("Conditional", { link = "Statement" })
  hi("Repeat", { link = "Statement" })
  hi("Label", { link = "Statement" })
  hi("Operator", { link = "Statement" })
  hi("Keyword", { link = "Statement" })
  hi("Exception", { link = "Statement" })

  hi("PreProc", { fg = c.magenta })
  hi("Include", { fg = c.magenta })
  hi("Define", { link = "Include" })
  hi("Macro", { link = "Include" })
  hi("PreCondit", { link = "Include" })

  hi("Type", { fg = c.magenta })
  hi("StorageClass", { link = "Type" })
  hi("Structure", { link = "Type" })
  hi("Typedef", { link = "Type" })

  hi("Special", { fg = c.cyan })
  hi("SpecialChar", { link = "Special" })
  hi("Tag", { fg = c.green })
  hi("Delimiter", { fg = c.magenta })
  hi("SpecialComment", { link = "Special" })
  hi("Debug", { link = "Special" })

  hi("Underlined", { underline = true })
  hi("Ignore", { fg = c.base02 })
  hi("Error", { fg = c.bright_red, bold = true })
  hi("Todo", { fg = c.magenta, bold = true })
  hi("Whitespace", { fg = c.bright_red })

  -- HTML
  hi("htmlTag", { fg = c_text })
  hi("htmlEndTag", { fg = c_text })

  -- Markdown
  hi("markdownCode", { fg = c.purple })

  -- Patch
  hi("diffLine", { fg = c.cyan, bold = true })
  hi("diffAdded", { fg = c.green })
  hi("diffChanged", { fg = c.yellow })
  hi("diffRemoved", { fg = c.red })

  -- Python
  hi("pythonClassVar", { fg = c.cyan })
  hi("pythonExClass", { fg = c.red })

  -- YAML
  hi("yamlKey", { fg = c.blue })

  -- Indent Blankline (indent guides)
  hi("IndentBlanklineChar", { fg = c.base01, nocombine = true })
  hi("IndentBlanklineContextChar", { fg = c.base03, nocombine = true })
  hi("IndentBlanklineContextStart", { sp = c.base03, underline = true })
  hi("IndentBlanklineContextSpaceChar", { nocombine = true })

  -- Plugins
  -------------

  -- Notify
  hi("NotifyBackground", { fg = c_text, bg = c_back })
  hi("NotifyTRACEBorder", { fg = c.purple })
  hi("NotifyTRACEIcon", { fg = c.bright_purple })
  hi("NotifyTRACETitle", { fg = c.bright_purple })
  hi("NotifyDEBUGBorder", { fg = c.blue })
  hi("NotifyDEBUGIcon", { fg = c.bright_blue })
  hi("NotifyDEBUGTitle", { fg = c.bright_blue })
  hi("NotifyINFOBorder", { fg = c.green })
  hi("NotifyINFOIcon", { fg = c.bright_green })
  hi("NotifyINFOTitle", { fg = c.bright_green })
  hi("NotifyWARNBorder", { fg = c.yellow })
  hi("NotifyWARNIcon", { fg = c.bright_yellow })
  hi("NotifyWARNTitle", { fg = c.bright_yellow })
  hi("NotifyERRORBorder", { fg = c.red })
  hi("NotifyERRORIcon", { fg = c.bright_red })
  hi("NotifyERRORTitle", { fg = c.bright_red })

  -- LSP
  hi("DiagnosticError", { fg = c.bright_red })
  hi("DiagnosticWarn", { fg = c.bright_yellow })
  hi("DiagnosticInfo", { fg = c.bright_blue })
  hi("DiagnosticHint", { fg = c.bright_purple })

  -- Lspsaga
  hi("SagaNormal", { link = "NormalFloat"})
  hi("SagaBorder", { link = "FloatBorder" })
  hi("SagaWinbarSep", { fg = c.bright_blue })

  -- Telescope
  hi("TelescopeNormal", { link = "NormalFloat" })
  hi("TelescopeBorder", { link = "FloatBorder" })

  -- Gitsigns
  hi("GitSignsAdd", { fg = c.dim_green })
  hi("GitSignsChange", { fg = c.dim_yellow })
  hi("GitSignsDelete", { fg = c.dim_red })

  -- Neotree
  hi("NeoTreeDimText", { fg = c.base04 }) -- dim text, expanders, indent markers
  hi("NeoTreeMessage", { fg = c.base04, italic = true }) -- num. of hidden files
  hi("NeoTreeDotfile", { fg = c.base04 }) -- names of hidden files
  hi("NeoTreeModified", { link = "diffChanged" }) -- file as unsaved changes
  hi("NeoTreeGitAdded", { link = "diffAdded" })
  hi("NeoTreeGitModified", { link = "diffChanged" })
  hi("NeoTreeGitDeleted", { link = "diffRemoved" })
  hi("NeoTreeGitUntracked", { fg = c.purple })
  hi("NeoTreeGitIgnored", { link = "NeoTreeDotfile" })
  hi("NeoTreeGitUnstaged", { link = "diffRemoved" })
  hi("NeoTreeGitStaged", { link = "diffAdded" })
  hi("NeoTreeGitConflict", { fg = c.bright_red, bold = true })

  -- Lualine
  -- Reload lualine to update its theme.
  -- It automatically generates some highlight groups that are not affected
  -- by the theme defined in "lualine_theme()".
  -- Wrap it with "pcall" because this will only work once Lazy has loaded
  -- the plugin
  pcall(function()
    local ui_plugins = require("stefan.plugins.ui")
    for _, plugin in pairs(ui_plugins) do
      if plugin[1] == "nvim-lualine/lualine.nvim" then
        require("lualine").setup(plugin.opts())
        return
      end
    end
  end)
end

--- Return the lualine theme
function M.lualine_theme()
  local c = M.get_colors()
  local style_b = { fg = c.base05, bg = c.base03 }
  local style_c = { fg = c.base04, bg = c.base02 }
  return {
    normal = {
      a = { fg = c.blue, bg = c.dim_blue },
      b = style_b,
      c = style_c,
    },
    insert = {
      a = { fg = c.green, bg = c.dim_green },
      b = style_b,
      c = style_c,
    },
    visual = {
      a = { fg = c.magenta, bg = c.dim_magenta },
      b = style_b,
      c = style_c,
    },
    replace = {
      a = { fg = c.orange, bg = c.dim_orange },
      b = style_b,
      c = style_c,
    },
    command = {
      a = { fg = c.yellow, bg = c.dim_yellow },
      b = style_b,
      c = style_c,
    },
    terminal = {
      a = { fg = c.cyan, bg = c.dim_cyan },
      b = style_b,
      c = style_c,
    },
    inactive = {
      a = {},
      b = style_b,
      c = style_c,
    },
  }
end

return M
