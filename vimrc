" Load Pathogen
execute pathogen#infect()

" Change the leader, comma is easier to type
let mapleader = ","

" Flip the default behaviour of these - generally I want to go to the exact position
" of a mark rather than just the start of a line
nnoremap ' `
nnoremap ` '

" Allow buffer switching without having to save, remember settings etc
set hidden

" Disable annoying line wrapping, although this is likely to breach PEP8 line
" length rules often
set nowrap
" Makes tabs work correctly, using spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Execute python when F5 is pressed
" Seems to not be working?
autocmd BufRead *.py nmap <F5> :!python %<CR>

" Convenience moving around buffers
nnoremap <Leader>b :bp<CR>
nnoremap <Leader>f :bn<CR>

" Clear last search highlighting
set hlsearch!
nmap <leader>nh :set hlsearch!<cr>

" The following are things I have installed through Pathogen, just here for my reference
" along with any settings or mappings they use
" https://github.com/scrooloose/yntastic
let g:syntastic_check_on_open=1
let g:syntastic_python_checker="flake8"
" Easily toggle it on off
nnoremap <silent> <leader>ns :SyntasticToggleMode<CR>

" Ultisnips for snippet completion
" https://github.com/vim-scripts/UltiSnips
let g:UltiSnipsSnippetDirectories=["UltiSnips", "snippets"]

"
" View buffers nicely
" git submodule add https://github.com/sontek/minibufexpl.vim.git
" bundle/minibufexpl
"
"
" Give PEP8 checking a try
" git submodule add https://github.com/vim-scripts/pep8.git bundle/pep8
"
" Tab completion
" git submodule add https://github.com/ervandew/supertab.git bundle/supertab
au FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"

" Let Ctrl n change from relative to absolute numbers
function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>



" Access to the Python documentation
" git submodule add https://github.com/fs111/pydoc.vim.git bundle/pydoc
"

" Jump around the file more easily
" https://github.com/Lokaltog/vim-easymotion.git
"
" Auto relative / absolute line numbers
" git submodule add  https://github.com/myusuf3/numbers.vim.git 
"
" Textmate / Pycharm style file opening using leader - t
" git submodule add https://github.com/wincent/Command-T.git bundle/command-t
" Also need to do rake make in the directory
"
" Easier commenting (mainly leader cc to comment a line)
" git add submodule https://github.com/scrooloose/nerdcommenter.git
"
" Git commands in vim
" git submodule add http://github.com/tpope/vim-fugitive.git bundle/fugitive


" Slightly quicker saving and quitting
noremap <Leader>s :update<CR>
nmap <leader>q :q<cr>
nnoremap <leader>Q :update :q<cr>


" Code folding - za will now open and close code blocks
set foldmethod=indent
set foldlevel=99


" syntax highlighting 
syntax on                         
" try to detect filetypes
filetype on                  
" enable loading indent file for filetype        
filetype plugin indent on    


" Set the backup and temp directories to be in one place (you need to create
" them) to avoid vim leaving files everywhere
set backup
set backupdir=~/.vim/backup
set directory=~/.vim/tmp

" Make sure vim knows if we are in a virtualenv and add the virtualenv's site-packages to vim path
py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF


"=======================================================================
"	Start vimrc example stuff:



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
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif
"=======================================================================
