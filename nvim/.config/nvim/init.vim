call plug#begin('~/.config/nvim/plugs')

" Perfomance regression in neovim
Plug 'antoinemadec/FixCursorHold.nvim'

" Better scroll
Plug 'karb94/neoscroll.nvim'

Plug 'neomake/neomake'

Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-obsession'

Plug 'keith/parsec.vim'
Plug 'dracula/vim'
Plug 'gruvbox-community/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/AnsiEsc.vim'

Plug 'Yggdroot/indentLine'

" Directory Viewer
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'unkiwii/vim-nerdtree-sync'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Find and Replace
Plug 'brooth/far.vim'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'scrooloose/nerdcommenter'
Plug 'vim-scripts/SearchComplete'

Plug 'danro/rename.vim'
Plug 'djoshea/vim-autoread'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'zivyangll/git-blame.vim'

" GitHub
Plug 'github/copilot.vim'

Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'wellle/tmux-complete.vim'
Plug 'ncm2/ncm2-syntax' | Plug 'Shougo/neco-syntax'

Plug 'jiangmiao/auto-pairs'
Plug 'justinmk/vim-sneak'
Plug 'haya14busa/vim-asterisk'
Plug 'mbbill/undotree'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'takac/vim-hardtime'

" Introduces 'a' -> argument
Plug 'vim-scripts/argtextobj.vim'
" Introduces 'i' -> indent
Plug 'michaeljsmith/vim-indent-object'
" Introduces 'c' -> column
Plug 'coderifous/textobj-word-column.vim'

"Languages

Plug 'ncm2/ncm2-jedi', { 'for': 'python' }

Plug 'tidalcycles/vim-tidal'

Plug 'keith/swift.vim', { 'for': 'swift' }

Plug 'HerringtonDarkholme/yats.vim', { 'for': ['typescript', 'markdown'] }

Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'racer-rust/vim-racer', { 'for': 'rust' }

Plug 'derekelkins/agda-vim', { 'for': 'agda' }
Plug 'idris-hackers/idris-vim', { 'for': 'idris' }
Plug 'neovimhaskell/haskell-vim', { 'for': ['haskell', 'markdown'] }
Plug 'vmchale/ats-vim', { 'for': 'ats' }
Plug 'vmchale/dhall-vim', { 'for': 'dhall' }

Plug 'tpope/vim-endwise'
Plug 'rhysd/vim-crystal', { 'for': ['crystal', 'markdown'] }
Plug 'vim-ruby/vim-ruby', { 'for': ['ruby', 'markdown'] }

Plug 'tpope/vim-markdown'

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'autozimu/LanguageClient-neovim', {
      \ 'branch': 'next',
      \ 'do': 'bash install.sh',
      \ }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

let g:deoplete#enable_at_startup = 1

call plug#end()

let g:indentLine_char = '│'

let mapleader="\<Space>"

" neomake on save
call neomake#configure#automake('w')

set fillchars=vert:│,fold:┈,diff:┈

" Completion
function s:ncm2_start(...)
    autocmd BufEnter * call ncm2#enable_for_buffer()
endfunc

call timer_start(200, function('s:ncm2_start'))

set completeopt=noinsert,menuone,noselect
set shortmess+=c

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" LSP servers
let g:LanguageClient_serverCommands = {
    \ 'dhall': ['dhall-lsp-server'],
    \ 'nix': ['rnix-lsp'],
    \ 'sh': ['bash-language-server', 'start'],
    \ 'bash': ['bash-language-server', 'start'],
    \ }
    " \ 'crystal': ['crystalline'],

" Comment the next line to disable automatic format on save for dhall
let g:dhall_format=1

" Cycle through buffers
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

" Map keybinding
nnoremap <silent> <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>

" Gives you a heads-up when you go over 81 chars per line
call matchadd('ColorColumn', '\%81v', 100)
highlight ColorColumn ctermbg=red

" Very useful undo persistant undo with tree
nnoremap <silent> <Leader>u :UndotreeToggle<CR>
let g:mundo_prefer_python3 = 1

" Automatically detect indent from filetype
filetype indent plugin on

" Set some language specific syntax options
autocmd Filetype yaml setlocal et ts=2 sw=2 sts=2
autocmd Filetype haskell setlocal et ts=2 sw=2 sts=2
autocmd Filetype crystal setlocal et ts=2 sw=2 sts=2
autocmd Filetype markdown setlocal spell et ts=2 sw=2 sts=2

" Markdown
let g:markdown_fenced_languages = ['crystal', 'ruby', 'haskell', 'css', 'typescript', 'javascript', 'js=javascript', 'json=javascript'] 
let g:markdown_syntax_conceal = 0

" Better pane navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
set splitright
set splitbelow

" Tab navigation
nnoremap <C-S-tab> :tabprevious<CR>
nnoremap <C-tab>   :tabnext<CR>
nnoremap <C-t>     :tabnew<CR>
inoremap <C-S-tab> <Esc>:tabprevious<CR>i
inoremap <C-tab>   <Esc>:tabnext<CR>i
inoremap <C-t>     <Esc>:tabnew<CR>

" Toggle between relative and absolute number lines
function! NumberToggle()
    if (&relativenumber == 1)
        set number
        set norelativenumber
    else
        set number
        set relativenumber
    endif
endfunction
nnoremap <silent> <C-n> :call NumberToggle()<CR>

" Crystal clean
nnoremap <C-F> :!cf --no-color<CR>

" FZF
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <C-f> :Rg<CR>
nnoremap <silent> <C-b> :Buffers<CR>

" Close buffer
nnoremap <silent> <Leader>w :BD<CR>

iab <expr> tds strftime("%F %b %T")

" Syntax
syntax on

set background=dark
" Toggle between dark and light
function! BackgroundToggle()
    if (&background == 'dark')
        set background=light
    else
        set background=dark
    endif
endfunction
nnoremap <silent> <C-T> :call BackgroundToggle()<CR>

" Change bar when root
if($USER ==? 'root')
    let g:airline_theme='dracula'
    colorscheme dracula
else
    let g:airline_themE='gruvbox'
    colorscheme gruvbox
endif

let g:airline_left_sep=''
let g:airline_right_sep=''

" NERDTree
nmap <silent> <Leader>ee :NERDTreeToggle<CR>
let g:NERDTreeShowHidden=1
let g:NERDTreeWinPos="right"

" Control q macro mapped to space bar
nnoremap <Leader><Leader> @q

" Keep contents of the paste register when pasting over a visual selection
vnoremap <leader>p "_dP

" Q mapped to q
nnoremap Q q

" Center the display line after searches.
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

nmap <C-Bslash> :NERDComToggleComment<CR>
vmap <C-Bslash> :NERDComToggleComment<CR>gv

" Decadent colour rendering
set termguicolors

" Always draw sign column. Prevent buffer moving when adding/deleting sign.
set signcolumn=yes

" Standard stuff to let you know where you are
set number
set relativenumber
set wildmenu

" Shell trix to load env
set shellcmdflag=-ic

" Search matching options
set ignorecase
set smartcase
set incsearch
set showmatch

" Persistent undo
set undodir=~/.config/nvim/undo
set undofile

" Get rid of swap files... might not be the best idea
set noswapfile

" Don't redraw when running macros
set lazyredraw

" Naughty chars
set list
set listchars=tab:>~,trail:~

" Indents
set tabstop=8
set softtabstop=0
set expandtab
set shiftwidth=4
set smarttab
set shiftround
set autoindent
set smartindent

" Status line
set statusline=%F\ %l\:%c
set laststatus=2
set noshowmode

set mouse=a
set showcmd

" Required for operations modifying multiple buffers like rename.
set hidden
