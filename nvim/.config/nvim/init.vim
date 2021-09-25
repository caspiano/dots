call plug#begin('~/.config/nvim/plugs')

Plug 'neomake/neomake'

Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-obsession'

Plug 'altercation/vim-colors-solarized'
Plug 'keith/parsec.vim'
Plug 'dracula/vim'
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/AnsiEsc.vim'

Plug 'Yggdroot/indentLine'

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'severin-lemaignan/vim-minimap'
Plug 'vim-scripts/SearchComplete'

Plug 'danro/rename.vim'
Plug 'djoshea/vim-autoread'

Plug 'Shougo/denite.nvim'
Plug 'airblade/vim-gitgutter'

Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'wellle/tmux-complete.vim'
Plug 'ncm2/ncm2-github'
Plug 'subnut/ncm2-github-emoji'

Plug 'ncm2/ncm2-syntax' | Plug 'Shougo/neco-syntax'

Plug 'jiangmiao/auto-pairs'
Plug 'justinmk/vim-sneak'
Plug 'mbbill/undotree'
Plug 'qpkorr/vim-bufkill'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

Plug 'vim-scripts/argtextobj.vim'
Plug 'michaeljsmith/vim-indent-object'

Plug 'vim-scripts/taglist.vim'
Plug 'zivyangll/git-blame.vim'

" Languages

Plug 'tidalcycles/vim-tidal'

Plug 'keith/swift.vim'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'mhartington/nvim-typescript', {'do': './install.sh'}

Plug 'davidhalter/jedi-vim'

Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'racer-rust/vim-racer', { 'for': 'rust' }

Plug 'neovimhaskell/haskell-vim'
Plug 'derekelkins/agda-vim'
Plug 'idris-hackers/idris-vim'
Plug 'vmchale/ats-vim'

Plug 'tpope/vim-endwise'
Plug 'rhysd/vim-crystal'
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }

Plug 'vmchale/dhall-vim'

Plug 'tpope/vim-markdown'

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'autozimu/LanguageClient-neovim', {
      \ 'branch': 'next',
      \ 'do': 'bash install.sh',
      \ }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startuc = 1

Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'

call plug#end()

let g:indentLine_char = '│'

let mapleader="\<Space>"

" neomake on save
call neomake#configure#automake('w')

" Completion

set completeopt=noinsert,menuone,noselect
autocmd BufEnter * call ncm2#enable_for_buffer()
set shortmess+=c
inoremap <c-c> <ESC>
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

let g:LanguageClient_serverCommands = {
    \ 'dhall': ['dhall-lsp-server'],
    \ 'nix': ['rnix-lsp'],
    \ 'crystal': ['crystalline'],
    \ }

" comment the next line to disable automatic format on save
let g:dhall_format=1

" Always draw sign column. Prevent buffer moving when adding/deleting sign.
set signcolumn=yes

" Required for operations modifying multiple buffers like rename.
set hidden

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

" Standard stuff to let you know where you are
set number
set relativenumber
set wildmenu

" Shell trix to load env
set shellcmdflag=-ic

" Automatically detect indent from filetype
filetype indent plugin on

" Search matching options
set ignorecase
set smartcase
set incsearch

" Persistent undo
set undodir=~/.config/nvim/undo
set undofile

" Get rid of swap files... might not be the best idea
set noswapfile

" Set some language specific syntax options
autocmd Filetype yaml setlocal et ts=2 sw=2 sts=2
autocmd Filetype haskell setlocal et ts=2 sw=2 sts=2
autocmd Filetype crystal setlocal et ts=2 sw=2 sts=2
autocmd Filetype markdown setlocal spell

" Markdown
let g:markdown_fenced_languages = ['crystal', 'ruby', 'haskell', 'css', 'typescript', 'javascript', 'js=javascript', 'json=javascript'] 

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

" Relative or absolute number lines
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

"- Crystal clean
nnoremap <C-F> :!cf --no-color<CR>

"- FZF
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <C-f> :Rg<CR>
nnoremap <silent> <C-b> :Buffers<CR>

" close buffer
nnoremap <silent> <Leader>w :BD<CR>

iab <expr> tds strftime("%F %b %T")

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" - SuperTab
" let g:SuperTabClosePreviewOnPopupClose = 1
" let g:SuperTabDefaultCompletionType = '<c-n>'

" syntax zone

syntax on
set background=dark

" change bar when in root
if($USER ==? 'root')
    let g:airline_theme='dracula'
    colorscheme dracula
else
    let g:airline_themE='gruvbox'
    colorscheme gruvbox
endif

let g:airline_left_sep=''
let g:airline_right_sep=''

" - NERDTree
nmap <silent> <Leader>ee :NERDTreeToggle<CR>
let g:NERDTreeWinPos="right"

" Tag list
nnoremap <silent> <F8> :TlistToggle<CR>

" search up for a tags dir
set tags=./tags;$HOME

" alt-] to open in a new window
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" control q macro mapped to space bar
nnoremap <Leader><Leader> @q

" keep contents of the paste register when pasting over a visual selection
vnoremap <leader>p "_dP

" Remove any introduced trailing whitespace after moving...
" let g:DVB_TrimWS = 1

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

set hidden
