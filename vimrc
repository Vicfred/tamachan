" Vicfred vimrc.
set nocompatible                 " Vi Improved.
set ffs=unix                     " Unix line endings.
set encoding=utf-8               " Unicode.
set scrolloff=3                  " Always show 3 lines of context.
set lazyredraw                   " Make drawing fast.
set timeoutlen=500               " Wait for commands.
set ttimeoutlen=50               " Wait for keys.
set backspace=indent,eol,start   " Sane backspace.
set visualbell t_vb=             " Disable bells.
set hidden                       " Allow buffer backgrounding.
set showmatch                    " Show matching bracket.
set number relativenumber        " Hybrid line numbers.
set cursorline                   " Highlight the current line.
set expandtab                    " Use spaces instead of tab.
set tabstop=2                    " Spaces to use per tab.
set shiftwidth=2                 " Spaces to use per indent.
set ignorecase                   " Ignore case when searching.
set smartcase                    " Don't ignore it when it matters.
set incsearch                    " Search incrementally as I type.
set nohlsearch                   " Turn off highlighting.
set shell=sh                     " Vim only needs sh.
set history=9876                 " Remember a lot.
set backup                       " Be safe.
set undofile                     " Saves undo history across sessions.
set wildmenu                     " Enhanced completion.
set wildmode=list:longest,full   " Better completion.
set wildcharm=<C-z>              " Trigger wildmenu key in a macro.
set updatetime=300               " Faster CursorHold/LSP updates.
set signcolumn=yes               " Prevent diagnostic signs shifting text.

" C/C++
augroup cpp_style
  autocmd!
  autocmd FileType c,cpp setlocal colorcolumn=60
augroup END

" Change leader key to space.
let mapleader = " "
nnoremap <Space> <Nop>

" Put all temporary files under the same directory.
for dir in ['backup', 'swap', 'undo', 'info', 'view']
  call mkdir($HOME . '/.vim/files/' . dir, 'p')
endfor

set backupdir=$HOME/.vim/files/backup//
set backupext=-vimbackup
set backupskip=
set directory=$HOME/.vim/files/swap//
set undodir=$HOME/.vim/files/undo//
set viewdir=$HOME/.vim/files/view//

set viminfo='1000,n$HOME/.vim/files/info/viminfo

" Show non-printable characters.
set list
if has('multi_byte') && &encoding ==# 'utf-8'
  let &listchars = 'tab:▸ ,extends:»,precedes:«,nbsp:±,eol:¬,space:·,trail:•'
else
  let &listchars = 'tab:> ,extends:>,precedes:<,nbsp:.,eol:¬'
endif

augroup remember_folds
  autocmd!
  autocmd BufWinLeave ?* mkview
  autocmd BufWinEnter ?* silent! loadview
augroup END

" Split navigation.
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Disable arrow keys.
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>

" Keep it centered.
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap * *zzzv
nnoremap # #zzzv
nnoremap J mzJ`z

" Undo break points.
inoremap , ,<C-g>u
inoremap . .<C-g>u

" Jumplist mutations.
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

" Manage buffers in wildmenu.
nnoremap <leader>b :confirm buffer <C-z>
nnoremap <leader>e :confirm edit <C-z>

" Function key mappings.
nnoremap <F1> :FormatCode<CR>
nnoremap <F2> :silent execute 'w !xclip -selection clipboard' <Bar> redraw!<CR>
nnoremap <F3> :let @+ = expand('%:t') \| let @* = @+<CR>
nnoremap <F8> :TagbarToggle<CR>

" Copy visually selected text to system clipboard
vnoremap <leader>y "+y:let @* = @+<CR>

" Copy current line to clipboard in normal mode
nnoremap <leader>yy "+yy:let @* = @+<CR>

" Paste from system clipboard
nnoremap <leader>p "+p
vnoremap <leader>p "+p

" Saves and stages the current buffer (equivalent to git add %)
nnoremap <leader>ga :Gwrite<CR>

" Toggle LSP inlay hints.
nnoremap <leader>ih :CocCommand document.toggleInlayHint<CR>

" https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'bfrg/vim-cpp-modern'
Plug 'zah/nim.vim'
Plug 'ziglang/zig.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'
Plug 'preservim/tagbar'
Plug 'takac/vim-hardtime'
Plug 'vim-airline/vim-airline'
call plug#end()
call glaive#Install()

" Load coc configuration.
runtime conquer_of_completion.vim

set termguicolors
let g:sonokai_style = 'andromeda'
let g:sonokai_diagnostic_line_highlight = 1
colorscheme sonokai

augroup greeting
  autocmd!
  autocmd VimEnter * echo "Hola Vicfred :)"
augroup END

let g:hardtime_default_on = 1

filetype plugin indent on
syntax on

