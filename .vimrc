" General Settings

set expandtab
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set nu rnu

set nocompatible

syntax enable
filetype plugin indent on

"set path+=**
set path=XXX
set wildmenu

"set cursorline
"hi CursorLine cterm=NONE ctermbg=31 ctermfg=15
"
"let g:netrw_banner=0        " disable annoying banner
"let g:netrw_browse_split=4  " open in prior window
"let g:netrw_altv=1          " open splits to the right
"let g:netrw_liststyle=3     " tree view
"let g:netrw_list_hide=netrw_gitignore#Hide()
"let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

set complete+=U,s,k,kspell,]


" Key Maps
" ------------ 
inoremap "" "<C-c>
inoremap " ""<left>
inoremap "<space> ""<C-c>

inoremap '' '<C-c>
inoremap ' ''<left>
inoremap '<space> ''<C-c>

inoremap (( (<C-c>
inoremap ( ()<left>
inoremap (<space> ()<C-c>

inoremap [[ [<C-c>
inoremap [ []<left>
inoremap [<space> []<C-c>

inoremap {{ {<C-c>
inoremap { {}<left>
inoremap {<space> {}<C-c>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O
" ------------ 


" ------------ 
nnoremap ,<Tab> :tabnew<CR>
nnoremap <Tab> :tabn<CR>
nnoremap <S-Tab> :tabp<CR>
nnoremap ,n :set nu rnu<CR>
nnoremap ,N :set nonu nornu<CR>
nnoremap ,t :tab ter<CR>
" ------------ 
"
" Folding
set foldmethod=indent
set foldlevel=99
"set foldclose=none


" Vim plug
call plug#begin('~/.vim/plugged')
" Rust
Plug 'rust-lang/rust.vim'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
" Color scheme
"let g:lightline = {'colorscheme': 'catppuccin_mocha'}
"let g:airline_theme = 'catppuccin_mocha'

" colorscheme catppuccin-frappe
hi Normal guibg=NONE ctermbg=NONE

