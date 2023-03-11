local opt = vim.opt

-- Leader
vim.g.mapleader = ","
vim.g.maplocalleader = "ä"

-- Interface
opt.title = true -- Set window title to current filename
opt.signcolumn = "yes" -- Show sign column so that text doesn't shift
opt.relativenumber = true -- Show relative line numbers
opt.number = true -- Show absolute line number on cursor line (when relative number is on)
opt.cursorline = true -- highlight the current cursor line
-- opt.cursorcolumn = true -- highlight the current cursor line
-- set pumheight=20                -- Height of the popup menu
-- set completeopt=menu,preview,longest  -- set in nvim-cmp.lua
-- set wildmenu                    -- Improved command-line completion
-- set wildignore+=.git,.hg,_build,__pycache__,*.pyc
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
opt.diffopt:append({ "indent-heuristic", "algorithm:patience" })

-- Tabs & Indentation
opt.tabstop = 4 -- Number of spaces a tab in a file counts for
opt.shiftwidth = 4 -- Number of spaces for each step of (auto)indent
opt.expandtab = true -- Uses spaces for tabs
opt.shiftround = true -- Round indent to multiple of shiftwidth

-- Moving around / Editing
-- set "opt.textwidth" only for certain file types (see below)
opt.colorcolumn = "+1" -- Highlight these columns (+1 == textwidth)
opt.formatoptions = "tcrqnl1j" -- Auto-formatting options, see ":help fo-table"
opt.cpoptions:append("J") -- Two spaces between sentences
opt.joinspaces = true     -- Join sentences with two spaces
opt.virtualedit:append("block") -- Allow placing the cursor anywhere in vis. block mode
opt.iskeyword:append("-") -- consider "string-string" as *one* word
opt.foldlevelstart = 99         -- Start with all folds open
opt.foldmethod = "indent"       -- Default fold method: fold by indent

-- Searching
opt.incsearch = true -- Show matches while entering the search pattern
opt.ignorecase = true -- Ignore case while searching …
opt.smartcase = true -- … except when pattern contains an upper case character
opt.hlsearch = true -- Keep matches of previous search highlighted
opt.gdefault = true -- Set 'g' flag for substitutions by default

-- Line Return {{{

-- Return to the same line when you reopen a file.
vim.cmd([[
augroup line_return
    autocmd!
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END
]])

-- }}}

-- Filetype-specific settings ----------------------------------------------{{{
-- C {{{

vim.cmd([[
augroup ft_c
    autocmd!
    autocmd FileType c setl foldmethod=marker foldmarker={,}
augroup END
]])

-- }}}
-- CSS and SASS {{{

vim.cmd([[
augroup ft_css
    autocmd!
    autocmd Filetype css  setl sw=2 ts=2 foldmethod=marker foldmarker={,}
    autocmd Filetype scss setl sw=2 ts=2 foldmethod=marker foldmarker={,}
    autocmd Filetype sass setl sw=2 ts=2 foldmethod=indent
augroup END
]])

-- }}}
-- Git commit {{{

vim.cmd([[
augroup ft_gitcommit
    autocmd!
    autocmd FileType gitcommit set textwidth=72 colorcolumn=+1
augroup END
]])

-- }}}
-- HTML {{{

vim.cmd([[
augroup ft_html
    autocmd!
    autocmd BufEnter *.html setl sw=2 ts=2
augroup END
]])

-- }}}
-- Java {{{

vim.cmd([[
augroup ft_java
    autocmd!
    autocmd FileType java setl foldmethod=marker foldmarker={,}
augroup END
]])

-- }}}
-- Javascript {{{

vim.cmd([[
augroup ft_javascript
    autocmd!
    autocmd FileType javascript setl foldmethod=marker foldmarker={,}
augroup END
]])

-- }}}
-- LUA {{{

vim.cmd([[
augroup ft_lua
    autocmd!
    autocmd BufEnter *.lua setl sw=3 ts=3 foldmethod=marker
augroup END
]])

-- }}}
-- Mail {{{

vim.cmd([[
augroup ft_mail
    autocmd!
    autocmd Filetype mail setlocal spell tw=72 sw=2 ts=2 " Auto-wrap text using tw
augroup END
]])

-- }}}
-- Makefile {{{

vim.cmd([[
augroup ft_make
    autocmd!
    autocmd Filetype make setlocal noexpandtab shiftwidth=4 softtabstop=0
augroup END
]])

-- }}}
-- Markdown {{{

vim.cmd([[
augroup ft_markdown
    autocmd!

    autocmd BufEnter *.txt set ft=markdown
    autocmd BufEnter *.md set ft=markdown
    autocmd FileType markdown setl tw=72 sw=2 ts=2 fo-=tc

    " Use <localleader>1/2/3/4 to add headings.
    autocmd Filetype markdown nnoremap <buffer> <localleader>1 "zyy"zpVr=k
    autocmd Filetype markdown nnoremap <buffer> <localleader>2 "zyy"zpVr-k
    autocmd Filetype markdown nnoremap <buffer> <localleader>3 mzI###<space><ESC>`zllll
    autocmd Filetype markdown nnoremap <buffer> <localleader>4 mzI####<space><ESC>`zlllll
    " In insert mode, create to new lines below the heading to continue editing
    autocmd Filetype markdown inoremap <buffer> <localleader>1 <ESC>"zyy"zpVr=o<CR>
    autocmd Filetype markdown inoremap <buffer> <localleader>2 <ESC>"zyy"zpVr-o<CR>
    autocmd Filetype markdown inoremap <buffer> <localleader>3 <ESC>I###<space><ESC>o<CR>
    autocmd Filetype markdown inoremap <buffer> <localleader>4 <ESC>I####<space><ESC>o<CR>

augroup END
]])

-- }}}
-- Nginx {{{

vim.cmd([[
augroup ft_nginx
    autocmd!
    autocmd FileType nginx setl foldmethod=marker foldmarker={,}
augroup END
]])

-- }}}
-- Python {{{

local ft_python = vim.api.nvim_create_augroup("ft_python", { clear = true })
vim.api.nvim_create_autocmd({ "FileType" }, {
   pattern = "python",
   group = ft_python,
   callback = function()
      vim.opt_local.textwidth = PyLineLength()
      vim.opt_local.formatoptions:remove("t") -- Auto-wrap comments using textwidth
      vim.cmd('abb <buffer> ifmain if __name__ == "__main__"')

      -- Join and split a strings (enclosed with ')
      -- join:  "foo "\n"bar" --> "foo bar" (also works for f-strings!)
      -- split: "foo bar" --> "foo "\n"bar"
      vim.keymap.set("n", "<localleader>j", 'JF"df"', { buffer = true })
      vim.keymap.set("n", "<localleader>s", 'i"<CR>"<ESC>', { buffer = true })
   end,
})

-- vim.cmd([[
-- augroup ft_python
-- augroup END
-- ]])

-- }}}
-- QuickFix {{{

vim.cmd([[
augroup ft_quickfix
    autocmd!
    autocmd FileType qf setl nowrap
augroup END
]])

-- }}}
-- ReStructuredText {{{

vim.cmd([[
augroup ft_rest
    autocmd!

    autocmd FileType rst setl tw=72 sw=2 ts=2 fo-=tc

    " Title, parts, chapters and sections 1/2/3/4
    autocmd Filetype rst nnoremap <buffer> <localleader>t "zyy"zPVr="zyyj"zpk
    autocmd Filetype rst nnoremap <buffer> <localleader>p "zyy"zpVr#k
    autocmd Filetype rst nnoremap <buffer> <localleader>c "zyy"zpVr*k
    autocmd Filetype rst nnoremap <buffer> <localleader>1 "zyy"zpVr=k
    autocmd Filetype rst nnoremap <buffer> <localleader>2 "zyy"zpVr-k
    autocmd Filetype rst nnoremap <buffer> <localleader>3 "zyy"zpVr^k
    autocmd Filetype rst nnoremap <buffer> <localleader>4 "zyy"zpVr"k
    " In insert mode, create to new lines below the heading to continue editing
    " <localleader> is ä and there are just to many German words with "äc(h",
    " "ät" or "äp" ...
    " autocmd Filetype rst inoremap <buffer> <localleader>t <ESC>"zyy"zPVr="zyyj"zpo<CR>
    " autocmd Filetype rst inoremap <buffer> <localleader>p <ESC>"zyy"zpVr#o<CR>
    " autocmd Filetype rst inoremap <buffer> <localleader>c <ESC>"zyy"zpVr*o<CR>
    autocmd Filetype rst inoremap <buffer> <localleader>1 <ESC>"zyy"zpVr=o<CR>
    autocmd Filetype rst inoremap <buffer> <localleader>2 <ESC>"zyy"zpVr-o<CR>
    autocmd Filetype rst inoremap <buffer> <localleader>3 <ESC>"zyy"zpVr^o<CR>
    autocmd Filetype rst inoremap <buffer> <localleader>4 <ESC>"zyy"zpVr"o<CR>

augroup END
]])

-- }}}

-- Term {{{

-- With line numbers, long lines are truncated when switching from Normal Mode to Insert Mode.
vim.cmd([[
augroup ft_term
    autocmd TermOpen * setlocal signcolumn=no nonumber norelativenumber nocursorcolumn scrolloff=0 sidescrolloff=0
augroup END
]])
-- autocmd BufWinEnter,WinEnter term://* call FixWidth()

-- }}}
-- TeX {{{

vim.cmd([[
augroup ft_tex
    autocmd!
    autocmd FileType tex setl sw=2 ts=2
augroup END
]])

-- }}}
-- Vim {{{

vim.cmd([[
augroup ft_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType help setlocal textwidth=78
augroup END
]])

-- }}}
-- XC (XVM) {{{

vim.cmd([[
augroup ft_xc
    autocmd!
    autocmd BufEnter *.xc set ft=javascript
    autocmd BufEnter *.xc setl sw=2 ts=2
augroup END
]])

-- }}}
-- YAML {{{

vim.cmd([[
augroup ft_yaml
    autocmd!
    autocmd BufEnter *.yaml.j2 set ft=yaml
augroup END
]])

-- }}}
-- }}}
