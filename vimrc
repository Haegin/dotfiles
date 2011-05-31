""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filename:     .vimrc
" Description:  Custom vim (and gvim) configuration)
" Author:       Harry Mills
" Coauthor:     Nick Pope, Dave Ingram
" Last Updated: Sun Aug 24 20:59:43 BST 2008
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible                " do not use compatibility mode (must be 1st)
set backspace=indent,eol,start  " configure backspace behaviour
set cmdheight=1                 " Commandbar height is 1
set foldlevel=9999              " Expand folds by default
set history=500                 " How many lines of history to remember
set ignorecase                  " Ignore case when searching
set smartcase                   " If you include a capital in a search it becomes case sensitive
set incsearch                   " Incremental search
set showmatch                   " Show matching brackets
set hlsearch                    " Highlight search
set linebreak                   " Break at word boundaries
set magic                       " Allow magic characters in searches or replaces
set mat=2                       " Matching parens should blink for 2/10 sec
set mouse=a                     " Always use mouse
set noerrorbells                " Quiet on errors
set number                      " Do number lines
set novisualbell                " No visual flash
set ruler                       " Show ruler
set shortmess+=I                " No welcome message
set showcmd                     " Show partial command in statusbar
set vb t_vb=                       " No visual flash (termcap)
set tabstop=4                   " Tabstop = 4 chars
set shiftwidth=4                " Tabstop = 4 chars (autoindenting)
set softtabstop=4               " Width of spaces that vim uses as a tab
set smarttab                    " Uses shiftwidth to determine amount to tab by at start of line
set autoindent                  " Automatic indenting
set smartindent                 " Indents more after certain lines (see :help smartindent)
set expandtab                   " Expand tabs to spaces
set textwidth=0                 " Text width = 0 == no autowrapping of text
set wildmenu                    " Wildcard menu
set winminheight=0              " No minimum window height
set guioptions=aegic            " enable autoselect, tabs, grey menu items,
set list
set listchars=tab:▸\ ,eol:↵
"set relativenumber             " number lines relative to the current line
"position - needs vim 7.3
"set undofile                   " creates an undo file so you can undo over
"changes

" Use , instead of \ as the leader key
let mapleader = ","

" Use PCREs instead of the vim default
nnoremap / /\v
vnoremap / /\v

" Make j and k go up and down by screen line, not file line!
nnoremap j gj
nnoremap k gk
nnoremap ; :

"" Leader customisation

" clear all trailing whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" open a new vsplit and switch to it
nnoremap <leader>w <C-w>v<C-w>l

" retab
nnoremap <leader>r :retab<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OS-Specific Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('win32') || has('win64')
    " Windows-specific options
    set guifont=Courier\ New:h10 " set a respectable looking font
    set shellslash               " required for latex-suite
else " Assume Linux-specific options
    " grep sometimes doesn't display file names when searching a single file,
    " which confuses latex-suite, so let's fix that:
    set grepprg=grep\ -nH\ $*
    set shell=zsh
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colour scheme
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('gui_running')
    colorscheme inkpot
    set guifont=Terminus\ 10
else
    colorscheme inkpot
endif
set background=dark

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filetype settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype indent plugin on   " Indent files please, with omnicompletion
syntax on
" file formats
map <silent> <leader>fd :set fileformat=dos<cr>:w<cr>
map <silent> <leader>fm :set fileformat=mac<cr>:w<cr>
map <silent> <leader>fu :set fileformat=unix<cr>:w<cr>

" Python settings
let python_highlight_space_errors = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Spell checking
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let spell_executable="aspell"
let spell_root_menu="-"
let spell_insert_mode=0
let spell_auto_type=''
highlight SpellErrors ctermfg=Red
map <silent> <F10> :setlocal spell! spelllang=en_gb<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Highlight space at end of line as error
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
highlight WhitespaceEOL ctermbg=DarkRed guibg=Red
match WhitespaceEOL /\s\+$/

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Completion Stuff
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set cpt=k,.,w,b,u,t,i

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Editing vimrc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('win32') || has('win64')
  " Fast reload of vimrc
  map <silent> <leader>vs :source ~/_vimrc<cr>
  " Fast editing of vimrc
  map <silent> <leader>ve :sp ~/_vimrc<cr>
  " When vimrc is edited, reload it
  autocmd! bufwritepost _vimrc source ~/_vimrc
else
  " Fast reload of vimrc
  map <silent> <leader>vs :source ~/.vimrc<cr>
  " Fast editing of vimrc
  map <silent> <leader>ve :sp ~/.vimrc<cr>
  " When vimrc is edited, reload it
  autocmd! bufwritepost .vimrc source ~/.vimrc
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim Sessions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ignore 'options' because of latex-suite (would be pointless to save that!)
set sessionoptions=blank,curdir,folds,help,resize,tabpages,winsize
if has('win32') || has('win64')
  set sessionoptions+=slash,unix
  map <leader>ss :mksession! ~/_vimsession<cr>
  map <leader>sr :source ~/_vimsession<cr>
else
  map <leader>ss :mksession! ~/.vim/.session<cr>
  map <leader>sr :source ~/.vim/.session<cr>
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Functions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
func! DeleteTrailingWS()
  norm mz
  %s/\s\+$//ge
  norm `z
endfunc

map <silent> <leader>ds :call DeleteTrailingWS()<cr>

map <F4> :let &lines=&lines-1
map <S-F4> :let &lines=&lines+1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocommands
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup deltrailws
  " Remove existing commands in group if defined
  autocmd!
  autocmd BufWrite *.[chC]          :call DeleteTrailingWS()
  autocmd BufWrite *.{cc,hh}        :call DeleteTrailingWS()
  autocmd BufWrite *.[ch]{xx,pp,++} :call DeleteTrailingWS()
  autocmd BufWrite *.{pl,php,java}  :call DeleteTrailingWS()
  autocmd BufWrite *.txt            :call DeleteTrailingWS()
  autocmd BufWrite *.{cls,sty,tex}  :call DeleteTrailingWS()
augroup end
augroup fixfiletype
  autocmd!
  autocmd BufNewFile,BufRead *.thtml            :set filetype=php
  autocmd BufRead            /var/log/messages* :set filetype=messages
augroup end
augroup qmv
  autocmd!
  autocmd BufRead /tmp/qmv* :set ts=8
augroup end

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Keybindings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
imap <C-space> <C-x><C-o>
map tt :NERDTreeToggle<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:treeExplVertical = 1
let g:treeExplDirSort = 1
let g:treeExplWinSize = 33
let NERDTreeShowBookmarks = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use syntax-hl for omni-completion
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("autocmd") && exists("+omnifunc")
    autocmd Filetype *
        \   if &omnifunc == "" |
        \       setlocal omnifunc=syntaxcomplete#Complete |
        \   endif
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Subversion helper
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if !(has('win32') || has('win64'))
  map <F8> :new<CR>:read !svn diff<CR>:set syntax=diff buftype=nofile<CR>gg
endif

"*****************************************************************************
" HTML Formatting Commands
"*****************************************************************************
" strip tags
map <silent> <leader>h! mz:%s#<\_.\{-}>##g<cr>:%s#&nbsp;# #g<cr>`z

"*****************************************************************************
" HTML Output Options
"*****************************************************************************
" use CSS
let html_use_css = 1
" use XHTML
let use_xhtml = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Formatting/movement commands
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" format current paragraph and keep cursor in current position
noremap <silent> Q mzgqap`z
" copy to end of line
noremap Y y$
" remove search highlight
map <silent> <leader>hh :let @/=''<cr>

" Use tab to move between matching brackets
nnoremap <tab> %
vnoremap <tab> %


"*****************************************************************************
" Automatic Java Commands - TODO: move to ftplugin
"*****************************************************************************
" Functions
function! JavaFold()
  syn region fold_braces start=/{/ end=/}/ transparent fold keepend extend
  syn region fold_javadoc start=+/\*\*+ end=+\*/+ transparent fold keepend extend
  syn match  fold_imports /\n\%(import[^;]\+;\n\)\+/ transparent fold
  function! JavaFoldText()
    let header = substitute(getline(v:foldstart), '{.*', '{...}', '')
    return matchstr(foldtext(), '^[^:]*') . ': ' . header
  endfunction
  setl foldlevelstart=1
  setl foldmethod=syntax
  setl foldtext=JavaFoldText()
endfunction

" Autocommand group
augroup java_au
  au!
  " folding
  au FileType java call JavaFold()
  au FileType java setl fen
  " macros
  au FileType java inoremap <buffer> <C-t> System.out.println();<esc>hi
  " abbreviations
  au FileType java inoremap <buffer> $b boolean
  au FileType java inoremap <buffer> $i import
  au FileType java inoremap <buffer> $pa private
  au FileType java inoremap <buffer> $pr private
  au FileType java inoremap <buffer> $pu public
  au FileType java inoremap <buffer> $r return
  au FileType java inoremap <buffer> $s String
  au FileType java inoremap <buffer> $v void
augroup end

" More useful Java stuff
autocmd BufRead *.java set makeprg=ant\ -f\ /home/demian/code/jim/build.xml
autocmd BufRead *.java set efm=%A\ %#[javac]\ %f:%l:\ %m,%-Z\ %#[javac]\ %p^,%-C%.%#

autocmd BufRead *.java set include=^#\s*import
autocmd BufRead *.java set includeexpr=substitute(v:fname,'\\.','/','g')

map gf <C-W>f
map gc gbb<C-W>f

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Automatic JavaScript Commands - TODO: move to ftplugin
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! JavaScriptFold()
  syn region fold_braces start=/{/ end=/}/ transparent fold keepend extend
  function! JavascriptFoldText()
    return substitute(getline(v:foldstart), '{.*', '{...}', '')
  endfunction
  setl foldlevelstart=1
  setl foldmethod=syntax
  setl foldtext=JavascriptFoldText()
endfunction

augroup javascript_au
  au!
  " folding
  au FileType javascript call JavaScriptFold()
  au FileType javascript setl fen
  " macros
  au FileType javascript imap <c-t> console.log();<esc>hi
  au FileType javascript imap <c-a> alert();<esc>hi
  " abbreviations
  au FileType javascript inoremap <buffer> $c /**<cr><space><cr>**/<esc>ka
  au FileType javascript inoremap <buffer> $d //<cr>//<cr>//<esc>ka<space>
  au FileType javascript inoremap <buffer> $r return
  " options
  au FileType javascript setl nocindent
augroup end

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Abbreviations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
iab xdate <c-r>=strftime("%Y-%m-%d")<cr>
iab xtime <c-r>=strftime("%H:%M:%S")<cr>
iab xdatetime <c-r>=strftime("%Y-%m-%d %H:%M:%S")<cr>
iab xlongdate <c-r>=strftime('%A, %e %B %Y')<cr>
iab xname Harry Mills
iab xemail harry@haeg.in
iab xcorp University of York
iab xdept Department of Computer Science

