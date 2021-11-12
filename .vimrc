call plug#begin()

Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'lervag/vimtex'
Plug 'airblade/vim-gitgutter'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'Yggdroot/indentLine'
Plug 'morhetz/gruvbox'
Plug 'sheerun/vim-polyglot'

call plug#end()

""""""""""""""""""""""
" Airline
""""""""""""""""""""""
let g:airline_theme = 'gruvbox'
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#formatter='unique_tail'
let g:airline_powerline_fonts=1

""""""""""""""""""""""
" C++ Highlighting
""""""""""""""""""""""
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_posix_standard = 1
let g:cpp_concepts_highlight = 1
let g:cpp_experimental_template_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1

""""""""""""""""""""""
" Shortcuts
""""""""""""""""""""""
" Map leader allows for extra key combinations (Thanks Harshal)
let mapleader = ","
let g:mapleader = ","

" Random shortcuts
nmap <leader>w :w!<Return>
nmap <leader>x :x<Return>
nmap <leader>ne :NERDTreeFocus<Return>

""""""""""""""""""""""
" NERDTree
""""""""""""""""""""""
" NERDTree right side by default
let g:NERDTreeWinPos = "right"

" Closes vim if NERDTree is the only thing open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q| endif

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
colorscheme gruvbox

" Highlight line number which cursor sits
highlight CursorLine gui=NONE cterm=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
set cursorline

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

" let g:indentLine_concealcursor = ''
let g:indentLine_char = '¦'
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_leadingSpaceChar = '.'
autocmd FileType help,nerdtree IndentLinesToggle
let g:indentLine_fileTypeExclude = ['markdown', 'latex', 'tex', 'nerdtree', 'NERDTree']

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
