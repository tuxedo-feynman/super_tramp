
" vim-plug setup
call plug#begin()


Plug 'preservim/nerdtree'
Plug 'numkil/ag.nvim'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'github/copilot.vim'


" Initialize plugin system
call plug#end()


set splitright


" Navigate buffers
map gn :bn<cr>
map gp :bp<cr>
map gd :bd<cr>


" Nerdtree customization
nmap <C-O> :NERDTreeToggle<cr>

" Start NERDTree when Vim starts with a directory argument.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

" Color scheme
set background=dark	
colorscheme lucius
LuciusDarkLowContrast
