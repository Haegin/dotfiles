""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filename:     .vimrc
" Description:  Custom vim (and gvim) configuration)
" Author:       Harry Mills
" Coauthor:     Nick Pope, Dave Ingram
" Last Updated: Sun Aug 24 20:59:43 BST 2008
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pathogen - this must be run before colorschemes and other plugins are loaded
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"call pathogen#runtime_append_all_bundles()
"call pathogen#helptags()
call pathogen#infect()

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
set expandtab                   " Expand tabs to spaces
set autoindent                  " Automatic indenting
set smartindent                 " Indents more after certain lines (see :help smartindent)
set textwidth=0                 " Text width = 0 == no autowrapping of text
set wildmenu                    " Wildcard menu
set winminheight=0              " No minimum window height
set guioptions=aegic            " enable autoselect, tabs, grey menu items,
set list
set listchars=tab:▸\ ,eol:↵
"set relativenumber              " number lines relative to the current line (NOTE: slows down scrolling)
set lbr                         " needed for wrapping (NOTE: this doesn't work with list)
"position - needs vim 7.3

" From http://stevelosh.com/blog/2010/09/coming-home-to-vim/
set encoding=utf-8
set scrolloff=3
set showmode
set hidden
set wildmenu
set wildmode=list:longest
set ttyfast
set undofile                   " creates an undo file so you can undo over changes

set wrap
set textwidth=79
set colorcolumn=100
set formatoptions=qrn1l        " see fo-table in help for details

" Forcing me to be a better vimmer
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Save everything when focus is lost
" au FocusLost * :wa " this complains on files that are read only, untitled etc.
au FocusLost * silent! wa " this doesn't complain but you risk forgetting

" Move around split windows with Ctrl+[hjkl]
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Status line
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set laststatus=2        " Turn the status line on

set statusline=%t       "tail of the filename
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}] "file format
set statusline+=%h      "help file flag
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag
set statusline+=%y      "filetype
set statusline+=%{fugitive#statusline()} " git branch
set statusline+=%=      "left/right separator
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file

set statusline=[%n]\ %<%.99f\ %h%w%m%r%{exists('*CapsLockStatusline')?CapsLockStatusline():''}%y%=%-16(\ %l,%c-%v\ %)%P

" Powerline
" if has('gui_running')
"     let g:Powerline_symbols = 'fancy'
" endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Leader stuff
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use , instead of \ as the leader key
let mapleader = ","
" Which means we should use \ instead of , for backwards f search
noremap \ ,

" Use PCREs instead of the vim default
nnoremap / /\v
vnoremap / /\v

" Make j and k go up and down by screen line, not file line!
nnoremap j gj
nnoremap k gk
nnoremap ; :

"" Leader customisation

" clear all trailing whitespace
nnoremap <leader>W :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" fold tags with ,ft in html
nnoremap <leader>ft Vatzf

" sort CSS properties
nnoremap <leader>S ?{<CR>jV/^\s*\}?$<CR>k:sort<CR>:noh<CR>

" reselect pasted text
nnoremap <leader>v V`]

" open a new vsplit and switch to it
nnoremap <leader>s <C-w>v<C-w>l
nnoremap <leader>% <C-w>v<C-w>l
nnoremap <leader>" <C-w>s<C-w>j

" retab
nnoremap <leader>r :retab<CR>

" clear highlight with <leader><space>
nnoremap <leader><space> :noh<cr>

" gundo, for when undo won't cut it
nnoremap <leader>u :GundoToggle<CR>

" Fugitive mappings
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>g= /=======\<bar><<<<<<<\<bar>>>>>>>><CR>

" Shortcut to grab the pivotal number and put it at the start of the git commit
" message.
nmap <leader>gm /\v\d{8}<CR>ywggPysiw]A 

" Vimux
nnoremap <leader>x :call VimuxPromptCommand()<CR>

" underline with = or -
nnoremap <leader>= :normal yypVr=k<CR>
nnoremap <leader>- :normal yypVr-k<CR>

" Trick to save files that need root after editing readonly
cmap w!! w !sudo tee %
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CtrlP settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ctrlp_map = '<c-t>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_max_files = 10000
" " open in a new tab by default
" let g:ctrlp_prompt_mappings = {
"     \ 'AcceptSelection("e")': ['<c-t>'],
"     \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
"     \ }
let g:ctrlp_custom_ignore = {
  \ 'dir': '\.git$\|\.hg$\|\.svn$',
  \ 'file': '\.pyc$\|\.pyo$\|\.rbc$\|\.rbo$\|\.class$\|\.o$\|\~$\',
  \ }
" Multiple VCS's, don't include untracked files
let g:ctrlp_user_command = {
  \ 'types': {
    \ 1: ['.git', 'cd %s && git ls-files'],
    \ 2: ['.hg', 'hg --cwd %s locate -I .'],
    \ },
  \ }

nnoremap <leader>p :CtrlP<CR>
" This isn't trailing whitespace, it's there so I don't have to type space when
" using the command!
nnoremap <leader>a :Ack 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" YouCompleteMe settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ycm_key_detailed_diagnostics = '<leader>dd'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Buffergator settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" don't make the window wider. it's my window. I choose the size of it!
let g:buffergator_autoexpand_on_split = 0
" the buffer explorer appears on the right
let g:buffergator_viewport_split_policy = "r"

nnoremap <leader>b :BuffergatorToggle<CR>
nnoremap <leader>t :BuffergatorTabsToggle<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CamelCase and snake_case words
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " Use one of the following to define the camel characters.
" " Stop on capital letters.
" let g:camelchar = "A-Z"
" " Also stop on numbers.
" let g:camelchar += "0-9"
" " Include '.' for class member, ',' for separator, ';' end-statement,
" " and <[< bracket starts and "'` quotes.
" " Also include _ for snake case
" let g:camelchar += ".,;:{([`'\"_"
" nnoremap <silent><C-h> :<C-u>call search('\C\<\<Bar>\%(^\<Bar>[^'.g:camelchar.']\@<=\)['.g:camelchar.']\<Bar>['.g:camelchar.']\ze\%([^'.g:camelchar.']\&\>\@!\)\<Bar>\%^','bW')<CR>
" nnoremap <silent><C-l> :<C-u>call search('\C\<\<Bar>\%(^\<Bar>[^'.g:camelchar.']\@<=\)['.g:camelchar.']\<Bar>['.g:camelchar.']\ze\%([^'.g:camelchar.']\&\>\@!\)\<Bar>\%$','W')<CR>
" inoremap <silent><C-h> <C-o>:call search('\C\<\<Bar>\%(^\<Bar>[^'.g:camelchar.']\@<=\)['.g:camelchar.']\<Bar>['.g:camelchar.']\ze\%([^'.g:camelchar.']\&\>\@!\)\<Bar>\%^','bW')<CR>
" inoremap <silent><C-l> <C-o>:call search('\C\<\<Bar>\%(^\<Bar>[^'.g:camelchar.']\@<=\)['.g:camelchar.']\<Bar>['.g:camelchar.']\ze\%([^'.g:camelchar.']\&\>\@!\)\<Bar>\%$','W')<CR>
" vnoremap <silent><C-h> :<C-U>call search('\C\<\<Bar>\%(^\<Bar>[^'.g:camelchar.']\@<=\)['.g:camelchar.']\<Bar>['.g:camelchar.']\ze\%([^'.g:camelchar.']\&\>\@!\)\<Bar>\%^','bW')<CR>v`>o
" vnoremap <silent><C-l> <Esc>`>:<C-U>call search('\C\<\<Bar>\%(^\<Bar>[^'.g:camelchar.']\@<=\)['.g:camelchar.']\<Bar>['.g:camelchar.']\ze\%([^'.g:camelchar.']\&\>\@!\)\<Bar>\%$','W')<CR>v`<o

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
    colorscheme solarized
    set guifont=Terminus\ 10
else
    colorscheme solarized
endif
set background=dark

" This allows you to toggle the background between light and dark
call togglebg#map("<F5>")

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filetype settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype indent plugin on   " Indent files please, with omnicompletion
syntax on
" file formats
map <silent> <leader>fd :set fileformat=dos<cr>:w<cr>
map <silent> <leader>fm :set fileformat=mac<cr>:w<cr>
map <silent> <leader>fu :set fileformat=unix<cr>:w<cr>

" Space errors settings
let python_space_errors = 1
let python_highlight_space_errors = 1
let c_no_tab_space_error = 1
let c_space_errors = 1
let c_no_trail_space_error = 1
let ruby_space_errors = 1
let ruby_no_trail_space_error = 1
let ruby_no_tab_space_error = 1

"improve autocomplete menu color
highlight Pmenu ctermbg=238 gui=bold

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
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

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

"map <silent> <leader>ds :call DeleteTrailingWS()<cr>

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
  autocmd BufWrite *.py             :call DeleteTrailingWS()
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
map <leader>n :NERDTreeToggle<cr>


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
nnoremap <silent> Q mzgqap`z
" copy to end of line
nnoremap Y y$
" remove search highlight
map <silent> <leader>hh :let @/=''<cr>

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
iab xcorp FreeAgent
iab xdept Engineering

