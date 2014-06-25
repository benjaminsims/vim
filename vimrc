" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Vundle stuff ========================
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" Vundle bundles here:
"

Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-commentary'
" Send tmux commands from vim
Bundle 'benmills/vimux'
Bundle 'wincent/Command-T'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'chrisbra/csv.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'fholgado/minibufexpl.vim'
"Trying the tpope version to see if simpler
"Bundle 'scrooloose/nerdcommenter'
Bundle 'myusuf3/numbers.vim'
Bundle 'fs111/pydoc.vim'
Bundle 'ervandew/supertab'
Bundle 'scrooloose/syntastic'
Bundle 'bling/vim-airline'
" Need to make sure the appropriate package is installed as well
Bundle 'nvie/vim-flake8'
" HTML navigation
Bundle 'gcmt/breeze.vim'
" Experiment with this, which allows iTerm2 and Tmux to work with the Focus
" commands for auto saving
Bundle 'sjl/vitality.vim'
" For python autocompletion and refactoring
Bundle 'davidhalter/jedi-vim'
" For True / False toggling etc
Bundle 'AndrewRadev/switch.vim'
nnoremap - :Switch<cr>



" Ultisnips for snippet completion
" https://github.com/vim-scripts/UltiSnips
let g:UltiSnipsSnippetDirectories=["UltiSnips", "personal_snippets"]
" Track the engine.
Bundle 'SirVer/ultisnips'

" Snippets are separated from the engine.
Bundle 'honza/vim-snippets'

" " Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

filetype plugin indent on     " required!
" End Vundle stuff ========================

" Try space as leader
let mapleader = "\<Space>"
let g:mapleader = "\<Space>"


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

" Keep an undo file so things can be undone even after close
set undofile

" Make regex behave like python
nnoremap / /\v
vnoremap / /\v

" Assume a search is lower case unless capitalised
set ignorecase
set smartcase

" Default to 'global' replace on lines
set gdefault

" Execute python when F5 is pressed
" Seems to not be working?
autocmd BufRead *.py nmap <F5> :!python %<CR>

" Convenience moving around buffers
nnoremap <Leader>b :bp<CR>
nnoremap <Leader>f :bn<CR>

" Clear last search highlighting
set hlsearch!
nmap <leader>c :set hlsearch!<cr>

" Map S to 'stamp' - replace a word with register contents, without the old
" word being saved to last register
nnoremap S "_diwP

" The following are things I have installed through Pathogen, just here for my reference
" along with any settings or mappings they use
" https://github.com/scrooloose/yntastic
let g:syntastic_check_on_open=1
let g:syntastic_python_checkers=["flake8"]
" Easily toggle it on off
nnoremap <silent> <leader>ns :SyntasticToggleMode<CR>
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
noremap <Leader>q :q<cr>
"Because of the above, I end up doing this
noremap <Leader>sq :x<cr>


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
set undodir=~/.vim/tmp

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



" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif


" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif

" keep scrolling so there are lines below the cursor
set scrolloff=3

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" Show matching brace etc when one is inserted
set showmatch


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

" Save when window focus is lost
:au FocusLost * :wa

" Run last vimux command easily for testing
map <Leader>vl :VimuxRunLastCommand<CR>:call VimuxSendKeys("C-c") <CR>
" Prompt for a command to run in vimux pane
map <Leader>vp :VimuxPromptCommand<CR>
" Send ctrl c to break out of debuggers etc
nnoremap <Leader>vc :call VimuxSendKeys("C-c") <CR>
" Zoom the runner pane (many installs won't have it)
map <Leader>vz :VimuxZoomRunner<CR>
" Inspect the runner - focus on it and enable scroll mode
map <Leader>vi :VimuxInspectRunner<CR>
" More room
let g:VimuxHeight = "40"





" Try out jj for exiting to normal mode; seems to be happier at the end as it
" gets overwritten otherwise
inoremap jj <ESC>

