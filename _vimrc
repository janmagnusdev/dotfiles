"
" =============================================================================
" Dependencies - Libraries/Applications outside of vim
" =============================================================================
"
" Pep8 - http://pypi.python.org/pypi/pep8
" Py.test
" Rake & Ruby for command-t
" nose, django-nose
"
"
" =============================================================================
" Installation & Updating
" =============================================================================
"
" Most plug-ins are not contained in this repository and have to be installed
" manually.
"
" Installation: ``update_vim.py clone`` clones all plugi-ins to *_vim/bundle/*
" Update: ``update_vim.py`` w/o args pulls changes for each plug-in
"
"
" =============================================================================
" Plug-ins
" =============================================================================
"
" Pathogen
"   Better management of VIM plug-ins
"
" Command-T
"   Easy opening of files within a given path. Inspired by TextMate.
"
" MW-Utils
"   Various utilities. Dependency of Snipmate.
"
" NERD tree
"   Tree-based filesystem browser.
"
" PEP8
"   Performes a PEP-8 compliance check.
"
" PyDoc
"   Shows the documentation for Python modules.
"
" PyFlakes
"   Highlights common errors in Python code on-the-fly.
"
" Pytest
"   Invokes py.test from within vim.
"
" Ropevim
"   Rope provides features like refactoring or jump-to-definition for Python
"   code.
"
" SearchComplete
"   Tab-completion for search terms.
"
" Snipmate
"   Configurable snippets that can be expanded via ``tab``. Inspired by
"   Textmate.
"
" Supertab
"   Contextual tab-completion.
"
" Surround
"   Deals with pairs of “surroundings” (e.g. braces or quotation marks).
"
" Tasklist
"   Searches a file for TODOs and FIXMEs.
"
" Tlib
"   Utility functions. Dependency of Snipmate.
"
" pathogen loads plugins from ~/.vim/bundle

" =============================================================================
" Pathogen
" =============================================================================
filetype off
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

" =============================================================================
" Basic Settings
" =============================================================================
syntax on                   " Enable syntax highlighting
filetype plugin indent on   " Detect filetyes and load filetype plug-ins
colorscheme blackboard

""" Interface
set title                   " Show title in console title bar
set mouse=a                 " Mouse interaction
set number                  " Show line numbers
set cursorline              " Highlight current line
set wildmenu                " Tab-completion for commands
" Ignore these files when completing
set wildignore+=.git,.hg,__pycache__,*.pyc
set clipboard=unnamed       " Alias anonymous register to * (copy to clipboard)

" Messages, Info, Status
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
set encoding=utf-8
set textwidth=79
set colorcolumn=80
set listchars=tab:>-,trail:·,eol:$,precedes:<,extends:>
set scrolloff=3
set autoindent
set smartindent

set shiftwidth=4
set tabstop=4
set expandtab
set smarttab

set foldmethod=indent
set foldlevel=99
set backspace=indent,eol,start

set incsearch               " Incremental search
set ignorecase              " Ignore case ...
set smartcase               " ... unless the term contains upper case letters
set hlsearch                " Highlight all results

""" Insert completion
set completeopt=menuone,longest,preview
set pumheight=6             " Keep a small completion window

" close preview window automatically when we move around
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" =============================================================================
" Shortcuts
" =============================================================================
let mapleader=","           " Use , as <leader>

" Ctrl-jklm to move between windows
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h
" and lets make these all work in insert mode too (<C-O> makes next cmd
" happen as if in command mode)
imap <C-W> <C-O><C-W>

" Use space for folding
nnoremap <space> za

" Select the item in the list with enter
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

map <leader>bl :buffers<CR>

" Toggle line numbers and fold column for easy copying:
nmap <leader>nn :set nonumber!<CR>

" Reset search term (remove highlighting)
nmap <silent> <leader>rs :let @/ = ""<CR>

" Toggle displaying of whitespaces
nmap <silent> <leader>s :set nolist!<CR>

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

" NERD Tree
map <leader>n :NERDTreeToggle<CR>

" Supertab
let g:SuperTabDefaultCompletionType = "context"

" PEP8
let g:pep8_map='<leader>8'

" Rope
map <leader>j :RopeGotoDefinition<CR>
map <leader>r :RopeRename<CR>
let ropevim_vim_completion=1
let ropevim_extended_complete=1

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
au FileType python set omnifunc=pythoncomplete#Complete

" Add the virtualenv’s site-packages to vim path
py << EOF
import os.path
import sys
import vim
if 'VIRTUALENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF
