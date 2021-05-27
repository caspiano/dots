call plug#begin('~/.config/nvim/plugs')

Plug 'neomake/neomake'

Plug 'christoomey/vim-tmux-navigator'

Plug 'keith/parsec.vim'

Plug 'altercation/vim-colors-solarized'
Plug 'dracula/vim'
Plug 'sainnhe/gruvbox-material'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/AnsiEsc.vim'

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'severin-lemaignan/vim-minimap'
Plug 'vim-scripts/SearchComplete'

Plug 'danro/rename.vim'
Plug 'djoshea/vim-autoread'

Plug 'airblade/vim-gitgutter'

" Plug 'ervandew/supertab'

Plug 'jiangmiao/auto-pairs'
Plug 'justinmk/vim-sneak'
Plug 'mbbill/undotree'
Plug 'qpkorr/vim-bufkill'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/argtextobj.vim'
Plug 'vim-scripts/taglist.vim'
Plug 'zivyangll/git-blame.vim'

" Languages

Plug 'keith/swift.vim'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'mhartington/nvim-typescript', {'do': './install.sh'}

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

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'

Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'

call plug#end()

lua << EOF
-- LSP config
require'lspconfig'.scry.setup{
  cmd = { 'crystalline' }
}

vim.lsp.set_log_level("debug")

-- Compe setup
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    nvim_lsp = true;
  };
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
EOF

let mapleader="\<Space>"

" neomake on save
call neomake#configure#automake('w')

" comment the next line to disable automatic format on save
let g:dhall_format=1

" Always draw sign column. Prevent buffer moving when adding/deleting sign.
set signcolumn=yes

" Required for operations modifying multiple buffers like rename.
set hidden

" Map keybinding
" nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>

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

" Important!!
if has('termguicolors')
    set termguicolors
endif

" Available values: 'hard', 'medium'(default), 'soft'
let g:gruvbox_material_background = 'hard'

" change bar when in root
if($USER ==? 'root')
    let g:airline_theme='dracula'
    colorscheme dracula
else
    let g:airline_themE='gruvbox'
    colorscheme gruvbox-material
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
set autoindent
set expandtab
set shiftround
set shiftwidth=2
set tabstop=2
set softtabstop=2
set smartindent
set smarttab

" Status line
set statusline=%F\ %l\:%c
set laststatus=2
set noshowmode

set mouse=a
set showcmd

set hidden
