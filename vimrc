if !has('nvim')
  set nocompatible
  set ttyfast
endif

if !exists("encoding_loaded")
  let econding_loaded=1
  set encoding=utf-8
endif

" Dont totally remember why I do this but I think its related
" to previously using patheogen
runtime macros/matchit.vim

filetype off
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'scrooloose/nerdtree'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'bling/vim-airline'
Plugin 'godlygeek/tabular'
"Plugin 'jeetsukumaran/vim-buffergator'
Plugin 'mileszs/ack.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'kana/vim-textobj-user'
Plugin 'nelstrom/vim-textobj-rubyblock'
Plugin 'rizzatti/dash.vim'
Plugin 'rizzatti/funcoo.vim'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-fugitive'
"Plugin 'tpope/vim-bundler'
"Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-rails'
"Plugin 'tpope/vim-rake'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-jdaddy' " JSON text objects and pretty printing
Plugin 'AndrewRadev/splitjoin.vim'
"Plugin 'plan9-for-vimspace/plan9-for-vimspace'

" Syntax
Plugin 'vim-ruby/vim-ruby'
Plugin 'pangloss/vim-javascript'
Plugin 'fatih/vim-go.git'
Plugin 'rust-lang/rust.vim'
Plugin 'hashivim/vim-terraform'

" Colorschemes
Plugin 'wombat'
Plugin 'molokai'
Plugin 'mayansmoke'
Plugin 'altercation/vim-colors-solarized'

call vundle#end()

let g:airline_powerline_fonts = 1
"let mapleader = "\<space>"
" https://www.reddit.com/r/vim/comments/1vdrxg/space_is_a_big_key_what_do_you_map_it_to/cerq68d
map <space> <leader>

" Enable mouse in all modes
set mouse=a
if !has('nvim')
  set ttymouse=xterm2
endif

set wildmenu
set wildmode=list:longest,full
set wildignore=*.swp,*.bak,*.pyc,*.class
set history=1000        " remember more commands and search history
set undolevels=100      " use many muchos levels of undo
"set title               " change the terminal's title
set visualbell          " don't beep
set noerrorbells        " don't beep

" Syntax highlighting stuff
syntax on
filetype plugin indent on
set pastetoggle=<F2>

" Default tab spacing should be 2 spaces
set autoindent
set tabstop=2       " 2 spaces for tabs
set shiftwidth=2    " ^^
set softtabstop=2
set expandtab

set timeoutlen=350  " In milliseconds

" Dont increment numbers as octal
set nrformats-=octal

set laststatus=2
set scrolloff=5
set sidescrolloff=1
set backspace=indent,eol,start
set showmatch       " highlight search
set incsearch       " show search matches as you type
set wildmenu
set showcmd
set nowrap          " Dont wrap lines
set number          " Show line numbers
set ruler           
set hidden
set autoread
set noautowrite
set splitright      " Make new split-windows open to the right
set shell=/bin/zsh " Set to bash instead of zsh for compatiblity

" Common typos
iabbrev teh the
iabbrev tihs this
iabbrev jsut just

set t_Co=256
if has('gui_running') 
"  set background=dark
"  colorscheme solarized
  colorscheme molokai 
  set cursorline
  set guioptions-=T " Remove toolbar
  "set guioptions-=r " Remove scrollbars
  "set guioptions-=l 
  "set guifont=Monaco:h11.0
  "set columns=150
  "set lines=55
endif

" Autindent, shift two characters, expand tabs to spaces
autocmd FileType shell,ruby,haml,eruby,yaml,html,javascript,sass,cucumber set ai ts=2 sw=2 sts=2 et
autocmd FileType rust set ai ts=4 sw=4 sts=4 et
autocmd Filetype c,python set ai ts=4 sw=4 sts=4 noet
" Autindent, shift 8 characters, use real tabs
"autocmd Filetype go set ai ts=8 sw=8 sts=8 noet
autocmd Filetype go set ai ts=4 sw=4 sts=4 noet

" Remove whitespace on save
autocmd BufWritePre *.py,*.sh,*.rb,*.go :%s/\s\+$//e
autocmd BufRead .git/COMMIT_EDITMSG set spell

autocmd! BufWritePost .vimrc source ~/.vimrc

nnoremap <F3> :NumbersToggle<CR>
nnoremap <F4> :NumbersOnOff<CR>

" Enable word processor style word wrapping
"nnoremap <F4> :call SetWrap()<CR>

" Command mode
cmap w!! w !sudo tee % >/dev/null
" Vim's crypto is broken so dont let me use it (even accidentally). Its
" already disabled in Neovim.
" https://github.com/vim/vim/issues/638#issuecomment-186163441
cnoremap X x
cmap Set set

" Yank to end of line
map Y y$

" Ack
map <leader>a :Ack 

" Fugitive mappings
nmap <leader>gb :Gbrowse<cr>
nmap <leader>gl :Glog<cr>
nmap <leader>gs :Gstatus<cr>
nmap <leader>ge :Gedit<cr>
nmap <leader>gd :Gdiff<cr>
nmap <leader>gc :Gcommit<cr>

" Set alternate complete key
imap <C-Space> <C-N>

" http://vimcasts.org/episodes/aligning-text-with-tabular-vim/
noremap <leader><tab><tab> <ESC>:Tabularize /
noremap <leader><tab>: <ESC>:Tabularize /:\zs<CR>
noremap <leader><tab>= <ESC>:Tabularize /=<CR>

" Update swap file after 20 characters
set updatecount=20

" Disable arrow keys
"inoremap  <Up>     <NOP>
"inoremap  <Down>   <NOP>
"inoremap  <Left>   <NOP>
"inoremap  <Right>  <NOP>
"noremap   <Up>     <NOP>
"noremap   <Down>   <NOP>
"noremap   <Left>   <NOP>
"noremap   <Right>  <NOP>

vmap <Tab> >gv
vmap <S-Tab> <gv

" Neovim specific things
if has('nvim')
  tnoremap <Esc> <C-\><C-n>
endif

" TODO http://vimcasts.org/episodes/using-external-filter-commands-to-reformat-html/
" TODO https://youtu.be/aHm36-na4-4?t=720
