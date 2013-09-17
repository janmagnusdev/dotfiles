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
let maplocalleader="ä"

" Fast editing of the .vimrc
nmap <leader>ev :e $MYVIMRC<CR>
nmap <leader>sv :source $MYVIMRC<CR>

""" Basic Settings & GUI
set encoding=utf-8
set t_Co=256
set background=dark
colorscheme rasta

if has('gui_running')
  set guioptions-=T  " Hide toolbar
  set guicursor+=a:blinkon0
  set guicursor+=i-ci:ver10-Cursor-blinkwait500-blinkoff500-blinkon500

  set columns=105

  if has('gui_macvim')
    set guifont=Menlo:h13
    set lines=56
    """ num cols for split view
    let num_cols=175

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
    """ num cols for split view
    let num_cols=211

    map <C-o> :tabnew
    map <C-t> :tabnew .<CR>
    map <C-w> :q<CR>

    " copy/paste
    vnoremap <special> <C-x> "+x
    vnoremap <special> <C-c> "+y
    cnoremap <special> <C-c> <C-y>
    nnoremap <special> <C-v> "+P
    inoremap <special> <C-v> <C-r>+
    cnoremap <special> <C-v> <C-r>+

  endif
endif

""" Interface
set title
set relativenumber
set cursorline
set wildmenu
set wildignore+=.git,.hg,__pycache__,*.pyc
set wildmode=list:longest,full
set clipboard=unnamed,unnamedplus  " Use system clipboard
set listchars=tab:▸\ ,trail:·,eol:¬,precedes:<,extends:>
set fillchars=vert:\│
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

""" Moving around / Editing
set textwidth=79
set colorcolumn=+1
set autoindent
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

" =============================================================================
" Shortcuts
" =============================================================================
set pastetoggle=<F2>  " Toggle paste mode

" jj to exit insert mode
imap jj <esc>

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

" Change behaviour of , and ; because its much more intuitive
noremap , ;
noremap ; ,

" Marks are very tedious to get to, so just change the command
noremap ' m
noremap m '

" The same is also true for makros
noremap q @
noremap @ q

" Y should have the same behaviour like D, but instead Y is the same as yy,
" fix this:
map Y y$

" Keep visual selection when indenting
vnoremap < <gv
vnoremap > >gv

" Use space for folding
nnoremap <Space> za

" Ctrl+Return inserts line break in normal mode
nnoremap <C-Return> i<CR><Esc>l

" open/close the quickfix window
nmap <leader>co :copen<CR>
nmap <leader>cc :cclose<CR>

" When pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<CR>

" Toggle spell check
nmap <leader>sp :set spell!<CR>

" Re-hardwrap paragraphs of text
nmap <leader>q gqip
vmap <leader>q gq

" Toggle wrap
nnoremap <leader>w :set wrap!<CR>

" Clear search term (remove highlighting)
nmap <silent> <leader><Space> :noh<CR>

" open/close the quickfix window
nmap <leader>co :copen<CR>
nmap <leader>cc :cclose<CR>

" Toggle displaying of whitespaces
nmap <silent> <leader>s :set nolist!<CR>

" Close buffer without closing its split window
nnoremap <leader>bd :bp\|bd #<CR>

" Create new vertical split and switch over to it
if has('gui_running')
  """ num_cols is defined above
  nnoremap <leader>v :let &columns=num_cols<CR><C-w>v<C-w>l
else
  nnoremap <leader>v <C-w>v>C-w>l
endif

" When I forgot to sudo before editing ...
cmap w!! w !sudo tee % >/dev/null

" Get the current highlight group. Useful for then remapping the color
map <leader>hi :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">" . " FG:" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"fg#")<CR>

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
nnoremap <silent> 0 :call SmartHome()<CR>

" Remove trailing spaces
function! TrimSpaces()
  " mk: set mark k for the current position, H: go to first on-screen line,
  " ml: set mark l for this position
  :norm 'kH'l
  " Actual stripping
  %s/\s\+$//e
  " jump to line l, set this line as first on-screen line, jump to line k
  :norm mlztmk
endfunction
au FileWritePre * :call TrimSpaces()
au FileAppendPre * :call TrimSpaces()
au FilterWritePre * :call TrimSpaces()
au BufWritePre * :call TrimSpaces()
nmap <leader>ts :call TrimSpaces()<CR>

" Toggle between number and relative number on ,l
nmap <leader>l :call ToggleRelativeAbsoluteNumber()<CR>
function! ToggleRelativeAbsoluteNumber()
  if &number
    set relativenumber
  else
    set number
  endif
endfunction

" Toggle line numbers and fold column for easy copying:
nmap <leader>nn :call ToggleNoNumber()<CR>
function! ToggleNoNumber()
  if &number
    set nonumber
  elseif &relativenumber
    set norelativenumber
  else
    set relativenumber
  endif
endfunction

" =============================================================================
" Plug-ins
" =============================================================================
" Hex Highlight
nmap <leader>hh :call HexHighlight()<CR>

" Lightline
let g:lightline = {
    \ 'colorscheme': 'Rasta',
    \ 'active': {
    \   'left': [['mode', 'paste'], ['readonly', 'relativepath', 'modified']],
    \   'right': [['percent'], ['lineinfo'],
    \             ['filetype', 'fileencoding', 'fileformat', 'indentation']]
    \ },
    \ 'inactive': {
    \   'left': [['readonly', 'relativepath', 'modified']],
    \   'right': [['percent'], ['lineinfo']]
    \ },
    \ 'component_function': {
    \   'indentation': 'LlIndentation',
    \ }
    \}

function! LlIndentation()
    let text = (&et ? 's' : 't').':'.&tabstop
    return winwidth('.') > 70 ? text : ''
endfunction

" Lycosa Explorer
nnoremap <silent> <leader>lf :LycosaFilesystemExplorer<CR>
nnoremap <silent> <leader>lr :LycosaFilesystemExplorerFromHere<CR>
nnoremap <silent> <leader>lb :LycosaBufferExplorer<CR>

" Python-mode
let g:pymode_doc = 0  " Use jedi for this

let g:pymode_run = 1
let g:pymode_run_key = '<leader>pr'

let g:pymode_lint = 0  " Use khuno for this

let g:pymode_rope = 1
let g:pymode_rope_vim_completion = 0
nmap <leader>rj :RopeGotoDefinition<CR>
nmap <leader>rr :RopeRename<CR>

let g:pymode_breakpoint = 1
let g:pymode_breakpoint_key = '<leader>b'

let g:pymode_syntax_print_as_function = 1

" Python jedi
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#popup_on_dot = 0
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = "<leader>d"
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"
let g:jedi#show_call_signatures = "1"

"Python khuno
let g:khuno_ignore=""
nmap <silent><leader>ks :Khuno show<CR>

" Python Pytest
nmap <silent> <leader>tf :Pytest file<CR>
nmap <silent> <leader>tc :Pytest class<CR>
nmap <silent> <leader>tm :Pytest method<CR>
nmap <silent> <leader>tn :Pytest next<CR>
nmap <silent> <leader>tp :Pytest previous<CR>
nmap <silent> <leader>te :Pytest error<CR>

" Rename (current buffer)
map <leader>mv :Rename

" Supertab
let g:SuperTabDefaultCompletionType = "context"

" TaskList
map <leader>tl <Plug>TaskList

" ReST headings
" = above and below for title
noremap <leader>ht yyPVr=yyjp
inoremap <leader>ht <esc>yyPVr=yyjpo<CR>
" # for parts
noremap <leader>hp yypVr#k
inoremap <leader>hp <esc>yypVr#o<CR>
" * for chapters
noremap <leader>hc yypVr*k
inoremap <leader>hc <esc>yypVr*o<CR>
" = for sections
noremap <leader>h1 yypVr=k
inoremap <leader>h1 <esc>yypVr=o<CR>
" - for subsections
noremap <leader>h2 yypVr-k
inoremap <leader>h2 <esc>yypVr-o<CR>
" ^ for subsubsections
noremap <leader>h3 yypVr^k
inoremap <leader>h3 <esc>yypVr^o<CR>
" " for paragraphs
noremap <leader>h4 yypVr"k
inoremap <leader>h4 <esc>yypVr"o<CR>

" =============================================================================
" Filetype Specific Settings
" =============================================================================
" Easy file-type switching
nnoremap <leader>Th :set ft=html<CR>
nnoremap <leader>Tm :set ft=markdown<CR>
nnoremap <leader>Tp :set ft=python<CR>
nnoremap <leader>Tr :set ft=rst<CR>
nnoremap <leader>Ts :set ft=sh<CR>

""" CSS
au BufEnter *.css_t set ft=css

""" Latex
au BufEnter *.tex set ft=tex
au FileType tex setl fo+=t  " Auto-wrap text using textwidth

""" Markdown
au BufEnter *.md set ft=markdown
au FileType markdown setl fo+=t  " Auto-wrap text using textwidth

""" Python
au FileType python setl fo+=c  " Auto-wrap comments using textwidth

""" Quickfix Window
au FileType qf setl nowrap

""" reStructuredText
au BufEnter *.txt set ft=rst
au FileType rst setl fo+=t  " Auto-wrap text using textwidth
