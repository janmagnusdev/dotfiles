" =============================================================================
" Dependencies
"
" - Pep8 - http://pypi.python.org/pypi/pep8
" - Py.test
" - Rake & Ruby for command-t
"
"
" Installation & Updating
" =======================
"
" Most plug-ins are not contained in this repository and have to be installed
" manually.
"
" Installation: ``update_vim.py clone`` clones all plugi-ins to *_vim/bundle/*
" Update: ``update_vim.py`` w/o args pulls changes for each plug-in
"
"
" Sections
" ========
"
" - General
"   - Basic Settings & GUI
"   - Interface
"   - Messages, Info, Status
"   - Moving Around / Editing
"   - Tabs & Indentation
"   - Searching

" =============================================================================
" General
" =============================================================================
filetype off
call pathogen#infect()
syntax on
filetype plugin indent on

" Set to auto read when a file is changed from the outside
set autoread

let mapleader=","

" Fast editing of the .vimrc
map <leader>v :tabnew ~/.vimrc<cr>

" When vimrc is edited, reload it
autocmd! bufwritepost _vimrc source ~/.vimrc
autocmd! bufwritepost .vimrc source ~/.vimrc


""" Basic Settings & GUI
set encoding=utf-8
set spl=en_us spell
set t_Co=256
colorscheme grayboard

if has('gui_running')
    set guioptions-=T  " Hide toolbar
    set guicursor+=a:blinkon0
    set guicursor+=i-ci:ver10-Cursor-blinkwait500-blinkoff500-blinkon500

    if has('gui_macvim')
        set guifont=Menlo:h13
        set columns=105
        set lines=55
    elseif has('gui_gtk2')
        set guifont=Monospace\ 9
        set columns=105
        set lines=62
    endif
endif

""" Interface
set title
set relativenumber
set cursorline
set wildmenu
set wildignore+=.git,.hg,__pycache__,*.pyc
set clipboard=unnamed  " Alias anonymous register to * (copy to clipboard)
set listchars=tab:▸\ ,trail:·,eol:¬,precedes:<,extends:>
set mouse=a

""" Messages, Info, Status
set hidden
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
set colorcolumn=+1
set autoindent
set smartindent
set formatoptions=qrn1
set scrolloff=3
set backspace=indent,eol,start

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

set foldmethod=indent  " ?
set foldlevel=99  " ?

""" Insert completion
set completeopt=menuone,longest,preview  " ?
set pumheight=6             " Keep a small completion window

" close preview window automatically when we move around
" autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
" autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" =============================================================================
" Shortcuts
" =============================================================================
map <C-o> :tabnew
map <C-t> :tabnew .<CR>
map <C-w> :q<CR>

" Use space for folding
nnoremap <space> za

" Clear search term (remove highlighting)
nnoremap <silent> <leader><space> :noh<cr>

map <leader>bl :buffers<CR>

" Re-hardwrap paragraphs of text
nnoremap <leader>q gqip

" Toggle line numbers and fold column for easy copying:
nmap <leader>nn :set norelativenumber!<CR>

" Toggle displaying of whitespaces
nmap <silent> <leader>s :set nolist!<CR>

" Create new vertical split and switch over to it
nnoremap <leader>w <C-w>v<C-w>l

" Ctrl-jklm to move between windows
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" and lets make these all work in insert mode too (<C-O> makes next cmd
" happen as if in command mode)
imap <C-W> <C-O><C-W>

" Select the item in the list with enter
function! CheckClosePum()
    if pumvisible()
        return "\<C-y>"
    else
        return "\<CR>"
endfunction
inoremap <expr> <CR> CheckClosePum()

" open/close the quickfix window
nmap <leader>c :copen<CR>
nmap <leader>cc :cclose<CR>

" SmartHome (vim tip 315)
function! SmartHome()
    let s:col = col(".")
    normal! ^
    if s:col == col(".")
        normal! 0
    endif
endfunction
nnoremap <silent> <Home> :call SmartHome()<CR>
inoremap <silent> <Home> <C-O>:call SmartHome()<CR>

" Remove trailing spaces
function! TrimSpaces()
    %s/\s\+$//e
endfunction
au FileWritePre * :call TrimSpaces()
au FileAppendPre * :call TrimSpaces()
au FilterWritePre * :call TrimSpaces()
au BufWritePre * :call TrimSpaces()
nmap <leader>ts :call TrimSpaces()<CR>

" =============================================================================
" Plug-ins
" =============================================================================
" TaskList
map <leader>td <Plug>TaskList

" Rename
map <leader>mv :Rename

" NERD Tree
map <leader>n :NERDTreeToggle<CR>

" Supertab
let g:SuperTabDefaultCompletionType = "context"

" PEP8
let g:pep8_map='<leader>8'

" Rope
map <leader>j :RopeGotoDefinition<CR>
map <leader>r :RopeRename<CR>
let ropevim_vim_completion=1    " Use vim's complete function in insert mode
let ropevim_extended_complete=1 " Show extended info about completion proposals
let ropevim_guess_project=1     " Guess and open rope project automatically

" Py.test
nmap <silent><Leader>tf <Esc>:Pytest file<CR>
nmap <silent><Leader>tc <Esc>:Pytest class<CR>
nmap <silent><Leader>tm <Esc>:Pytest method<CR>
nmap <silent><Leader>tn <Esc>:Pytest next<CR>
nmap <silent><Leader>tp <Esc>:Pytest previous<CR>
nmap <silent><Leader>te <Esc>:Pytest error<CR>

" =============================================================================
" Filetype Specific Settings
" =============================================================================
""" reStructuredText
au BufEnter *.txt set filetype=rst

""" Python
let python_highlight_all=1
" Activate rope completion via <tab>
au FileType python imap <buffer> <C-Space> <M-/>
" Enable python completion
au FileType python set omnifunc=pythoncomplete#Complete

" Add the virtualenv’s site-packages to vim path
py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF
