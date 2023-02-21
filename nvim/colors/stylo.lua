-- Name:   Stylo
-- Author:  Stefan Scherfke
-- URL: https://gitlab.com/sscherfke/dotfiles/blob/master/_vim/colors/
--
-- Switch between light and dark mode by setting "background=dark" or
-- "background=light".
--
vim.api.nvim_command("hi clear")
if vim.fn.exists("syntax_on") then
   vim.api.nvim_command("syntax reset")
end

vim.g.colors_name = "stylo"

local has_gui = vim.o.termguicolors
local vmode = (has_gui and "gui" or "cterm")

-- Helpers variables for NONE, bold, ...
local none = "NONE"
local bold = "bold"
local italic = "italic"
local reverse = "reverse"
local standout = "standout"
local undercurl = "undercurl"
local underline = "underline"

local function hi(group, properties)
   vim.api.nvim_set_hl(0, group, properties)
end

-- Generated color values {{{
local base00, base01, base02, base03, base04, base05, base06, base07, base08
local red, orange, yellow, green, cyan, blue, purple, magenta
local bright_red, bright_orange, bright_yellow, bright_green, bright_cyan, bright_blue, bright_purple, bright_magenta
local dim_red, dim_orange, dim_yellow, dim_green, dim_cyan, dim_blue, dim_purple, dim_magenta

if vim.o.background == "dark" then
   if has_gui then
      base00 = "#18191A"
      base01 = "#222528"
      base02 = "#353B41"
      base03 = "#3D4751"
      base04 = "#516070"
      base05 = "#96AEC7"
      base06 = "#C8DAEC"
      base07 = "#E4ECF5"
      red = "#CD7B82"
      orange = "#C88F70"
      yellow = "#B29D5A"
      green = "#6EAE8C"
      cyan = "#63ACB0"
      blue = "#70A3D6"
      purple = "#A191D9"
      magenta = "#BE85CB"
      bright_red = "#F34A67"
      bright_orange = "#EE7928"
      bright_yellow = "#CDA712"
      bright_green = "#2DA974"
      bright_cyan = "#1DAAB1"
      bright_blue = "#3395ED"
      bright_purple = "#9369F2"
      bright_magenta = "#BA59D0"
      dim_red = "#80142C"
      dim_orange = "#793807"
      dim_yellow = "#604D05"
      dim_green = "#0A5638"
      dim_cyan = "#04585C"
      dim_blue = "#054C85"
      dim_purple = "#4B288C"
      dim_magenta = "#601E6E"
   else
      base00 = "234"
      base01 = "0"
      base02 = "8"
      base03 = "238"
      base04 = "59"
      base05 = "110"
      base06 = "7"
      base07 = "15"
      red = "1"
      orange = "137"
      yellow = "3"
      green = "2"
      cyan = "6"
      blue = "4"
      purple = "5"
      magenta = "140"
      bright_red = "9"
      bright_orange = "166"
      bright_yellow = "11"
      bright_green = "10"
      bright_cyan = "14"
      bright_blue = "12"
      bright_purple = "13"
      bright_magenta = "134"
      dim_red = "52"
      dim_orange = "52"
      dim_yellow = "58"
      dim_green = "23"
      dim_cyan = "23"
      dim_blue = "24"
      dim_purple = "54"
      dim_magenta = "53"
   end
else
   if has_gui then
      base00 = "#FBF6ED"
      base01 = "#ECE8E0"
      base02 = "#D4D4D4"
      base03 = "#BEBEBE"
      base04 = "#919191"
      base05 = "#5E5E5E"
      base06 = "#3C3C3C"
      base07 = "#191919"
      red = "#A43C31"
      orange = "#BA5C00"
      yellow = "#C78800"
      green = "#52751D"
      cyan = "#268389"
      blue = "#2F5F98"
      purple = "#874292"
      magenta = "#A63352"
      bright_red = "#CA4134"
      bright_orange = "#E27415"
      bright_yellow = "#EAA000"
      bright_green = "#618F00"
      bright_cyan = "#0D8D94"
      bright_blue = "#2F78CA"
      bright_purple = "#A54BB4"
      bright_magenta = "#C44164"
      dim_red = "#ECCCC7"
      dim_orange = "#ECCEBC"
      dim_yellow = "#E8D1B1"
      dim_green = "#C8DDB1"
      dim_cyan = "#AEDFE2"
      dim_blue = "#C5D6ED"
      dim_purple = "#E3CCE6"
      dim_magenta = "#EDCBD0"
   else
      base00 = "231"
      base01 = "0"
      base02 = "8"
      base03 = "250"
      base04 = "246"
      base05 = "59"
      base06 = "7"
      base07 = "15"
      red = "1"
      orange = "130"
      yellow = "3"
      green = "2"
      cyan = "6"
      blue = "4"
      purple = "5"
      magenta = "125"
      bright_red = "9"
      bright_orange = "166"
      bright_yellow = "11"
      bright_green = "10"
      bright_cyan = "14"
      bright_blue = "12"
      bright_purple = "13"
      bright_magenta = "168"
      dim_red = "224"
      dim_orange = "224"
      dim_yellow = "223"
      dim_green = "151"
      dim_cyan = "152"
      dim_blue = "189"
      dim_purple = "225"
      dim_magenta = "224"
   end
end

-- Set background and normal text color
local back, text
if vim.fn.has("gui_running") == 1 then
   back = base00
   text = base05
else
   back = none
   text = none
end

-- Set neovim embedded terminal colors
hi("TermColor0", { fg = base01, bg = none })
hi("TermColor1", { fg = red, bg = none })
hi("TermColor2", { fg = green, bg = none })
hi("TermColor3", { fg = yellow, bg = none })
hi("TermColor4", { fg = blue, bg = none })
hi("TermColor5", { fg = purple, bg = none })
hi("TermColor6", { fg = cyan, bg = none })
hi("TermColor7", { fg = base06, bg = none })
hi("TermColor8", { fg = base02, bg = none })
hi("TermColor9", { fg = bright_red, bg = none })
hi("TermColor10", { fg = bright_green, bg = none })
hi("TermColor11", { fg = bright_yellow, bg = none })
hi("TermColor12", { fg = bright_blue, bg = none })
hi("TermColor13", { fg = bright_purple, bg = none })
hi("TermColor14", { fg = bright_cyan, bg = none })
hi("TermColor15", { fg = base07, bg = none })
-- }}} Generated color values

-- General interface

hi("Normal", { fg = text, bg = back })

hi("FloatBorder", { fg = base04, bg = base00 })
hi("Pmenu", { fg = base05, bg = base00 })
hi("PmenuSbar", { fg = base05, bg = base02 })
hi("PmenuThumb", { fg = base05, bg = base05 })
hi("PmenuSel", { fg = base01, bg = green })
hi("WildMenu", { fg = base01, bg = green })

hi("Cursor", { fg = base00, bg = base03 })
hi("CursorLineNr", { fg = red, bg = base01 })
hi("CursorLine", { fg = none, bg = base01 })
hi("CursorColumn", { fg = none, bg = base01 })
hi("ColorColumn", { fg = none, bg = base01 })

hi("FoldColumn", { fg = base03, bg = none })
hi("LineNr", { fg = base03, bg = none })
hi("SignColumn", { fg = base03, bg = none })

hi("VertSplit", { fg = base02, bg = none })
hi("StatusLine", { fg = base06, bg = base02 })
hi("StatusLineNC", { fg = base05, bg = base02 })
hi("TabLine", { fg = base05, bg = base03 })
hi("TabLineFill", { fg = base05, bg = base02 })
hi("TabLineSel", { fg = base01, bg = blue })

hi("Visual", { fg = base07, bg = base02 })
hi("Folded", { fg = orange, bg = base01 })

hi("MatchParen", { fg = bright_red, bg = none, underline = true })
hi("Directory", { fg = blue, bg = none })
hi("IncSearch", { fg = bright_orange, bg = none, reverse = true })
hi("Search", { fg = bright_yellow, bg = none, reverse = true })

hi("NonText", { fg = base02, bg = none, bold = true })
hi("SpecialKey", { fg = base02, bg = none, bold = true })
hi("Title", { fg = purple, bg = none, bold = true })
hi("ErrorMsg", { fg = red, bg = none, reverse = true })
hi("WarningMsg", { fg = yellow, bg = none, bold = true })
hi("Question", { fg = purple, bg = none, bold = true })
hi("MoreMsg", { fg = blue, bg = none })
hi("ModeMsg", { fg = green, bg = none })

hi("DiffFile", { fg = purple, bg = none, bold = true })
hi("DiffText", { fg = blue, bg = none, reverse = true })
hi("DiffAdd", { fg = green, bg = none, reverse = true })
hi("DiffDelete", { fg = red, bg = none, reverse = true })
hi("DiffChange", { fg = yellow, bg = none, reverse = true })

hi("Conceal", { fg = blue, bg = none })
hi("SpellBad", { fg = none, bg = none, sp = bright_red, undercurl = true })
hi("SpellCap", { fg = none, bg = none, sp = blue, undercurl = true })
hi("SpellRare", { fg = none, bg = none, sp = magenta, undercurl = true })
hi("SpellLocal", { fg = none, bg = none, sp = cyan, undercurl = true })

-- Highlighting
hi("Comment", { fg = magenta, bg = none, italic = true })

hi("Constant", { fg = yellow, bg = none })
hi("String", { fg = green, bg = none })
hi("Character", { link = "Constant" })
hi("Number", { link = "Constant" })
hi("Boolean", { link = "Constant" })
hi("Float", { link = "Constant" })

hi("Identifier", { fg = blue, bg = none })
hi("Function", { fg = blue, bg = none })

hi("Statement", { fg = purple, bg = none })
hi("Conditional", { link = "Statement" })
hi("Repeat", { link = "Statement" })
hi("Label", { link = "Statement" })
hi("Operator", { link = "Statement" })
hi("Keyword", { link = "Statement" })
hi("Exception", { link = "Statement" })

hi("PreProc", { fg = magenta, bg = none })
hi("Include", { fg = magenta, bg = none })
hi("Define", { link = "Include" })
hi("Macro", { link = "Include" })
hi("PreCondit", { link = "Include" })

hi("Type", { fg = magenta, bg = none })
hi("StorageClass", { link = "Type" })
hi("Structure", { link = "Type" })
hi("Typedef", { link = "Type" })

hi("Special", { fg = cyan, bg = none })
hi("SpecialChar", { link = "Special" })
hi("Tag", { fg = green, bg = none })
hi("Delimiter", { fg = magenta, bg = none })
hi("SpecialComment", { link = "Special" })
hi("Debug", { link = "Special" })

hi("Underlined", { fg = none, bg = none, underline = true })
hi("Ignore", { fg = base02, bg = none })
hi("Error", { fg = bright_red, bg = none, bold = true })
hi("Todo", { fg = magenta, bg = none, bold = true })
hi("Whitespace", { fg = bright_red, bg = none })

-- HTML
hi("htmlTag", { fg = text, bg = none })
hi("htmlEndTag", { fg = text, bg = none })

-- Markdown
hi("markdownCode", { fg = purple, bg = none })

-- Patch
hi("diffLine", { fg = cyan, bg = none, bold = true })
hi("diffAdded", { fg = green, bg = none })
hi("diffRemoved", { fg = red, bg = none })

-- Python
hi("pythonClassVar", { fg = cyan, bg = none })
hi("pythonExClass", { fg = red, bg = none })

-- YAML
hi("yamlKey", { fg = blue, bg = none })

-- Indent Blankline (indent guides)
hi("IndentBlanklineChar", { fg = base02, nocombine = true })
hi("IndentBlanklineContextChar", { fg = base04, nocombine = true })
hi("IndentBlanklineContextStart", { sp = base04, underline = true })
hi("IndentBlanklineContextSpaceChar", { nocombine = true })

-- Lspsaga
-- bg of "Normal" is "none" in the terminal which leads to
-- base01 beging used by plugins that link to "Normal".
hi("SagaNormal", { bg = base00 })
hi("SagaBorder", { link = "FloatBorder" })

-- Telescope
-- bg of "Normal" is "none" in the terminal which leads to
-- base01 beging used by plugins that link to "Normal".
hi("TelescopeNormal", { bg = base00 })
hi("TelescopeBorder", { link = "FloatBorder" })

-- -- -- Clap
-- -- hi("ClapShadow",          {fg=none,   bg=base02})
-- -- hi("ClapSpinner",         {fg=blue,   bg=dim_blue})
-- -- hi("ClapInput",   {link="Visual"})
-- -- hi("ClapDisplay",         {fg=base05, bg=base01})
-- -- hi("ClapPreview",         {fg=text,   bg=base01})
-- -- hi("ClapMatches", {link="Search"})
-- -- hi("ClapCurrentSelection",   s:green,  s:none, {fg=none, bg=bold})
-- -- hi("ClapSelected",         s:yellow, s:none, s:none, s:bold.",".s:underline)
-- -- hi("ClapBuffersNumber",     {fg=blue,   bg=none})
-- -- hi("ClapBuffersNumberBracket", {fg=blue, bg=none})
-- -- hi("ClapBuffersFsize",      {fg=base04, bg=none})
-- -- hi("ClapBuffersFname",      {fg=purple, bg=none})
-- -- hi("ClapFile",            {fg=base05, bg=none})
-- -- hi("ClapFpath",           {fg=purple, bg=none})
-- -- hi("ClapLinNrColumn",      {fg=base04, bg=none})
-- -- hi("ClapColumn",          {fg=base04, bg=none})
-- -- for i in range(1, 12)
-- --    hi("ClapFuzzyMatches".i, s:bright_blue,   s:none, {fg=none, bg=bold})
-- -- endfor

-- -- -- Lightline color scheme
-- -- local llcs = {'normal': {}, 'inactive': {}, 'command': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}
-- -- -- Colors:                 ofg           obg           ifg      ibg
-- -- local llcs.normal.left =    [[s:blue,        s:dim_blue],   [s:base06, s:base02]]
-- -- local llcs.normal.right =   [[s:base06,      s:base02],     [s:base06, s:base02]]
-- -- local llcs.inactive.right =  [[s:base05,      s:base02],     [s:base05, s:base02]]
-- -- local llcs.inactive.left =   [[s:base05,      s:base02],     [s:base05, s:base02]]
-- -- local llcs.command.left =   [[s:yellow,      s:dim_yellow],   [s:base06, s:base02]]
-- -- local llcs.insert.left =    [[s:green,       s:dim_green],   [s:base06, s:base02]]
-- -- local llcs.replace.left =   [[s:orange,      s:dim_orange],  [s:base06, s:base02]]
-- -- local llcs.visual.left =    [[s:magenta,      s:dim_magenta], [s:base06, s:base02]]
-- -- local llcs.normal.middle =   [[s:base05,      s:base02]]
-- -- local llcs.inactive.middle = [[s:base05,      s:base02]]
-- -- local llcs.tabline.left =   [[s:base05,      s:base03]]
-- -- local llcs.tabline.tabsel =  [[s:blue,        s:dim_blue]]
-- -- local llcs.tabline.middle =  [[s:base05,      s:base02]]
-- -- local llcs.tabline.right =   [[s:red,         s:dim_red]]
-- -- local llcs.normal.error =   [[s:bright_red,   s:base02]]
-- -- local llcs.normal.warning =  [[s:bright_yellow, s:base02]]
-- --
-- -- let g:lightline#colorscheme#stylo#palette = lightline#colorscheme#fill(s:llcs)
-- --
-- -- -- Reload lightline colors when colorscheme is reloaded (e.g, bg is changed)
-- -- if exists('g:loaded_lightline')
-- --    call lightline#init()
-- --    call lightline#colorscheme()
-- --    call lightline#update()
-- -- endif
