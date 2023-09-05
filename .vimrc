" General Settings

set expandtab
set smartindent
set tabstop=4 
set shiftwidth=4

set nocompatible

syntax enable
filetype plugin on

set path+=**
set wildmenu

set cursorline
hi CursorLine cterm=NONE ctermbg=31 ctermfg=15

let g:netrw_banner=0        " disable annoying banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'


" Key Maps
inoremap " ""<left>
inoremap "<space> ""<C-c>
inoremap ' ''<left>
inoremap '<space> ''<C-c>
inoremap (( (<C-c>
inoremap ( ()<left>
inoremap (<space> ()<C-c>
inoremap [ []<left>
inoremap [<space> []<C-c>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

nnoremap ,<Tab> :tabnew<CR>
nnoremap <Tab> :tabn<CR>
nnoremap <S-Tab> :tabp<CR>
nnoremap ,n :set rnu<CR>
nnoremap ,N :set nornu<CR>
nnoremap ,t :tab ter<CR>
