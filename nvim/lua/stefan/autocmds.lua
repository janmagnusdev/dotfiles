local function augroup(name)
  return vim.api.nvim_create_augroup("custom_" .. name, { clear = true })
end

-- Line Return: Return to the same line when you reopen a file.
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
  group = augroup("line_return"),
  pattern = "*",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Highlight on yank 
-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("TextYankPost"),
  pattern = "*",
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

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
    autocmd FileType gitcommit set spell tw=72 colorcolumn=+1
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
    autocmd BufEnter *.lua setl sw=2 ts=2 foldmethod=marker
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
    autocmd FileType markdown setl spell tw=72 sw=2 ts=2 fo-=tc

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

    autocmd FileType rst setl spell tw=72 sw=2 ts=2 fo-=tc

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
    autocmd FileType help setlocal tw=78
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
