" Preamble ---------------------------------------------------------------- {{{

filetype off
call pathogen#infect()
filetype plugin indent on
set nocompatible
" }}}
" Basic options ----------------------------------------------------------- {{{

""" Interface
set title
set relativenumber
set cursorline
set wildmenu
set wildignore+=.git,.hg,__pycache__,*.pyc
set wildmode=list:longest,full
set clipboard=unnamed,unnamedplus  " Use system clipboard
set listchars=tab:▸\ ,trail:·,nbsp:~,eol:¬,precedes:❮,extends:❯
set showbreak=↪
set fillchars=diff:⣿,vert:│
set wrap
set linebreak
set scrolloff=3
set sidescroll=1
set sidescrolloff=10
set ttyfast

""" Behavior
set autoread
set hidden
set nostartofline
set nobackup
set nomodeline
set noswapfile
set history=1000
set splitbelow
set splitright
au VimResized * :wincmd =  " Resize splits when the window is resized

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
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set smarttab
set shiftround

""" Moving around / Editing
set encoding=utf-8
set textwidth=79
set colorcolumn=+1
set autoindent
set formatoptions=qrn1j
set virtualedit+=block
set backspace=indent,eol,start
" set foldlevelstart=99  " Start with all folds open
set foldlevelstart=0  " Start with all folds open

""" Searching
set incsearch
set ignorecase
set smartcase
set hlsearch
set gdefault

""" Leader
let mapleader=","
let maplocalleader="ä"

" TODO: keep?
" cpoptions+=J, dammit {{{

" Something occasionally removes this.  If I manage to find it I'm going to
" comment out the line and replace all its characters with 'FUCK'.
augroup twospace
    au!
    au BufRead * :set cpoptions+=J
augroup END

" }}}
" Line Return {{{

" Return to the same line when you reopen a file.
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

" }}}
" Color scheme {{{

syntax on
set background=dark
set synmaxcol=800  " Don't try to highlight lines longer than 800 characters.
colorscheme rasta

" Reload the colorscheme whenever we write the file.
augroup color_badwolf_dev
    au!
    au BufWritePost rasta.vim color rasta
augroup END

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" }}}
" GUI {{{

if has('gui_running')
  set guioptions-=T  " Hide toolbar
  set guicursor+=a:blinkon0
  set guicursor+=i-ci:ver10-Cursor-blinkwait500-blinkoff500-blinkon500

  if has('gui_macvim')
    set guifont=Menlo:h13

    " Tab switching
    nmap <C-Tab> <C-PageDown>
    vmap <C-Tab> <C-PageDown>
    imap <C-Tab> <C-O><C-PageDown>
    nmap <C-S-Tab> <C-PageUp>
    vmap <C-S-Tab> <C-PageUp>
    imap <C-S-Tab> <C-O><C-PageUp>

  elseif has('gui_gtk2')
    set guifont=DejaVu\ Sans\ Mono\ 9,Monospace\ 9

    map <C-o> :tabnew
    map <C-t> :tabnew .<cr>
    map <C-w> :q<cr>

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

" Fast editing of the .vimrc
nmap <leader>ev :e $MYVIMRC<cr>
nmap <leader>sv :source $MYVIMRC<cr>

" Set filetype to "mail" (for composing emails)
nnoremap <leader>Tm :set ft=mail<cr>

" Toggle paste mode
set pastetoggle=<F2>

" jj to exit insert mode
imap jj <esc>

" Swap q and @ for macros, because q is easier to type on German keyboards
noremap q @
noremap @ q

" Make Y behave like D (instead Y is the same as yy), fix this:
map Y y$

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

" Join an entire paragraph.
nnoremap <leader>J mzvipJ`z

" Split line (sister to [J]oin lines)
" The normal use of S is covered by cc, so don't worry about shadowing it.
" TrimSpaces() is defined in the mini-plugins section.
nnoremap S i<cr><Esc>:call TrimSpaces(1)<cr>

" Re-hardwrap paragraphs of text
nmap <leader>q gqip
vmap <leader>q gq

" Keep visual selection when indenting
vnoremap < <gv
vnoremap > >gv

" Easier linewise reselection of what you just pasted.
nnoremap <leader>V V`]

" When I forgot to sudo before editing ...
cnoremap w!! w !sudo tee % >/dev/null

" Unfuck my screen
nnoremap U :syntax sync fromstart<cr>:redraw!<cr>

" When pressing <leader>cd switch to the directory of the open buffer
nmap <leader>cd :cd %:p:h<cr>

" open/close the quickfix window
nmap <leader>co :copen<cr>
nmap <leader>cc :cclose<cr>

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
inoremap <C-u> <esc>mzgUiw`za

" Insert Mode Completion
inoremap <c-f> <c-x><c-f>
inoremap <c-]> <c-x><c-]>
inoremap <c-l> <c-x><c-l>

" Searching and movement {{{

" , is my leader, but ö/Ö are unused
noremap ö ;
noremap Ö ,

" ` for jumping to a mark does not work well on German keyboards
noremap ü `

" Clear search term (remove highlighting)
noremap <silent> <leader><Space> :noh<cr>

" Don't move on *
" I'd use a function for this but Vim clobbers the last search when you're in
" a function so fuck it, practicality beats purity.
nnoremap <silent> * :let stay_star_view = winsaveview()<cr>*:call winrestview(stay_star_view)<cr>

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" Same when jumping around
nnoremap g; g;zz
nnoremap g, g,zz
nnoremap <c-o> <c-o>zz

" Heresy (emacs movement to start/end of line while editing)
inoremap <c-a> <esc>I
inoremap <c-e> <esc>A
cnoremap <c-a> <home>
cnoremap <c-e> <end>

" gi already moves to "last place you exited insert mode", so we'll map gI to
" something similar: move to last change
nnoremap gI `.

" Let j/k work on screen lines, and gj/gk on actual lines
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" Ctrl-jklm to move between windows
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Create vertical split
noremap <leader>v <C-w>v

" }}}
" Toggles {{{

" Toggle line numbers
nnoremap <leader>nn :setlocal relativenumber!<cr>

" Toggle displaying of whitespaces
nmap <leader>s :set list!<cr>

" Toggle spell check
nmap <leader>sp :set spell!<cr>

" Toggle wrap
nnoremap <leader>w :set wrap!<cr>

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
    au!
    au FileType c setl foldmethod=marker foldmarker={,}
augroup END

" }}}
" CSS and SASS {{{

augroup ft_css
    au!
    au Filetype css setl foldmethod=marker foldmarker={,}
    au Filetype sass setl foldmethod=indent
augroup END

" }}}
" Java {{{

augroup ft_java
    au!
    au FileType java setl foldmethod=marker foldmarker={,}
augroup END

" }}}
" Javascript {{{

augroup ft_javascript
    au!
    au FileType javascript setl foldmethod=marker foldmarker={,}
augroup END

" }}}
" Mail {{{

augroup ft_mail
    au!
    au Filetype mail setlocal spell tw=72 fo+=t  " Auto-wrap text using tw
augroup END

" }}}
" Markdown {{{

augroup ft_markdown
    au!

    au BufEnter *.md set ft=markdown
    au FileType markdown setl fo+=t  " Auto-wrap text using textwidth

    " Use <localleader>1/2/3/4 to add headings.
    au Filetype markdown nnoremap <buffer> <localleader>1 "zyy"zpVr=k
    au Filetype markdown nnoremap <buffer> <localleader>2 "zyy"zpVr-k
    au Filetype markdown nnoremap <buffer> <localleader>3 mzI###<space><esc>`zllll
    au Filetype markdown nnoremap <buffer> <localleader>4 mzI####<space><esc>`zlllll

augroup END

" }}}
" Mercurial {{{

augroup ft_mercurial
    au!
    au BufNewFile,BufRead *hg-editor-*.txt setl filetype=hgcommit
augroup END

" }}}
" Nginx {{{

augroup ft_nginx
    au!
    au FileType nginx setl foldmethod=marker foldmarker={,}
augroup END

" }}}
" Python {{{

augroup ft_python
    au!
    au FileType python setl fo+=c  " Auto-wrap comments using textwidth
augroup END

" }}}
" QuickFix {{{

augroup ft_quickfix
    au!
    au FileType qf setl nowrap
augroup END

" }}}
" ReStructuredText {{{

augroup ft_rest
    au!

    au BufEnter *.txt set ft=rst
    au FileType rst setl fo+=t sw=3 ts=3 sts=3  " Auto-wrap text using tw

    " Title, parts, chapters and sections 1/2/3/4
    au Filetype rst nnoremap <buffer> <localleader>t "zyy"zPVr="zyyj"zp
    au Filetype rst nnoremap <buffer> <localleader>p "zyy"zpVr#k
    au Filetype rst nnoremap <buffer> <localleader>c "zyy"zpVr*k
    au Filetype rst nnoremap <buffer> <localleader>1 "zyy"zpVr=k
    au Filetype rst nnoremap <buffer> <localleader>2 "zyy"zpVr-k
    au Filetype rst nnoremap <buffer> <localleader>3 "zyy"zpVr^k
    au Filetype rst nnoremap <buffer> <localleader>4 "zyy"zpVr"k

augroup END

" }}}
" Vim {{{

augroup ft_vim
    au!
    au FileType vim setlocal foldmethod=marker
    au FileType help setlocal textwidth=78
augroup END

" }}}

" }}}
" Plugin settings --------------------------------------------------------- {{{
" Hex Highlight {{{

nmap <leader>hh :call HexHighlight()<cr>

" }}}
" Lightline {{{

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

}}}
" Lycosa Explorer {{{

nnoremap <silent> <leader>lf :LycosaFilesystemExplorer<cr>
nnoremap <silent> <leader>lr :LycosaFilesystemExplorerFromHere<cr>
nnoremap <silent> <leader>lb :LycosaBufferExplorer<cr>

" }}}
" Python-mode {{{

let g:pymode_breakpoint = 1
let g:pymode_breakpoint_key = '<leader>b'
let g:pymode_doc = 0  " Use jedi for this
let g:pymode_lint = 0  " Use khuno for this
let g:pymode_rope = 0  " Use jedi for this
let g:pymode_run = 1
let g:pymode_run_key = '<leader>pr'
let g:pymode_syntax_print_as_function = 1

" }}}
" Python jedi {{{

let g:jedi#use_tabs_not_buffers = 0
let g:jedi#popup_on_dot = 0
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = "<leader>d"
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"
let g:jedi#show_call_signatures = "1"

" }}}
" Python khuno {{{

let g:khuno_ignore=""
nmap <silent><leader>ks :Khuno show<cr>

" }}}
" Supertab {{{

let g:SuperTabDefaultCompletionType = "context"

" }}}
" TaskList {{{

map <leader>tl <Plug>TaskList

" }}}
" }}}
" Mini-plugins ------------------------------------------------------------ {{{
" Stuff that should probably be broken out into plugins, but hasn't proved to
" be worth the time to do so just yet.

" Synstack {{{

" Show the stack of syntax hilighting classes affecting whatever is under the
" cursor.
function! SynStack()
  echo join(map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")'), " > ")
endfunc

nnoremap <leader>hi :call SynStack()<cr>

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

nnoremap <silent> <leader>1 :call HiInterestingWord(1)<cr>
nnoremap <silent> <leader>2 :call HiInterestingWord(2)<cr>
nnoremap <silent> <leader>3 :call HiInterestingWord(3)<cr>
nnoremap <silent> <leader>4 :call HiInterestingWord(4)<cr>
nnoremap <silent> <leader>5 :call HiInterestingWord(5)<cr>
nnoremap <silent> <leader>6 :call HiInterestingWord(6)<cr>

" }}}
" Default Highlights {{{

hi def InterestingWord1 guifg=#000000 ctermfg=16 guibg=#ffa724 ctermbg=214
hi def InterestingWord2 guifg=#000000 ctermfg=16 guibg=#aeee00 ctermbg=154
hi def InterestingWord3 guifg=#000000 ctermfg=16 guibg=#8cffba ctermbg=121
hi def InterestingWord4 guifg=#000000 ctermfg=16 guibg=#b88853 ctermbg=137
hi def InterestingWord5 guifg=#000000 ctermfg=16 guibg=#ff9eb8 ctermbg=211
hi def InterestingWord6 guifg=#000000 ctermfg=16 guibg=#ff2c4b ctermbg=195

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
    let @/=l:_s
    nohl
    call winrestview(l:state)
endfunction
au FileWritePre * :call TrimSpaces(0)
au FileAppendPre * :call TrimSpaces(0)
au FilterWritePre * :call TrimSpaces(0)
au BufWritePre * :call TrimSpaces(0)
nmap <leader>ts :call TrimSpaces(0)<cr>

" }}}
" SmartHome (vim tip 315) {{{

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

" }}}
" }}}
