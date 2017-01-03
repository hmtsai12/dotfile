" Vundle
set nocompatible
filetype off

let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')

if !filereadable(vundle_readme)
	echo "Installing Vundle.."
	echo ""
	silent !mkdir -p ~/.vim/bundle
	silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
	let iCanHazVundle=0
endif

set rtp+=~/.vim/bundle/vundle/
call vundle#begin()

"Bundle 'gmarik/vundle'
Plugin 'gmarik/vundle'
Plugin 'bufexplorer.zip'
Plugin 'The-NERD-tree'
"Plugin 'L9'
"Plugin 'FuzzyFinder'
Plugin 'cscope_macros.vim'
Plugin 'SrcExpl' "preview code
Plugin 'winmanager'
"Bundle 'kien/ctrlp.vim'
"Bundle 'MarcWeber/vim-addon-mw-utils'
"Bundle 'tomtom/tlib_vim'
"Bundle 'garbas/vim-snipmate'
Plugin 'taglist.vim'
"Plugin 'tpope/vim-fugitive'
"Plugin 'git://git.wincent.com/command-t.git'
call vundle#end()
filetype plugin indent on
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2011 Apr 15
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif
"preview code function
map <f7> :SrcExplToggle<CR>

"Tlist
map <f9> :TlistToggle<CR>
let Tlist_Use_Right_Window = 1
"let Tlist_Show_One_File = 1
"let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_File_Fold_Auto_Close = 1
let Tlist_Sort_Type = "name"

"highlight
map <f8> :set hls!<bar>set hls?<CR>

"BufExplorer
map <f6> :BufExplorer<CR>

"win manager
nmap wm :WMToggle<CR>

nmap :F :FirstExplorerWindow<CR>
nmap :B :BottomExplorerWindow<CR>

"let g:winManagerWindowLayout = "FileExplorer,BufExplorer"
let g:winManagerWidth = 30
let g:defaultExplorer = 0

"save file
map <f1> :w<cr>

:set ai
:map td :tabnew. <cr>
:noremap ts td
if filereadable("workspace.vim")
	source workspace.vim
endif
"quick fix 
set cscopequickfix=c-,d-,e-,g-,i-,s-,t-
nmap <C-n> :cnext<CR>
nmap <C-p> :cprev<CR>
" refresh cscope tags
function UpdateCtags()
	let curdir=getcwd()
	while !filereadable("./tags")
		cd ..
		if getcwd() == "/"
			break
		endif
	endwhile
	if filewritable("./tags")
		:!ctags -R
	endif
	execute ":cd " . curdir
endfunction

function UpdateCStags()
	let curdir=getcwd()
	while !filereadable("./cscope.out")
		cd ..
		if getcwd() == "/"
			break
		endif
	endwhile
	if filewritable("./cscope.out")
		:!cscope -Rbq
		execute ":cscope kill 0"
		execute ":cscope add cscope.out"
	endif
	execute ":cd " . curdir
endfunction
nmap <F3> :call UpdateCtags()<CR>
nmap <F4> :call UpdateCStags()<CR>

" Color
"colorscheme kolor 
"colorscheme greens
highlight Comment term=bold cterm=NONE ctermfg=Green ctermbg=NONE gui=NONE guifg=Green guibg=NONE
highlight Directory term=bold cterm=NONE ctermfg=cyan ctermbg=NONE gui=NONE guifg=cyan guibg=NONE
" Explore
nmap :E :Explore<CR>
" sesionopt and viminfo
nmap save :call SaveProject()<CR>
nmap wipe :call WipeProject()<CR>
"set sessionoptions+=slash 
"set sessionoptions+=unix 
set sessionoptions-=curdir
set sessionoptions+=sesdir
"set sessionoptions-=blank
function! SaveProject()
WMClose
NERDTreeClose 
if(bufexists("__Tag_List__")!=0)
TlistClose
endif
"echo "Saving ".s:curProjectTag
"TlistSessionSave! .s:curProjectTag
echo "Saving ".s:curProjectSession
execute 'mksession! '.s:curProjectSession
echo "Saving ".s:curProjectInfo
execute 'wviminfo! '.s:curProjectInfo
endfunction
function! AutoSaveProject()
if(argc()==0 && (filereadable(s:curProjectSession) || filereadable(s:curProjectInfo)))
call SaveProject()
endif
endfunction

function! LoadProject()
let s:curWorkDir=getcwd()
let s:curProjectSession=s:curWorkDir."/project.vim"
let s:curProjectInfo=s:curWorkDir."/project.viminfo"
"let s:curProjectTag=s:curWorkDir."/project.vimtag"
"if(filereadable(s:curProjectTag))
"echo "Loading ".s:curProjectTag
"TlistSessionLoad .s:curProjectTag
"endif
if(filereadable(s:curProjectSession))
echo "Loading ".s:curProjectSession
execute 'source '.s:curProjectSession
endif
if(filereadable(s:curProjectInfo))
echo "Loading ".s:curProjectInfo
execute 'rviminfo '.s:curProjectInfo
endif
endfunction
function! AutoLoadProject()
if(argc()==0)
call LoadProject()
endif
endfunction

function! WipeProject()
if(delete(s:curProjectSession)==0)
echo "Deleted ".s:curProjectSession
endif
if(delete(s:curProjectInfo)==0)
echo "Deleted ".s:curProjectInfo
endif
endfunction

autocmd VimEnter * call AutoLoadProject()
autocmd VimLeave * call AutoSaveProject()
