" =============================================================================
" Sections
" =============================================================================
"
" - General
"   - Basic Settings & GUI
"   - Interface
"   - Behavior
"   - Messages, Info, Status
"   - Moving Around / Editing
"   - Tabs & Indentation
"   - Searching
"   - Insert Completion
" - Shortcuts
" - Plug-ins
" - Filetype Specific Settings

" =============================================================================
" General
" =============================================================================
filetype off
call pathogen#infect()
syntax on
filetype plugin indent on

let mapleader=","

" Fast editing of the .vimrc
nmap <leader>ev :e $MYVIMRC<cr>
nmap <leader>sv :source $MYVIMRC<cr>

""" Basic Settings & GUI
set encoding=utf-8
set t_Co=256
colorscheme rasta
set mouse=a

if has('gui_running')
  set guioptions-=T  " Hide toolbar
  set guicursor+=a:blinkon0
  set guicursor+=i-ci:ver10-Cursor-blinkwait500-blinkoff500-blinkon500

  set columns=105

  if has('gui_macvim')
    set guifont=Menlo:h13
    set lines=55

    " Tab switching
    nmap <D-A-left> <C-PageUp>
    vmap <D-A-left> <C-PageUp>
    imap <D-A-left> <C-O><C-PageUp>
    nmap <D-A-right> <C-PageDown>
    vmap <D-A-right> <C-PageDown>
    imap <D-A-right> <C-O><C-PageDown>

  elseif has('gui_gtk2')
    set guifont=DejaVu\ Sans\ Mono\ 9,Monospace\ 9
    set lines=62
  endif
endif

""" Interface
set title
set relativenumber
set cursorline
set wildmenu
set wildignore+=.git,.hg,__pycache__,*.pyc
set wildmode=list:longest,full
set clipboard=unnamed  " Alias anonymous register to * (copy to clipboard)
set listchars=tab:▸\ ,trail:·,eol:¬,precedes:<,extends:>
set wrap
set linebreak
set scrolloff=3

""" Behavior
set autoread
set hidden
set nostartofline
set nobackup
set nomodeline
set noswapfile

""" Messages, Info, Status
set confirm                 " Y-N-C promt if closing with unsaved changes
set ruler                   " Show line and column number
set showcmd                 " Show command in the bottom right of the screen
set laststatus=2            " Always show statusbar
set statusline=             " Make a nice status line
set statusline+=%-3.3n                          " buffer number
set statusline+=%f                              " filename
set statusline+=%m%r%h%w                        " status flags
set statusline+=\[%{strlen(&ft)?&ft:'none'}]    " file type
set statusline+=%=                              " right align remainder
set statusline+=0x%-8B                          " character value
set statusline+=%-14(%l,%c%V%)                  " line, character
set statusline+=%<%P                            " file position

""" Moving around / Editing
set textwidth=79
set colorcolumn=73,80
set autoindent
set smartindent
set formatoptions=qrn1
set virtualedit=block
set backspace=indent,eol,start
set foldmethod=indent
set foldlevel=99

""" Tabs & Indentation
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set smarttab

""" Searching
set incsearch
set ignorecase
set smartcase
set hlsearch
set gdefault

""" Insert completion
set completeopt=longest,menu,preview
set pumheight=6             " Keep a small completion window

" =============================================================================
" Shortcuts
" =============================================================================
set pastetoggle=<F2>  " Toggle paste mode

" jj to exit insert mode
imap jj <esc>

map <C-o> :tabnew
map <C-t> :tabnew .<cr>
map <C-w> :q<cr>

" Ctrl-jklm to move between windows
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Let j/k work on screen lines
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Use space for folding
nnoremap <space> za

" Ctrl+Return inserts line break in normal mode
nnoremap <C-Return> i<cr><Esc>l

" When I forgot to sudo before editing ...
cmap w!! w !sudo tee % >/dev/null

" When pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>

" Toggle spell check
nmap <leader>sp :set spell!<cr>

" Re-hardwrap paragraphs of text
nmap <leader>q gqip
vmap <leader>q gq

" Clear search term (remove highlighting)
nmap <silent> <leader><space> :noh<cr>

" Toggle displaying of whitespaces
nmap <silent> <leader>s :set nolist!<cr>

" Create new vertical split and switch over to it
if has('gui_running')
    nnoremap <leader>v :set columns=200<cr><C-w>v<C-w>l
else
    nnoremap <leader>v <C-w>v>C-w>l
endif

" open/close the quickfix window
nmap <leader>c :copen<cr>
nmap <leader>cc :cclose<cr>

" SmartHome (vim tip 315)
function! SmartHome()
  let s:col = col(".")
  normal! ^
  if s:col == col(".")
    normal! 0
  endif
endfunction
nnoremap <silent> <Home> :call SmartHome()<cr>
inoremap <silent> <Home> <C-O>:call SmartHome()<cr>
nnoremap <silent> 0 :call SmartHome()<cr>

" Remove trailing spaces
function! TrimSpaces()
  %s/\s\+$//e
endfunction
au FileWritePre * :call TrimSpaces()
au FileAppendPre * :call TrimSpaces()
au FilterWritePre * :call TrimSpaces()
au BufWritePre * :call TrimSpaces()
nmap <leader>ts :call TrimSpaces()<cr>

" Toggle between number and relative number on ,l
nmap <leader>l :call ToggleRelativeAbsoluteNumber()<cr>
function! ToggleRelativeAbsoluteNumber()
  if &number
    set relativenumber
  else
    set number
  endif
endfunction

" Toggle line numbers and fold column for easy copying:
nmap <leader>nn :call ToggleNoNumber()<cr>
function! ToggleNoNumber()
  if &number
    set nonumber
  elseif &relativenumber
    set norelativenumber
  else
    set relativenumber
  endif
endfunction

" Make popup menu more usable
" inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
" inoremap <expr> <cr>       pumvisible() ? "\<C-y>" : "\<cr>"
" inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
" inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
" inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
" inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

" =============================================================================
" Plug-ins
" =============================================================================
" Hex Highlight
nmap <leader>hh :call HexHighlight()<cr>

" Lycosa Explorer
nnoremap <silent> <leader>lf :LycosaFilesystemExplorer<cr>
nnoremap <silent> <leader>lr :LycosaFilesystemExplorerFromHere<cr>
nnoremap <silent> <leader>lb :LycosaBufferExplorer<cr>

" Python-mode
let g:pymode_doc_key = '<leader>pd'
let g:pymode_run_key = '<leader>pr'
let g:pymode_breakpoint_key = '<leader>pb'

let g:pymode_lint = 0
let g:pymode_lint_hold = 1
let g:pymode_lint_onfly = 1
let g:pymode_lint_mccabe_complexity = 10
let g:pymode_options_other = 0

" Python Pytest
nmap <silent> <leader>tf :Pytest file<cr>
nmap <silent> <leader>tc :Pytest class<cr>
nmap <silent> <leader>tm :Pytest method<cr>
nmap <silent> <leader>tn :Pytest next<cr>
nmap <silent> <leader>tp :Pytest previous<cr>
nmap <silent> <leader>te :Pytest error<cr>

" Python Rope
map <leader>rj :RopeGotoDefinition<cr>
map <leader>rr :RopeRename<cr>
imap <c-tab> <C-R>=RopeCodeAssistInsertMode()<cr>
let ropevim_vim_completion=1    " Use vim's complete function in insert mode
let ropevim_extended_complete=1 " Show extended info about completion proposals
let ropevim_guess_project=1     " Guess and open rope project automatically

" Rename
map <leader>mv :Rename

" Supertab
let g:SuperTabDefaultCompletionType = "context"

" TaskList
map <leader>tl <Plug>TaskList

" ReST headings
" = above and below for title
noremap <leader>ht yyPVr=yyjp
inoremap <leader>ht <esc>yyPVr=yyjpo<cr>
" # for parts
noremap <leader>hp yypVr#k
inoremap <leader>hp <esc>yypVr#o<cr>
" * for chapters
noremap <leader>hc yypVr*k
inoremap <leader>hc <esc>yypVr*o<cr>
" = for sections
noremap <leader>h1 yypVr=k
inoremap <leader>h1 <esc>yypVr=o<cr>
" - for subsections
noremap <leader>h2 yypVr-k
inoremap <leader>h2 <esc>yypVr-o<cr>
" ^ for subsubsections
noremap <leader>h3 yypVr^k
inoremap <leader>h3 <esc>yypVr^o<cr>
" " for paragraphs
noremap <leader>h4 yypVr"k
inoremap <leader>h4 <esc>yypVr"o<cr>

" =============================================================================
" Filetype Specific Settings
" =============================================================================
" Easy file-type switching
nnoremap <leader>Th :set ft=html<cr>
nnoremap <leader>Tm :set ft=markdown<cr>
nnoremap <leader>Tp :set ft=python<cr>
nnoremap <leader>Tr :set ft=rst<cr>
nnoremap <leader>Ts :set ft=sh<cr>

""" VIM
au FileType vim setl sw=2 ts=2 sts=2 et

""" reStructuredText
au BufEnter *.txt set ft=rst
au FileType rst setl fo+=t  " Auto-wrap text using textwidth

""" Markdown
au BufEnter *.md set ft=markdown
au FileType markdown setl fo+=t  " Auto-wrap text using textwidth

""" Latex
au FileType tex setl fo+=t  " Auto-wrap text using textwidth

""" Python
au FileType python setl fo+=c  " Auto-wrap comments using textwidth
" let python_highlight_all=1
" Enable python completion
au FileType python set omnifunc=pythoncomplete#Complete
