local opt = vim.opt

-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = "ö"

-- Interface
opt.title = true -- Set window title to current filename
opt.signcolumn = "yes" -- Show sign column so that text doesn't shift
opt.relativenumber = true -- Show relative line numbers
opt.number = true -- Show absolute line number on cursor line (when relative number is on)
opt.cursorline = true -- highlight the current cursor line
-- opt.cursorcolumn = true -- highlight the current cursor line
opt.completeopt = "menu,menuone,noselect" -- Completion options recommended by nvim-cmp
opt.wildmode = "longest:full,full"
opt.clipboard:append({ "unnamed", "unnamedplus" }) -- use system clipboard as default register
opt.list = true -- Show listchars
-- opt.listchars = { tab = "▸ ", trail = "·", nbsp = "~", eol = "¬", precedes = "❮", extends = "❯" }
opt.listchars = { tab = "▸ ", trail = "·", nbsp = "~", precedes = "❮", extends = "❯" }
opt.wrap = false -- Don’t wrap long lines
opt.breakindent = true -- Indent continued lines after break
opt.showbreak = "↪" -- Show symbol for continued lines after break
opt.linebreak = true -- Don’t wrap long lines in the middle of a word
opt.scrolloff = 3 -- Display at least 3 lines above/below cursor
opt.sidescrolloff = 3 -- Display at least 3 columns right/left of cursor
opt.timeoutlen = 500 -- Reduce timeout for key combos to open "which-key" plug-in faster
opt.mouse = "a" -- Enable the use of mouse in all modes
if vim.env.TERM_PROGRAM ~= "Apple_Terminal" then
  opt.termguicolors = true -- Enable 24-bit RGB color in the TUI
end

-- Behavior
-- opt.autoread = true             -- Reload file if changed outside of vim
-- opt.hidden = true               -- Don’t unload abandoned buffers
-- opt.startofline = false         -- Keep the cursor in the same column when moving
-- opt.backup = false              -- Don’t create backups on save
opt.swapfile = false -- Don’t create swap files
opt.modeline = false -- Don’t read modelines from files
opt.confirm = true -- Y-N-C promt if closing with unsaved changes
opt.showmode = false -- Disable mode message, Lualine also has it
opt.splitbelow = true -- Open hsplit below current window
opt.splitright = true -- Open vsplit right of current window
opt.splitkeep = "cursor"  -- Keep text on same screen line on hsplit
-- opt.shortmess:append({ W = true, I = true, c = true }) -- Don't show "file written", Intro, completion msg
-- When using noice, "W" must be false or filtering will not work properly:
opt.shortmess:append({ -- Don't show ...
  W = true, -- ... "file written"
  I = true, -- ... intro
  c = true, -- ... completion message
  C = true, -- ... "scanning tags"
})
opt.diffopt:append({ "indent-heuristic", "algorithm:patience" })
-- opt.undofile = true -- Save undo history to a file and restore on next load

-- Tabs & Indentation
opt.tabstop = 4 -- Number of spaces a tab in a file counts for
opt.shiftwidth = 4 -- Number of spaces for each step of (auto)indent
opt.expandtab = true -- Uses spaces for tabs
opt.smartindent = true -- Insert indents automatically
opt.shiftround = true -- Round indent to multiple of shiftwidth

-- Moving around / Editing
-- set "opt.textwidth" only for certain file types (see below)
opt.colorcolumn = "+1" -- Highlight these columns (+1 == textwidth)
opt.formatoptions = "tcrqnl1j" -- Auto-formatting options, see ":help fo-table"
opt.cpoptions:append("J") -- Two spaces between sentences
opt.joinspaces = true -- Join sentences with two spaces
opt.virtualedit:append("block") -- Allow placing the cursor anywhere in vis. block mode
opt.iskeyword:append("-") -- consider "string-string" as *one* word
opt.foldlevelstart = 99 -- Start with all folds open
opt.foldmethod = "indent" -- Default fold method: fold by indent

-- Searching
opt.incsearch = true -- Show matches while entering the search pattern
opt.ignorecase = true -- Ignore case while searching …
opt.smartcase = true -- … except when pattern contains an upper case character
opt.hlsearch = true -- Keep matches of previous search highlighted
opt.inccommand = "nosplit" -- Live preview of substitions while typing
opt.gdefault = true -- Set 'g' flag for substitutions by default
opt.grepprg = "rg --vimgrep" -- Use ripgrep as grep command ...
opt.grepformat = "%f:%l:%c:%m" -- ... and adjust the grepformat for it
