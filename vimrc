set encoding=UTF-8

" This must be first, because it changes other options as side effect
set nocompatible

" Use pathogen to easily modify the runtime path to include all
" plugins under the ~/.vim/bundle directory
call pathogen#helptags()
call pathogen#incubate()

" change the mapleader from \ to ,
let mapleader=","

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

set hidden
set nowrap        " don't wrap lines
set tabstop=4     " a tab is four spaces
set softtabstop=4
set expandtab
set backspace=indent,eol,start
                  " allow backspacing over everything in insert mode
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set number        " always show line numbers
set shiftwidth=4  " number of spaces to use for autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase,
                  "    case-sensitive otherwise
set smarttab      " insert tabs on the start of a line according to
                  "    shiftwidth, not tabstop
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type

set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep

set nobackup
set noswapfile

" vim-airline
set laststatus=2

" Indentation settings
filetype plugin indent on

autocmd filetype javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
autocmd filetype html setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
autocmd filetype markdown setlocal wrap linebreak nolist textwidth=0 wrapmargin=0 formatoptions+=l

" Colors
if &t_Co >= 256 || has("gui_running")
    let g:solarized_termcolors=256
	colorscheme solarized
	set background=dark
endif

if &t_Co > 2 || has("gui_running")
	" switch syntax highlighting on, when the terminal has colors
	syntax on
endif

if has("gui_mac") || has("gui_macvim")
	set guifont=Monaco:h13
end
if has( "gui_win32")
	set guifont=Consolas:h11
endif

" Exchange spaces and tabs with special characters
set list
set listchars=tab:▸\ ,eol:¬

" Mouse
set mouse=a

" Efficiency
nnoremap ; :

" Formatting
" Use Q for formatting the current paragraph (or selection)
vmap Q gq
nmap Q gqap
map <Leader>f gg=G

" Get rid of LRUD
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" Textmate indentation commands
nmap <D-[> <<
nmap <D-]> >>
vmap <D-[> <gv
vmap <D-]> >gv

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Ctrl P
let g:ctrlp_custom_ignore = {
	\ 'dir':  '\v[\/](\.(git|hg|svn)|node_modules|dist|target)$',
	\ 'file': '\v\.(exe|so|dll|class)$',
	\ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
	\ }
let g:ctrlp_match_window_bottom = 0

map <Leader>b :CtrlPBuffer<CR>
map <Leader>t :CtrlPBufTag<CR>

" Hide highlighting
nmap <silent> ,/ :nohlsearch<CR>

" No intro
set shortmess+=I

map <Leader>o :Explore<CR>

" Configure omni completion
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" Configure rainbow parenthesis
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" Markdown syntax
au BufRead,BufNewFile *.md set filetype=markdown

" Vimgrep for words
map <Leader>* :execute "vimgrep /".expand('<cword>')."/ **/*"<CR>:copen<CR>

