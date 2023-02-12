" https://github.com/romainl/idiomatic-vimrc/blob/master/idiomatic-vimrc.vim
" Preamble ---------------------------------------------------------------- {{{
call plug#begin('~/.vim/plugged')

" Interface plug-ins
Plug 'RRethy/vim-hexokinase', {'do': 'make hexokinase'}
Plug 'itchyny/lightline.vim'
Plug 'jremmen/vim-ripgrep'  " Accepts *all* rg options (':Clap grep' does not)
Plug 'liuchengxu/vim-clap', {'do': ':Clap install-binary'}
Plug 'rhysd/git-messenger.vim', {'on': 'GitMessenger'}
Plug 'stefandtw/quickfix-reflector.vim'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-vinegar'
Plug 'vim-scripts/kwbdi.vim'
Plug 'zerowidth/vim-copy-as-rtf', {'on': 'CopyRTF'}

" Editing plug-ins
Plug 'ervandew/supertab'
Plug 'flwyd/vim-conjoin'
Plug 'mg979/vim-visual-multi'
Plug 'michaeljsmith/vim-indent-object'
Plug 'nelstrom/vim-visual-star-search'
Plug 'rhysd/clever-f.vim'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'wellle/targets.vim'

" Tools
Plug '~/Projects/zettel.vim'
Plug 'sjl/splice.vim', {'on': 'SpliceInit'}
Plug 'tpope/vim-fugitive'
Plug 'w0rp/ale'

" Filetype plug-ins
Plug 'othree/html5.vim',             {'for': 'html'}
Plug 'Glench/Vim-Jinja2-Syntax',     {'for': 'jinja'}
Plug 'chr4/nginx.vim',               {'for': 'nginx'}
Plug 'mgedmin/coverage-highlight.vim', {'for': 'python'}
Plug 'davidhalter/jedi-vim',         {'for': 'python'}
Plug 'vim-python/python-syntax',     {'for': 'python'}
Plug 'Vimjas/vim-python-pep8-indent',{'for': 'python'}
Plug 'kalekundert/vim-coiled-snake', {'for': 'python'}
Plug 'rust-lang/rust.vim',           {'for': 'rust'}
Plug 'cespare/vim-toml',             {'for': 'toml'}
Plug 'stephpy/vim-yaml',             {'for': 'yaml'}

call plug#end()

" Required:
filetype plugin indent on
syntax enable

" }}}
" Basic options ----------------------------------------------------------- {{{

""" Interface
set title                   " Set window title
set relativenumber          " Display relative line numbers
set number                  " Display the absolute line number for the current line
set cursorline              " Highlight current line
set cursorcolumn            " Highlight current column
set pumheight=20            " Height of the popup menu
set completeopt=menu,preview,longest
set wildmenu                " Improved command-line completion
set wildignore+=.git,.hg,_build,__pycache__,*.pyc
set wildmode=longest:full,full
set clipboard=unnamed,unnamedplus
" set listchars=tab:▸\ ,trail:·,nbsp:~,eol:¬,precedes:❮,extends:❯
set listchars=tab:▸\ ,trail:·,nbsp:~,precedes:❮,extends:❯
set list                    " Display listchars
set nowrap                  " Don’t wrap long lines
set breakindent             " Indent continued lines after break
set showbreak=↪             " Show symbol for contiuned lines after break
set linebreak               " Don’t wrap long lines in the middle of a word
set scrolloff=3             " Display at least 3 lines above/below cursor
set sidescrolloff=3         " Display at least 3 columns right/left of cursor
set mouse=a                 " Enable the use of mouse in all modes
if $TERM_PROGRAM !=? 'Apple_Terminal'
    set termguicolors           " Use "guifg"/"guibg" in term (use 24-bit colors)
endif

""" Behavior
set autoread                " Reload file if changed outside of vim
set hidden                  " Don’t unload abandoned buffers
set nostartofline           " Keep the cursor in the same column when moving
set nobackup                " Don’t create backups on save
set noswapfile              " Don’t create swap files
set nomodeline              " Don’t read modelines from files
" set diffopt+=algorithm:patience
" set diffopt+=indent-heuristic
set splitbelow              " Open hsplit below current window
set splitright              " Open vsplit right of current window
"
""" Messages, Info, Status
set confirm                 " Y-N-C promt if closing with unsaved changes
set ruler                   " Show line and column number
set showcmd                 " Show command in the bottom right of the screen
set laststatus=2            " Always show statusbar
set noshowmode              " Disable mode message, Lightline also has it
" Disabled, use Lightline instead
" set statusline=             " Make a nice status line
" set statusline+=\ %f                            " filename
" set statusline+=\ %m%r%h%w                      " status flags
" set statusline+=%y                              " file type
" set statusline+=\[%{&fenc}]                     " file encoding
" set statusline+=\[%{&ff}]                       " file format
" set statusline+=%=                              " right align remainder
" set statusline+=%{&et?'Spaces':'Tab\ size'}     " indent type (tabs or spaces)
" set statusline+=:\ %-4{&tabstop}                " indent widh in spaces
" set statusline+=%-10(%l,%c%)                    " line, column
" set statusline+=%P                              " file position

""" Tabs & Indentation
set tabstop=4               " Number of spaces a tab in a file counts for
set shiftwidth=4            " Number of spaces for each step of (auto)indent
set softtabstop=4           " Number of spaces a tab counts for in editing ops
set expandtab               " Uses spaces for tabs ...
set smarttab                " ... except if we are already using tabs
set shiftround              " Round indent to multiple of shiftwidth

""" Moving around / Editing
set encoding=utf-8          " Default character encoding
set textwidth=88            " Maximum width of text that is being inserted
set colorcolumn=+1          " Highlight these columns (+1 == textwidth)
set autoindent              " Automatically indent new lines
set formatoptions=rqn2l1j   " Auto-formatting options, see ":help fo-table"
set cpoptions+=J            " Two spaces between sentences
set virtualedit+=block      " Allow placing the cursor anywhere in vis. block mode
set foldlevelstart=99       " Start with all folds open
set foldmethod=indent       " Default fold method: fold by indent

""" Searching
set incsearch               " Show matches while entering the search pattern
set ignorecase              " Ignore case while searching …
set smartcase               " … except when pattern contains an upper case character
set hlsearch                " Keep matches of previous search highlighted
set gdefault                " Set 'g' flag for substitutions by default

""" Leader
let mapleader=","
let maplocalleader="ä"

" Line Return {{{

" Return to the same line when you reopen a file.
augroup line_return
    autocmd!
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

" }}}
" Color scheme {{{

syntax on
set background=light

function! SetBackgroundMode(...)
    let s:new_bg = systemlist("dm get")[0]
    if &background !=? s:new_bg
        " echo 'changing'.&background . s:new_bg
        let &background = s:new_bg
    endif
endfunction
call SetBackgroundMode()
call timer_start(3000, "SetBackgroundMode", {"repeat": -1})

set synmaxcol=200  " Don't try to highlight lines longer than x characters.
colorscheme stylo

" Reload the colorscheme whenever we write the file.
augroup color_dev
    autocmd!
    autocmd BufWritePost rasta.vim color rasta
    autocmd BufWritePost stylo.vim color stylo
augroup END

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" }}}
" GUI {{{

if exists('neovim_dot_app')
  call MacSetFont('Menlo', 13)

  " Tab switching
  nnoremap <C-Tab> <C-PageDown>
  vnoremap <C-Tab> <C-PageDown>
  inoremap <C-Tab> <C-O><C-PageDown>
  nnoremap <C-S-Tab> <C-PageUp>
  vnoremap <C-S-Tab> <C-PageUp>
  inoremap <C-S-Tab> <C-O><C-PageUp>

elseif has('gui_running')
  set guioptions-=T  " Hide toolbar
  " set guicursor+=a:blinkon0
  " set guicursor+=i-ci:ver10-Cursor-blinkwait500-blinkoff500-blinkon500
  " set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20

  if has('gui_macvim')
    set guifont=Menlo:h13

    " Tab switching
    nnoremap <C-Tab> <C-PageDown>
    vnoremap <C-Tab> <C-PageDown>
    inoremap <C-Tab> <C-O><C-PageDown>
    nnoremap <C-S-Tab> <C-PageUp>
    vnoremap <C-S-Tab> <C-PageUp>
    inoremap <C-S-Tab> <C-O><C-PageUp>

  elseif has('gui_gtk2')
    set guifont=Hack\ 11,DejaVu\ Sans\ Mono\ 11,Monospace\ 11

    noremap <C-o> :tabnew
    noremap <C-t> :tabnew .<CR>
    noremap <C-w> :q<CR>

    " copy/paste
    vnoremap <special> <C-x> "+x
    vnoremap <special> <C-c> "+y
    cnoremap <special> <C-c> <C-y>
    nnoremap <special> <C-v> "+P
    inoremap <special> <C-v> <C-r>+
    cnoremap <special> <C-v> <C-r>+

  endif
endif
" }}}

" }}}
" Convenience mappings ---------------------------------------------------- {{{
" Editing {{{

" Fast editing of the .vimrc
nnoremap <leader>ve :e $MYVIMRC<CR>
nnoremap <leader>vs :source $MYVIMRC<CR>

" Set filetype to "mail" (for composing emails)
nnoremap <leader>Tm :set ft=mail<CR>

" Toggle paste mode
set pastetoggle=<F2>

" jj to exit insert mode
inoremap jj <ESC>

" Swap q and @ for macros, because q is easier to type on German keyboards
noremap q @
noremap @ q

" Make Y behave like D (instead Y is the same as yy), fix this:
noremap Y y$

" Keep the cursor in place while joining lines
" Disabled. Defaults suites me currently better. :)
" nnoremap J mzJ`z

" Join an entire paragraph.
nnoremap <leader>J mzvipJ`z

" Split line (sister to [J]oin lines)
" The normal use of S is covered by cc, so don't worry about shadowing it.
" TrimSpaces() is defined in the mini-plugins section.
nnoremap S i<CR><ESC>:call TrimSpaces(1)<CR>

" Re-hardwrap paragraphs of text
nnoremap <leader>q gqip
vnoremap <leader>q gq

" Keep visual selection when indenting
vnoremap < <gv
vnoremap > >gv

" Easier linewise reselection of what you just pasted.
nnoremap <leader>V `[V`]

" When I forgot to sudo before editing ...
cnoremap w!! w !sudo tee % >/dev/null

" Unfuck my screen
nnoremap U :syntax sync fromstart<CR>:redraw!<CR>

" Fix width of term windows after switching windows
function! FixWidth()
    resize -1
    resize +1
    vertical resize -1
    vertical resize +1
endfunction
" nnoremap <silent> <leader>fw :resize -1<CR>:resize +1<CR>:vertical resize -1<CR>:vertical resize +1<CR>
nnoremap <silent> <leader>fw :call FixWidth()<CR>

" When pressing <leader>cd switch to the directory of the open buffer
nnoremap <leader>cd :cd %:p:h<CR>

" open/close the quickfix window
nnoremap <leader>co :copen<CR>
nnoremap <leader>cc :cclose<CR>
nnoremap <leader>lo :lopen<CR>
nnoremap <leader>lc :lclose<CR>

" "Uppercase word" mapping by Steve Losh
"
" This mapping allows you to press <c-u> in insert mode to convert the current
" word to uppercase.  It's handy when you're writing names of constants and
" don't want to use Capslock.
"
" To use it you type the name of the constant in lowercase.  While your
" cursor is at the end of the word, press <c-u> to uppercase it, and then
" continue happily on your way.
"
" It works by exiting out of insert mode, recording the current cursor location
" in the z mark, using gUiw to uppercase inside the current word, moving back
" to the z mark, and entering insert mode again.
inoremap <C-u> <ESC>mzgUiw`za

" }}}
" Searching and movement {{{

" , is my leader, but ö/Ö are unused
noremap ö ;
noremap Ö ,

" ` for jumping to a mark does not work well on German keyboards
noremap ü `

" Clear search term (remove highlighting)
noremap <silent> <leader><Space> :nohlsearch<CR>

" Don't move on *
" I'd use a function for this but Vim clobbers the last search when you're in
" a function so fuck it, practicality beats purity.
nnoremap <silent> * :let stay_star_view = winsaveview()<CR>*:call winrestview(stay_star_view)<CR>

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" Same when jumping around
nnoremap g; g;zz
nnoremap g, g,zz
nnoremap <c-o> <c-o>zz

" Find TODOs in all files
nnoremap <leader>td :vimgrep '\vTODO\|FIXME\|XXX' **/*<CR>:copen<CR>

" Heresy (emacs movement to start/end of line while editing)
inoremap <c-a> <ESC>I
inoremap <c-e> <ESC>A
cnoremap <c-a> <home>
cnoremap <c-e> <end>

" gi already moves to "last place you exited insert mode", so we'll map gI to
" something similar: move to last change
nnoremap gI `.

" Ctrl-jklm to move between windows
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
augroup netrw_mapping
    autocmd!
    autocmd filetype netrw noremap <buffer> <C-h> <C-w>h
    autocmd filetype netrw noremap <buffer> <C-j> <C-w>j
    autocmd filetype netrw noremap <buffer> <C-k> <C-w>k
    autocmd filetype netrw noremap <buffer> <C-l> <C-w>l
augroup END

" Create horizontal/vertical split
noremap <leader>sh :split<CR>
noremap <leader>sv :vsplit<CR>
noremap <leader>se <C-w>=
noremap <leader>sx :close<CR>
" Create small, vertical split with a terminal
noremap <leader>st :split<CR>:resize 10<CR>:term<CR>

" }}}
" Toggles {{{

" Toggle line numbers
nnoremap <leader>nn :setlocal number! relativenumber!<CR>

" Toggle wrap
nnoremap <leader>w :set wrap!<CR>

" }}}
" Folding ----------------------------------------------------------------- {{{

" Use space to toggle folds
nnoremap <Space> za
vnoremap <Space> za

" Make zO recursively open whatever fold we're in, even if it's partially open.
nnoremap zO zczO

" "Focus" the current line.  Basically:
"
" 1. Close all folds.
" 2. Open just the folds containing the current line.
" 3. Move the line to a little bit (15 lines) above the center of the screen.
nnoremap <c-z> mzzMzvzz15<c-e>`z
" }}}
" }}}
" Filetype-specific ------------------------------------------------------- {{{
" C {{{

augroup ft_c
    autocmd!
    autocmd FileType c setl foldmethod=marker foldmarker={,}
augroup END

" }}}
" CSS and SASS {{{

augroup ft_css
    autocmd!
    autocmd Filetype css  setl sw=2 ts=2 sts=2 foldmethod=marker foldmarker={,}
    autocmd Filetype scss setl sw=2 ts=2 sts=2 foldmethod=marker foldmarker={,}
    autocmd Filetype sass setl sw=2 ts=2 sts=2 foldmethod=indent
augroup END

" }}}
" Git commit {{{

augroup ft_gitcommit
    autocmd!
    autocmd FileType gitcommit set textwidth=72
augroup END

" }}}
" HTML {{{

augroup ft_html
    autocmd!
    autocmd BufEnter *.html setl sw=2 ts=2 sts=2
augroup END

" }}}
" Java {{{

augroup ft_java
    autocmd!
    autocmd FileType java setl foldmethod=marker foldmarker={,}
augroup END

" }}}
" Javascript {{{

augroup ft_javascript
    autocmd!
    autocmd FileType javascript setl foldmethod=marker foldmarker={,}
augroup END

" }}}
" Mail {{{

augroup ft_mail
    autocmd!
    autocmd Filetype mail setlocal spell tw=72 fo+=t sw=2 ts=2 sts=2  " Auto-wrap text using tw
augroup END

" }}}
" Makefile {{{

augroup ft_make
    autocmd!
    autocmd Filetype make setlocal noexpandtab shiftwidth=4 softtabstop=0
augroup END

" }}}
" Markdown {{{

augroup ft_markdown
    autocmd!

    autocmd BufEnter *.txt set ft=markdown
    autocmd BufEnter *.md set ft=markdown
    autocmd FileType markdown setl tw=72 sw=2 ts=2 sts=2 fo-=t

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

" }}}
" Mercurial {{{

augroup ft_mercurial
    autocmd!
    autocmd BufNewFile,BufRead *hg-editor-*.txt setl filetype=hgcommit
augroup END

" }}}
" Nginx {{{

augroup ft_nginx
    autocmd!
    autocmd FileType nginx setl foldmethod=marker foldmarker={,}
augroup END

" }}}
" Python {{{

augroup ft_python

    autocmd!
    autocmd FileType python execute ":setl tw=".LineLength()
    autocmd FileType python setl fo+=c  " Auto-wrap comments using textwidth
    autocmd Filetype python abb <buffer> ifmain if __name__ == "__main__"
    autocmd Filetype python abb <buffer> pyqtbreak from PyQt5.QtCore import pyqtRemoveInputHook; pyqtRemoveInputHook(); breakpoint

    " Join and split a strings (enclosed with ')
    " join:  "foo "\n"bar" --> "foo bar" (also works for f-strings!)
    " split: "foo bar" --> "foo "\n"bar"
    autocmd FileType python nnoremap <buffer> <localleader>j JF"df"
    autocmd FileType python nnoremap <buffer> <localleader>s i"<CR>"<ESC>

    " Change dict item to attribute access and keep cursor position
    " aa: foo["bar"] --> foo.bar
    " ia: foo.bar --> foo["bar"]
    " Use nmap so that the surround plugin can be utilized.
    autocmd FileType python nmap <buffer> <localleader>aa mzbi.<ESC>ds"ds]`zh
    autocmd FileType python nmap <buffer> <localleader>ia mzysiw]lysiw"bx`zl
augroup END

" }}}
" QuickFix {{{

augroup ft_quickfix
    autocmd!
    autocmd FileType qf setl nowrap
augroup END

" }}}
" ReStructuredText {{{

augroup ft_rest
    autocmd!

    autocmd FileType rst setl tw=72 sw=2 ts=2 sts=2 fo-=t

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

" }}}
" TeX {{{

augroup ft_tex
    autocmd!
    autocmd FileType tex setl sw=2 ts=2 sts=2
augroup END

" }}}
" Vim {{{

augroup ft_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType help setlocal textwidth=78
augroup END

" }}}
" XC (XVM) {{{

augroup ft_xc
    autocmd!
    autocmd BufEnter *.xc set ft=javascript
    autocmd BufEnter *.xc setl sw=2 ts=2 sts=2
augroup END

" }}}
" YAML {{{

augroup ft_yaml
    autocmd!
    autocmd BufEnter *.yaml.j2 set ft=yaml
augroup END

" }}}

" }}}
" Plugin settings --------------------------------------------------------- {{{
" ALE {{{

let g:ale_fixers = {
\    'python': ['autoflake', 'isort', 'black'],
\}
" let g:ale_lint_on_enter = 0  " pylint is too slow on larger files
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 1
let g:ale_linters = {
\    'python': ['flake8', 'pylint', 'mypy'],
\}
let g:ale_python_mypy_ignore_invalid_syntax = 1
let g:ale_python_mypy_options = '--ignore-missing-imports'
let g:ale_sign_error = '⨯'
let g:ale_sign_warning = '⚠︎'
let g:ale_statusline_format = ['⨯%d', '⚠%d', '✓']

" }}}
" Clap {{{

let g:clap_layout = {'relative': 'editor', 'width': '66%', 'height': '40%', 'row': '15%', 'col': '17%'}
let g:clap_popup_border = 'rounded'
let g:clap_enable_background_shadow = 0
let g:clap_preview_direction = 'UD'
let g:clap_current_selection_sign = {
    \ "text": " ➤",
    \ "texthl": "WarningMsg",
    \ "linehl": "ClapCurrentSelection"
    \}

let g:clap_selected_sign = {
    \ "text": " ✔︎",
    \ "texthl": "WarningMsg",
    \ "linehl": "ClapSelected"
    \}

" Mnemoic: 'o'pen ('f'ile, 'd'otfiles, 'b'uffer, 'm'ru)
nnoremap <leader>ff :Clap files<CR>
nnoremap <leader>fb :Clap buffers<CR>
nnoremap <leader>fs :Clap grep<CR>
nnoremap <leader>fc :Clap grep ++query=<cword><CR>
nnoremap <leader>ft :Clap filetypes<CR>

" }}}
" Git-messenger {{{

nnoremap <leader>gm :GitMessenger<CR>

" }}}
" Hexokinase {{{
let g:Hexokinase_highlighters = ['virtual']
let g:Hexokinase_optInPatterns = 'full_hex,rgb,rgba,hsl,hsla'
let g:Hexokinase_ftOptInPatterns = {
\     'css': 'full_hex,rgb,rgba,hsl,hsla,colour_names',
\ }
" }}}
" Lightline {{{

let g:lightline = {
    \ 'colorscheme': 'stylo',
    \ 'active': {
    \   'left': [['mode', 'paste'], ['virtualenv', 'relativepath'], ['ale', 'readonly', 'modified']],
    \   'right': [['percent'], ['lineinfo'],
    \             ['filetype', 'fileencoding', 'fileformat', 'indentation']]
    \ },
    \ 'inactive': {
    \   'left': [['readonly', 'relativepath', 'modified']],
    \   'right': [['percent'], ['lineinfo']]
    \ },
    \ 'component_function': {
    \   'ale': 'ALEGetStatusLine',
    \   'indentation': 'LlIndentation',
    \   'virtualenv': 'GetCurrentEnv',
    \ }
    \}

function! LlIndentation()
    let text = (&et ? 's' : 't').':'.&tabstop
    return winwidth('.') > 70 ? text : ''
endfunction

function! GetCurrentEnv()
    let envdir = ''
    if isdirectory($VIRTUAL_ENV)
        let envdir = $VIRTUAL_ENV
    elseif isdirectory($CONDA_PREFIX)
        let envdir = $CONDA_PREFIX
    endif
    if envdir != ''
        return fnamemodify(envdir, ':t')
    endif
    return ''
endfunction

" }}}
" Neomake {{{

" autocmd! BufWritePost,BufRead * Neomake

" }}}
" Python-syntax {{{

let g:python_highlight_all = 1

" }}}
" Python jedi {{{

let g:jedi#popup_on_dot = 0
let g:jedi#smart_auto_mappings = 0
let g:jedi#goto_command = "<leader>d"
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_stubs_command = ""
let g:jedi#completions_command = "<C-Space>"
let g:jedi#usages_command = "<leader>n"
let g:jedi#rename_command = "<leader>r"
let g:jedi#documentation_command = "K"
let g:jedi#show_call_signatures = "1"

" }}}
" Supertab {{{

let g:SuperTabDefaultCompletionType = "context"

" }}}
" }}}
" Mini-plugins ------------------------------------------------------------ {{{
" Stuff that should probably be broken out into plugins, but hasn't proved to
" be worth the time to do so just yet.

" Pyproject.toml Line Length {{{
"
" Extract a project's line length from pyproject.toml

function! LineLength()
    let root = clap#path#find_project_root(bufnr('%'))
    let fname = root . "/pyproject.toml"
    if filereadable(fname)
        let tw = str2nr(system("rg -Nr '$1' 'line-length\\s+=\\s+(\\d+)' " . fname))
        if tw > 0
            return tw
        endif
    endif
    return 88
endfunction

" }}}
" Synstack {{{

" Show the stack of syntax highlighting classes affecting whatever is under the
" cursor.
function! SynStack()
  echo join(map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")'), " > ")
endfunc

nnoremap <leader>hi :call SynStack()<CR>

" }}}
" Highlight Word {{{
"
" This mini-plugin provides a few mappings for highlighting words temporarily.
"
" Sometimes you're looking at a hairy piece of code and would like a certain
" word or two to stand out temporarily.  You can search for it, but that only
" gives you one color of highlighting.  Now you can use <leader>N where N is
" a number from 1-6 to highlight the current word in a specific color.

function! HiInterestingWord(n) " {{{
    " Save our location.
    normal! mz

    " Yank the current word into the z register.
    normal! "zyiw

    " Calculate an arbitrary match ID.  Hopefully nothing else is using it.
    let mid = 86750 + a:n

    " Clear existing matches, but don't worry if they don't exist.
    silent! call matchdelete(mid)

    " Construct a literal pattern that has to match at boundaries.
    let pat = '\V\<' . escape(@z, '\') . '\>'

    " Actually match the words.
    call matchadd("InterestingWord" . a:n, pat, 1, mid)

    " Move back to our original location.
    normal! `z
endfunction " }}}

" Mappings {{{

nnoremap <silent> <leader>1 :call HiInterestingWord(1)<CR>
nnoremap <silent> <leader>2 :call HiInterestingWord(2)<CR>
nnoremap <silent> <leader>3 :call HiInterestingWord(3)<CR>
nnoremap <silent> <leader>4 :call HiInterestingWord(4)<CR>
nnoremap <silent> <leader>5 :call HiInterestingWord(5)<CR>
nnoremap <silent> <leader>6 :call HiInterestingWord(6)<CR>

" }}}
" Default Highlights {{{

hi def InterestingWord1 guibg=#9CDEFF ctermbg=117 guifg=#2F2F2F ctermfg=16
hi def InterestingWord2 guibg=#53EFA1 ctermbg=79  guifg=#2F2F2F ctermfg=16
hi def InterestingWord3 guibg=#AAE800 ctermbg=148 guifg=#2F2F2F ctermfg=16
hi def InterestingWord4 guibg=#FFC866 ctermbg=221 guifg=#2F2F2F ctermfg=16
hi def InterestingWord5 guibg=#FFBBAB ctermbg=216 guifg=#2F2F2F ctermfg=16
hi def InterestingWord6 guibg=#FFB3FF ctermbg=219 guifg=#2F2F2F ctermfg=16
" }}}

" }}}
" Remove trailing whitespace {{{

function! TrimSpaces(current_line)
    let l:state = winsaveview()
    let l:_s=@/
    if a:current_line == 1
        s/\s\+$//e
    else
        %s/\s\+$//e
    endif
    nohlsearch
    let @/=l:_s
    call winrestview(l:state)
endfunction
augroup trim_spaces
    autocmd!
    autocmd FileWritePre * :call TrimSpaces(0)
    autocmd FileAppendPre * :call TrimSpaces(0)
    autocmd FilterWritePre * :call TrimSpaces(0)
    autocmd BufWritePre * :call TrimSpaces(0)
augroup END
nnoremap <leader>ts :call TrimSpaces(0)<CR>

" }}}
" SmartHome (vim tip 315) {{{

function! SmartHome()
    let s:col = col(".")
    normal! ^
    if s:col == col(".")
        normal! 0
    endif
endfunction
nnoremap <silent> <Home> :call SmartHome()<CR>
inoremap <silent> <Home> <C-O>:call SmartHome()<CR>
nnoremap <silent> 0 :call SmartHome()<CR>

" }}}
" Spelling {{{

" Toggle spelling mode and add the dictionary to the completion list of
" sources if spelling mode has been entered, otherwise remove it when
" leaving spelling mode.
function! Spelling()
    setlocal spell!
    if &spell
        set complete+=kspell
        echo "Spell mode enabled"
    else
        set complete-=kspell
        echo "Spell mode disabled"
    endif
endfunction

nnoremap <leader>sp :call Spelling()<CR>
nnoremap <leader>spde :setl spell spelllang=de_de
nnoremap <leader>spen :setl spell spelllang=en

" }}}
" Switch theme / background {{{

function! SwitchTheme()
    if &background ==? 'light'
        set background=dark
    else
        set background=light
    endif
endfunction
nnoremap <leader>st :call SwitchTheme()<CR>
" }}}
" }}}
" Neovim -------------------------------------------------------------------{{{
if has('nvim')
    set inccommand=nosplit

    " Make escape work in the Neovim terminal.
    tnoremap <ESC> <C-\><C-n>
    " Map C-n C-n to escape for console apps that use this key
    tnoremap <C-n><C-n> <ESC>
    " Map Shift+Space to Space as I hit this combo by accident a lot ...
    tnoremap <S-Space> <Space>
    " Make navigation into and out of Neovim terminal splits nicer.
    " tnoremap <C-h> <C-\><C-N><C-w>h
    " tnoremap <C-j> <C-\><C-N><C-w>j
    " tnoremap <C-k> <C-\><C-N><C-w>k
    " tnoremap <C-l> <C-\><C-N><C-w>l

    " With line numbers, long lines are truncated when switching from Normal
    " Mode to Insert Mode.
    autocmd TermOpen * setlocal nonumber norelativenumber nocursorcolumn scrolloff=0 sidescrolloff=0
    autocmd BufWinEnter,WinEnter term://* call FixWidth()

    if filereadable('/opt/homebrew/bin/python3')
        let g:python3_host_prog = '/opt/homebrew/bin/python3'
    elseif filereadable('/usr/local/bin/python3')
        let g:python3_host_prog = '/usr/local/bin/python3'
    else
        let g:python3_host_prog = '/usr/bin/python3'
    endif
endif
" }}}
