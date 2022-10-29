call plug#begin()

Plug 'morhetz/gruvbox'

Plug 'scrooloose/nerdtree'

Plug 'vim-airline/vim-airline'
Plug 'Yggdroot/indentLine'
Plug 'sheerun/vim-polyglot'
 
call plug#end()

" --------------------------------------------------------------------------------------------------------------------
" HEADER defaults
" --------------------------------------------------------------------------------------------------------------------
syntax on

set mouse=a
set termguicolors
set background=dark
colorscheme gruvbox

set number
" Highlight line number which cursor sits
highlight CursorLine gui=NONE cterm=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
set cursorline

set expandtab
set tabstop=4
set shiftwidth=4

set colorcolumn=121
set tw=120
set nowrap
set linebreak

set hlsearch
set ignorecase

set nobackup
set nowb
set noswapfile

" --------------------------------------------------------------------------------------------------------------------
" HEADER vim-airline
" --------------------------------------------------------------------------------------------------------------------
let g:airline_theme='gruvbox'
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#formatter='unique_tail'
let g:airline_powerline_fonts=1

" --------------------------------------------------------------------------------------------------------------------
" HEADER shortcuts
" --------------------------------------------------------------------------------------------------------------------
let mapleader = " "

nmap <silent> <leader>s :w<CR>
nmap <silent> <leader>e :NERDTreeToggle<CR>
nmap <silent> <leader>n :tabnew<CR>
nmap <silent> <leader>h :nohl<CR>

" --------------------------------------------------------------------------------------------------------------------
" HEADER nerdtree
" --------------------------------------------------------------------------------------------------------------------
let g:NERDTreeWinPos = "right"
