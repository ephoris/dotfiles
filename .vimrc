""""""""""""""""""""""
" Shortcuts
""""""""""""""""""""""
let mapleader = " "
let g:mapleader = " "

nmap <leader>s :w!<Return>
nmap <leader>x :x<Return>

""""""""""""""""""""""
" Color and Font
""""""""""""""""""""""
" Syntax highlghting
syntax on

" Number lines
set number

" Color Scheme
set termguicolors
set background=dark
colorscheme murphy


set encoding=UTF-8

""""""""""""""""""""""
" Text
""""""""""""""""""""""
" Tabs to 4 spaces conversion
set expandtab
set tabstop=4
set shiftwidth=4

" Column limits
set colorcolumn=121
set tw=120

set linebreak
set nolist
set nowrap

" Folding for code
set foldmethod=syntax
set foldlevelstart=20

""""""""""""""""""""""
" Searching
""""""""""""""""""""""
" Highlighted search on
set hlsearch

" Ignore cases for searching
set ignorecase

" Makes search act like search in modern browsers
set incsearch

""""""""""""""""""""""
" No back ups
""""""""""""""""""""""
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""
" Spell checking
"""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts
map <leader>sn ]s
map <leader>sn [s
map <leader>sa zg
map <leader>s= z=
