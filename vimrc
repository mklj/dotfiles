" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

set nocompatible
filetype off
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

"Plugin 'altercation/vim-colors-solarized'
Plugin 'bling/vim-airline'
Plugin 'chriskempson/vim-tomorrow-theme'
Plugin 'evidens/vim-twig'
Plugin 'majutsushi/tagbar'
"Plugin 'nanotech/jellybeans.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-surround'
Plugin 'Valloric/YouCompleteMe'
"Plugin 'wincent/command-t'
Plugin 'flazz/vim-colorschemes'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
au! BufRead,BufNewFile * if &ft == '' | set ft=undefined | endif

" APPEARANCE  -----------------------------------------------------------------
"set background=dark
set t_Co=256 " 256 colors terminal
set cursorline " highlight the line the cursor is on
set title " show filename in terminal title
colorscheme Tomorrow-Night-Bright

" BEHAVIOUR  ------------------------------------------------------------------

syntax enable
set encoding=utf-8
set fileencoding=utf-8 " The encoding written to file.

" disable sounds
set noerrorbells
set novisualbell

set ttyfast
set hidden " allow modified buffers in the background
set autoread "auto reload if file saved externally
set lazyredraw " Don't update the display while executing macros
set scrolloff=3 " minimum lines to keep above and below cursor
set scrolljump=5 "minimum number of lines to scroll
"set showmatch
set number
set mouse=nv " unleash the rodent in Normal and Visual Mode
"set mousehide " hide when characters are typed - only works in the GUI
set backspace=indent,eol,start "allow backspacing everything in insert mode
"set list "highlight whitespace
" git commit messages: spell checking and automatic wrapping at 72 columns
autocmd Filetype gitcommit setlocal spell textwidth=72
" from http://wiki.contextgarden.net/Vim
let g:tex_flavor = "latex" " use latex flavor for all .tex files

" Prevent lag when hitting escape
set ttimeoutlen=0
set timeoutlen=1000
au InsertEnter * set timeout
au InsertLeave * set notimeout

" where backup files are kept
set undofile
set undodir=~/.vim/backup
set backupdir=~/.vim/backup
set directory=~/.vim/swap " swap file location
"set noswapfile

""" Custom backup and swap files
"let myVimDir = expand("$HOME/.vim")
"let myBackupDir = myVimDir . '/backup'
"let mySwapDir = myVimDir . '/swap'
"function! EnsureDirExists (dir)
  "if !isdirectory(a:dir)
    "call mkdir(a:dir,'p')
  "endif
"endfunction
"call EnsureDirExists(myVimDir)
"call EnsureDirExists(myBackupDir)
"call EnsureDirExists(mySwapDir)
"set backup
"set backupskip=/tmp/*
"set backupext=.bak
"let &directory = mySwapDir
"let &backupdir = myBackupDir
"set writebackup

" long lines handling / right margin
"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\%80v.\+/
set wrap
set textwidth=79
set formatoptions=qrn1
set viminfo='50,n~/.vim/viminfo
if exists('+colorcolumn')
    set colorcolumn=80,120
endif

function! Preserve(command)
    " preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " do the business:
    execute a:command
    " clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

function! StripTrailingWhitespace()
    call Preserve("%s/\\s\\+$//e")
endfunction

" KEYBINDINGS -----------------------------------------------------------------
let mapleader="," " change the mapleader from \ to ,
inoremap jj <ESC>
map <leader>? <plug>NERDCommenterToggle<CR>

" buffers ---------------------------------------------------------------------
" switches around buffers
nnoremap <F2> :bp<CR>
nnoremap <F3> :bn<CR>
nnoremap <F5> :tabprevious<CR>
nnoremap <F6> :tabnext<CR>
nnoremap <Leader>d :bd<CR>

" help
" open help text in a new tab
"cabbrev help tab help
"cabbrev h tab help
"function! OpenHelpInCurrentWindow(topic)
    "view $VIMRUNTIME/doc/help.txt
    "setl filetype=help
    "setl buftype=nofile
    ""setl buftype=help
    "setl nomodifiable
    "exe 'keepjumps help ' . a:topic
"endfunction

"command! -nargs=? -complete=help Help call OpenHelpInCurrentWindow(<q-args>)
"nnoremap <silent> <leader>h :Help

" MOVING AROUND ---------------------------------------------------------------

" Treat long lines as break lines (useful when moving around in them)
noremap j gj
noremap k gk

" disable arrow keys
"noremap <up> <nop>
"inoremap <up> <nop>
"noremap <down> <nop>
"inoremap <down> <nop>
"noremap <left> <nop>
"noremap <right> <nop>
"inoremap <left> <nop>
"inoremap <right> <nop>
"B-A-<start>

" windows
"map <C-h> <C-w>h<C-w>
"map <C-j> <C-w>j<C-w>
"map <C-k> <C-w>k<C-w>
"map <C-l> <C-w>l<C-w>
" moves around split windows
nnoremap <leader>w <C-w><C-w>

" COPY & PASTE ----------------------------------------------------------------

" from
" http://stackoverflow.com/questions/11489428/how-to-make-vim-paste-from-and-copy-to-systems-clipboard
" The "* and "+ registers are for the system's clipboard (:help registers).
" Depending on your system, they may do different things. For instance, on
" systems that don't use X11 like OSX or Windows, the "* register is used to
" read and write to the system clipboard. On X11 systems both registers can be
" used. See :help x11-selection for more details, but basically the "* is
" analogous to X11's PRIMARY selection (which usually copies things you select
" with the mouse and pastes with the middle mouse button) and "+ is analogous
" to X11's CLIPBOARD selection (which is the clipboard proper).

" If all that went over your head, try using "*yy or "+yy to copy a line to your
" system's clipboard. One or the other should work. You might like to remap this
" to something more convenient for you. For example, you could put vnoremap
" <C-c> "*y in your ~/.vimrc so that you can visually select and press Ctrl+c to
" yank to your system's clipboard.

" Be aware that copying/pasting from the system clipboard will not work if :echo
" has('clipboard') returns 0. In this case, vim is not compiled with the
" +clipboard feature and you'll have to install a different version or recompile
" it. Some linux distros supply a minimal vim installation by default, but
" generally if you install the vim-gtk package you can get the extra features.

" You also may want to have a look at the 'clipboard' option described at :help
" cb. In this case you can :set clipboard=unnamed or :set clipboard=unnamedplus
" to make all yanking/deleting operations automatically copy to the system
" clipboard. This could be an inconvenience in some cases where you are storing
" something else in the clipboard as it will override it.

" To paste you can use "+p or "*p (again, depending on your system and/or
" desired selection) or you can map these to something else. I type them
" explicitly, but I often find myself in insert mode. If you're in insert mode
" you can still paste them with proper indentation by using <C-r><C-p>* or
" <C-r><C-p>+. See :help i_CTRL-R_CTRL-P.

" It's also worth mentioning vim's paste option (:help paste). This puts vim
" into a special "paste mode" that disables several other options, allowing you
" to easily paste into vim using your terminal emulator or multiplexer's
" familiar paste shortcut. Simply type :set paste to enable it, paste your
" content and then type :set nopaste to disable it. Alternatively, you can use
" the pastetoggle option to set a keycode that toggles the mode (:help
" pastetoggle). I recommend using registers instead of these options, but if
" they are still too scary this can be a convenient workaround while you're
" perfecting your vim chops.

"if has('unnamedplus')
    "set clipboard=unnamedplus,unnamed
"else
    "" Vim now also uses the selection system clipboard for default yank/paste.
    "set clipboard+=unnamed
"endif
"vnoremap <C-c> "+y
" can use Maj+Inser to paste from system clipboard
" copying/pasting from the system clipboard will not work if
" :echo has('clipboard') returns 0

" http://stackoverflow.com/questions/2514445/turning-off-auto-indent-when-pasting-text-into-vim
"set copyindent
" http://superuser.com/questions/134709/how-can-i-keep-the-code-formated-as-original-source-when-i-paste-them-to-vim
set pastetoggle=<F4>

"On Mac OSX
"copy selected part: visually select text(type v or V in normal mode) and type :w !pbcopy
"copy the whole file :%w !pbcopy
"past from the clipboard :r !pbpaste

"On most Linux Distros, you can substitute:
"pbcopy above with xclip -i -sel c or xsel -i -b
"pbpaste using xclip -o -sel c or xsel -o -b
"
"-- Note: In case neither of these tools (xsel and xclip) are preinstalled on
"your distro, you can probably find them in the repos

"On linux this works with :w !xclip -sel c or :w !xsel -b –  Zeus77 yesterday
if executable('xsel')
    vnoremap <silent> <Leader>y :write !xsel -i -b<CR><CR>
    nnoremap <silent> <Leader>p :read !xsel -o -b<CR>
endif

" INDENTATION -----------------------------------------------------------------

" To convert tabs to space
" :set expandtab
" :retab!
" To convert spaces to tabs
" :set noexpandtab
" :retab!

set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

" FOLDING ---------------------------------------------------------------------

set foldenable "enable folds by default
set foldcolumn=2
set foldmethod=syntax
"set foldmethod=indent
set foldnestmax=10 "deepest fold is ten levels
"set nofoldenable "dont fold by default
"set foldlevel=1
set foldlevelstart=99 "open all folds by default
let g:xml_syntax_folding=1 "enable xml folding

" SEARCH & REPLACE ------------------------------------------------------------
" see :help /magic
noremap f /\V
noremap F ?\V
noremap / /\v
noremap ? ?\v
set ignorecase " case-insensitive search...
set smartcase " ... unless an uppercase character is typed
set incsearch
"set hlsearch
" clearing highlighted search
"nmap <silent> <leader><space> :nohlsearch<CR>

" TAGBAR ----------------------------------------------------------------------
nmap <F9> :TagbarToggle<CR>

" ULTISNIPS -------------------------------------------------------------------
"let g:UltiSnipsSnippetDirectories=["UltiSnips", "snippets_custom"]
"let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<tab>"
"let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
"let g:UltiSnipsListSnippets="<C-b>"

" STATUS LINE (AND AIRLINE) ---------------------------------------------------
set noshowmode
set wildmenu " enhanced command-line completion
set wildmode=list:longest
if exists('&wildignorecase')
    set wildignorecase
endif
set wildignore+=*.so,*.swp,*.zip,*.bz,*.bz2,*.gz
set laststatus=2
"set ruler "show line,column
set showcmd

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

" airline-whitespace
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#whitespace#mixed_indent_algo = 0
let g:airline#extensions#whitespace#symbol = '!'
let g:airline#extensions#whitespace#checks = [ 'indent', 'trailing' ]
let g:airline#extensions#whitespace#show_message = 1
let g:airline#extensions#whitespace#trailing_format = 'trailing[%s]'
let g:airline#extensions#whitespace#mixed_indent_format = 'mixed-indent[%s]'

" buffer name format

" The `unique_tail` algorithm will display the tail of the filename, unless
" there is another file of the same name, in which it will display it along
" with the containing parent directory.
"let g:airline#extensions#tabline#formatter = 'unique_tail'

" The `unique_tail_improved` - another algorithm, that will smartly uniquify
" buffers names with similar filename, suppressing common parts of paths.
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

" YOU COMPLETE ME -------------------------------------------------------------
let g:ycm_filetype_blacklist = {
      \ 'tagbar' : 1,
      \ 'qf' : 1,
      \ 'notes' : 1,
      \ 'markdown' : 1,
      \ 'unite' : 1,
      \ 'vimwiki' : 1,
      \ 'pandoc' : 1,
      \ 'infolog' : 1,
      \ 'mail' : 1
      \}
let g:ycm_complete_in_comments = 1

