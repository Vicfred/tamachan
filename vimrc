" Vicfred vimrc.
set nocompatible                 " Vi Improved.
set ffs=unix                     " Unix line endings.
set encoding=utf-8               " Unicode.
set scrolloff=3                  " Always show 3 lines of context.
set ttyfast lazyredraw           " Make drawing fast.
set timeoutlen=227               " Wait for commands.
set ttimeoutlen=13              " Wait for keys.
set backspace=indent,eol,start   " Sane backspace.
set visualbell t_vb=             " Disable bells.
set hidden                       " Allow buffer backgrounding.
set showmatch                    " Show matching bracket.
set number relativenumber        " Hybrid line numbers.
set cursorline                   " Highlight the current line.
set expandtab                    " Use spaces instead of tab.
set tabstop=2                    " Spaces to use per tab.
set shiftwidth=2                 " Spaces to use per indent.
set cindent                      " Automatic indentation.
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

" Put all temporary files under the same directory.
if !isdirectory($HOME.'/.vim/files') && exists('*mkdir')
  call mkdir($HOME.'/.vim/files')
endif
if isdirectory($HOME.'/.vim/files') && !isdirectory($HOME.'/.vim/files/backup') && exists('*mkdir')
  call mkdir($HOME.'/.vim/files/backup')
endif
if isdirectory($HOME.'/.vim/files') && !isdirectory($HOME.'/.vim/files/swap') && exists('*mkdir')
  call mkdir($HOME.'/.vim/files/swap')
endif
if isdirectory($HOME.'/.vim/files') && !isdirectory($HOME.'/.vim/files/undo') && exists('*mkdir')
  call mkdir($HOME.'/.vim/files/undo')
endif
if isdirectory($HOME.'/.vim/files') && !isdirectory($HOME.'/.vim/files/info') && exists('*mkdir')
  call mkdir($HOME.'/.vim/files/info')
endif
set backupdir   =$HOME/.vim/files/backup/
set backupext   =-vimbackup
set backupskip  =
set directory   =$HOME/.vim/files/swap//
set undodir     =$HOME/.vim/files/undo/
if has('nvim')
    set viminfo     ='1000,n$HOME/.vim/files/info/nviminfo
else
    set viminfo     ='1000,n$HOME/.vim/files/info/viminfo
endif

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

" Make Y behave like C and D.
nnoremap Y y$

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

" Function keys are unmapped by default.
nnoremap <F1> :FormatCode<CR>
nnoremap <F2> :silent execute 'w !xclip -selection clipboard' <Bar> redraw!<CR>
nnoremap <F3> :let @+ = expand('%:t')<CR>
nnoremap <F8> :TagbarToggle<CR>

" Copy visually selected text to system clipboard
vnoremap <leader>y "+y:let @* = @+<CR>

" Copy current line to clipboard in normal mode
nnoremap <leader>yy "+yy:let @* = @+<CR>

" Paste from system clipboard
nnoremap <leader>p "+p
vnoremap <leader>p "+p

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
runtime cocrc

" Terminal fix 24-bit.
let &t_8f = "\<Esc>[38:2:%lu:%lu:%lum"
let &t_8b = "\<Esc>[48:2:%lu:%lu:%lum"

" set term=xterm-256color
set termguicolors
let g:sonokai_style = 'andromeda'
let g:sonokai_diagnostic_line_highlight = 1
colorscheme sonokai

autocmd VimEnter * echo "Hola Vicfred :)"

let g:hardtime_default_on = 1

filetype plugin indent on
syntax on

