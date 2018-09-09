"Work-around for : CMake\bin msvcr90.dll of path call R6034 error
python << EOF
import os
for forbidden_substring in ['iCLS Client', 'CMake']:
    os.environ['PATH'] = ';'.join([item for item in os.environ['PATH'].split(';')
                                   if not item.lower().find(forbidden_substring.lower()) >= 0])
EOF

source $VIMRUNTIME/../_vimrc

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdtree'
Plugin 'derekwyatt/vim-fswitch'
Plugin 'yegappan/mru'
Plugin 'godlygeek/tabular'
Plugin 'easymotion/vim-easymotion'
Plugin 'chrisbra/vim_faq'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'dyng/ctrlsf.vim'
Plugin 'powerline/powerline'
Plugin 'szw/vim-maximizer'
Plugin 'kopischke/vim-stay'
Plugin 'w0rp/ale'
Plugin 'vim-scripts/peaksea'
Plugin 'nanotech/jellybeans.vim'
Plugin 'terryma/vim-expand-region'
Plugin 'tpope/vim-fugitive'
Plugin 'plasticboy/vim-markdown'
Plugin 'ludovicchabant/vim-gutentags'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
let mapleader=","
nnoremap Z :q<CR>
nnoremap \l <C-L>
" Number manipulate
nnoremap <A-a> <C-a>
nnoremap <A-x> <C-x>
" Windows operating
nnoremap <C-k> <C-w>k 
nnoremap <C-j> <C-w>j 
nnoremap <C-l> <C-w>l 
nnoremap <C-h> <C-w>h 
" Quickfix windows 
nnoremap \cw :botright cwindow 5<CR>
nnoremap \cn :cn<CR>
nnoremap \cp :cp<CR>
nnoremap \cc :ccl<CR>

function! FindGitRepoPath(file)
    let l:git = finddir(".git/", a:file . ";")

    if !empty(l:git)
        return fnamemodify(l:git, ":p:h:h")
    endif
endfunction

function! FindApplicationPath(file)
    let l:application = finddir("Application/", a:file . ";")

    if !empty(l:application)
        return fnamemodify(l:application, ":p:h")
    endif
endfunction

function! FindCAPLScriptPath(file)
    let l:application = finddir("CAPL/", a:file . ";")

    if !empty(l:application)
        return fnamemodify(l:application, ":p:h")
    endif
endfunction


function! FindCodePath(file)
    let l:code = finddir("Code/", a:file . ";")

    if !empty(l:code)
        return fnamemodify(l:code, ":p:h")
    endif
endfunction

function! FindProjectRoot(mode,file)
    let l:abs = resolve(fnamemodify(expand(a:file), ":p"))
    if a:mode == "git"
      let l:path = FindGitRepoPath(l:abs)
    elseif a:mode == "Application"
      let l:path = FindApplicationPath(l:abs)
    elseif a:mode == "Code"
      let l:path = FindCodePath(l:abs)
    elseif a:mode == "CAPL"
      let l:path = FindCAPLScriptPath(l:abs)
    else
      let l:path = ""
    endif

    if !empty(l:path)
        return l:path
    endif

    return '"'. fnamemodify(l:abs, ":h") . '"'
endfunction

nnoremap \. :so $home\_vimrc<CR>

set number
set nowrap
set lazyredraw
set noerrorbells
colo desert
set bdir=c:\\VimBckupDir
set undodir=c:\\VimUndoDir
syntax enable
set textwidth=0
set expandtab
set smarttab
set shiftwidth=2
set tabstop=4
set cursorline

" vim -b : edit binary using xxd-format!
augroup Binary
au!
au BufReadPre  *.bin let &bin=1
au BufReadPost *.bin if &bin | %!xxd
au BufReadPost *.bin set ft=xxd | endif
au BufWritePre *.bin if &bin | %!xxd -r
au BufWritePre *.bin endif
au BufWritePost *.bin if &bin | %!xxd
au BufWritePost *.bin set nomod | endif
augroup END

" auto change directory of current opened file
autocmd BufEnter * silent!  lcd %:p:h

" NERDTree plugin
nnoremap <leader><leader>no :NERDTree %:p:h<CR>
nnoremap <leader><leader>nc :NERDTreeClose<CR>

" minibufExplorer plugin
"let g:miniBufExplAutoStart = 1
"let g:miniBufExplBuffersNeeded = 1

" Tagbar plugin
nnoremap \tg :TagbarToggle<CR>

" ==============================
"  Cscope settings
" ==============================
set cscopequickfix=s-,c-,d-,i-,t-,e-,g-,f-
set csto=0
set cst
set nocsverb
set cspc=5
"
" s: Find this C symbol
nmap <leader><leader>s :cs find s <C-R>=expand("<cword>")<CR><CR> 
" g: Find this definition
nmap <leader><leader>g :cs find g <C-R>=expand("<cword>")<CR><CR>
" c: Find functions calling this function
nmap <leader><leader>c :cs find c <C-R>=expand("<cword>")<CR><CR>
" d: Find functions called by this function
nmap <leader><leader>d :cs find d <C-R>=expand("<cword>")<CR><CR>
" t: Find this text string
nmap <leader><leader>t :cs find t <C-R>=expand("<cword>")<CR><CR>
"f: Find this file
nmap <leader><leader>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
" i: Find files #including this file
nmap <leader><leader>i :cs find i ^<C-R>=expand("<cfile>")<CR><CR>
" e: Find this egrep pattern
nmap <leader><leader>e :cs find e <C-R>=expand("<cword>")<CR><CR>

" unload cscopoe database
nmap <leader><leader>k :call UnloadCscopeDb()<CR>

" automatically load database
augroup autolaod_cscope
  au!
  au BufEnter *.[ch] call LoadCscopeDb()
augroup END 


" Load cscopoe.out under current, paretn, parents' parent directory
function! LoadCscopeDb()
  " Already have a cscope connection
  if cscope_connection()
    return
  endif 
  " Find a cscope.out file
  let cscope_file = findfile("cscope.out", ".;../;../../")
  if !empty(cscope_file) && filereadable(cscope_file)
     exe "cs add" "\"" expand('%:p:h') cscope_file "\""
  endif 
endfunc

" Unload cscopoe.out file
function! UnloadCscopeDb()
  if cscope_connection()
    " Kill all cs connections
    exe "cs kill -1" 
  endif 
endfunc

" Maximizer
nnoremap <leader><leader>max! :MaximizerToggle!<CR>
nnoremap <leader><leader>max :MaximizerToggle<CR>


" MRU most recently files
let MRU_Max_Entries = 50
let MRU_Exclude_Files = '*.tmp'
nnoremap <leader><leader>l :MRU<CR>

" Easymotion leader
map <leader> <Plug>(easymotion-prefix)

" CtrlSF
let g:ctrlsf_debug_mode = 0
let g:ctrlsf_mapping = {
             \ "next": "n",
             \ "prev": "N",
             \ }
let g:ctrlsf_ignore_dir = ['.git','.hg','.backups']
let g:ctrlsf_indent = 2
let g:ctrlsf_position = 'bottom'
let g:ctrlsf_selected_line_hl = 'p'
let g:ctrlsf_winsize = '30%'
let g:ctrlsf_auto_close = 1
let g:ctrlsf_context = '-B 2 -A 1'
let g:ctrlsf_default_view_mode = 'compact'
nnoremap \a :<C-R>=FindProjectRoot('Code',expand('%'))<CR><Home>CtrlSF<Space>-R<Space><Space><left>
nnoremap \p :<C-R>=FindProjectRoot('CAPL',expand('%'))<CR><Home>CtrlSF<Space>-R<Space><Space><left>
nnoremap \g :<C-R>=FindProjectRoot('Code_Tasking',expand('%'))<CR><Home>CtrlSF<Space>-R<Space><Space><left>
nnoremap \f :NERDTreeFind<CR>
nnoremap \o :CtrlSFToggle<CR>
nnoremap \c :CtrlSFClearHL<CR>

set encoding=utf-8
set termencoding=gb2312
set fileencodings=ucs-bom,utf-8,chinese

if has("win32")
  set fileencoding=chinese
else
  set fileencoding=utf8
endif

set ambiwidth=double
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
language messages zh_CN.UTF-8

set winaltkeys=yes

set laststatus=2
set statusline=[%n]\ %<%f\ %r%=%-14.(%l,%c%V%)\ %P

set renderoptions=type:directx,renmode:5,taamode:1
