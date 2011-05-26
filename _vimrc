" pathogen loads plugins from ~/.vim/bundles
filetype off
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

syntax on
filetype plugin indent on

set t_Co=256  " Use 256 colors
colorscheme blackboard
let python_highlight_all=1
set mouse=a  " Mouse interaction
set cursorline  " Highlight current line

" Alias anonymous register to * (copy to clipboard)
set clipboard=unnamed

set encoding=utf-8
set textwidth=79
set colorcolumn=80

set autoindent
set smartindent

set shiftwidth=4
set tabstop=4
set expandtab
set smarttab

set foldmethod=indent
set foldlevel=99
set backspace=indent,eol,start

" Status line
set laststatus=2
set statusline=
set statusline+=%-3.3n                          " buffer number
set statusline+=%f                              " filename
set statusline+=%m%r%h%w                        " status flags
set statusline+=\[%{strlen(&ft)?&ft:'none'}]    " file type
set statusline+=%=                              " right align remainder
set statusline+=0x%-8B                          " character value
set statusline+=%-14(%l,%c%V%)                  " line, character
set statusline+=%<%P                            " file position

set number
set ruler
set showcmd

" Incremental search with smart case detection and highlighting
set incsearch
set ignorecase
set smartcase
set hlsearch

" Show autocomplete menus
set wildmenu

" Filetypes
au BufEnter *.txt set filetype=rst

let mapleader=","
map <leader>bl :buffers<CR>

" Toggle line numbers and fold column for easy copying:
nmap <leader>nn :set nonumber!<CR>

" Reset search term (remove highlighting)
nmap <leader>rs :let @/ = ""<CR>

" Toggle displaying of whitespaces
set listchars=tab:>-,trail:·,eol:$
nmap <silent> <leader>s :set nolist!<CR>

" Use space for folding
nnoremap <space> za

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

" Open tasklist with t
map <leader>td <Plug>TaskList

" PEP8
let g:pep8_map='<leader>8'

" Supertab
au FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"
set completeopt=menuone,longest,preview

" NERD Tree
map <leader>n :NERDTreeToggle<CR>

" Rope
map <leader>j :RopeGotoDefinition<CR>
map <leader>r :RopeRename<CR>
let ropevim_vim_completion=1
let ropevim_extended_complete=1

" Execute the tests
nmap <silent><Leader>tf <Esc>:Pytest file<CR>
nmap <silent><Leader>tc <Esc>:Pytest class<CR>
nmap <silent><Leader>tm <Esc>:Pytest method<CR>
" cycle through test errors
nmap <silent><Leader>tn <Esc>:Pytest next<CR>
nmap <silent><Leader>tp <Esc>:Pytest previous<CR>
nmap <silent><Leader>te <Esc>:Pytest error<CR>
