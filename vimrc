" forget being compatible with good ol'vi
set nocompatible

if filereadable(expand("~/.vim/bundle/Vundle.vim/README.md"))
	" set the runtime path to include Vundle and initialize
	set rtp+=~/.vim/bundle/Vundle.vim/
	call vundle#begin()
	"  alternatively, pass a path where Vundle should install bundles
	" let path = '~/some/path/here'
	"call vundle#rc(path)

	" let Vundle manage Vundle, required
	Plugin 'gmarik/Vundle.vim'

	" The following are examples of different formats supported.
	" Keep bundle commands between here and filetype plugin indent on.

	" scripts on GitHub repos
	" Plugin 'tpope/vim-fugitive'
	" Plugin 'Lokaltog/vim-easymotion'
	" Plugin 'tpope/vim-rails.git'
	Plugin 'SirVer/ultisnips'
	Plugin 'honza/vim-snippets'
	Plugin 'scrooloose/nerdcommenter'
	Plugin 'Valloric/YouCompleteMe'
	Plugin 'majutsushi/tagbar'
	Plugin 'tpope/vim-surround'
	Plugin 'flazz/vim-colorschemes'
	Plugin 'wincent/command-t'
	" The sparkup vim script is in a subdirectory of this repo called vim.
	" Pass the path to set the runtimepath properly.
	"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

	" scripts from http://vim-scripts.org/vim/scripts.html
	"Plugin 'L9'
	"Plugin 'FuzzyFinder'

	" scripts not on GitHub
	"Plugin 'git://git.wincent.com/command-t.git'

	" git repos on your local machine (i.e. when working on your own plugin)
	"Plugin 'file:///home/gmarik/path/to/plugin'

	" All of your Plugins must be added before the following line
	call vundle#end() " required

	"filetype plugin indent on " required
	" To ignore plugin indent changes, instead use:
	filetype plugin on

	" Brief help
	" :PluginList          - list configured bundles
	" :PluginInstall(!)    - install (update) bundles
	" :PluginSearch(!) foo - search (or refresh cache first) for foo
	" :PluginClean(!)      - confirm (or auto-approve) removal of unused bundles

	" see :h vundle for more details or wiki for FAQ
	" NOTE: comments after Plugin commands are not allowed.
	" Put your stuff after this line
	echom "Plugins loaded with Vundle!"
endif

" APPEARANCE  -----------------------------------------------------------------
"set background=dark
set t_Co=256 " 256 colors terminal
"let g:zenburn_terminal_Background=1 " no background
"let g:zenburn_high_Contrast=1
"let g:zenburn_old_Visual=1
colorscheme jellybeans
set cursorline " highlight the line the cursor is on
set title " show filename in terminal title

" long lines handling / right margin
"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\%80v.\+/
set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=80

" BEHAVIOUR  ------------------------------------------------------------------
filetype off " required with Vundle
"filetype indent on
" from http://wiki.contextgarden.net/Vim
let g:tex_flavor = "latex" " use latex flavor for all .tex files
syntax on " turn on syntax highlighting
set encoding=utf-8
set hidden " allow modified buffers in th background
set lazyredraw " Don't update the display while executing macros
set scrolloff=5 " minimum lines to keep above and below cursor
set showmode
set ruler "show line,column
set showcmd
set wildmenu " enhanced command-line completion
let mapleader="," " change the mapleader from \ to ,
set backspace=indent,eol,start " backspace for dummies 
set mouse=a " unleash the rodent
" Quickly edit/reload the vimrc file
nmap <silent> <leader>ee :vsplit $MYVIMRC<cr>
nmap <silent> <leader>ss :so $MYVIMRC<cr>
" spell checking and automatic wrapping at 72 columns to git commit messages
autocmd Filetype gitcommit setlocal spell textwidth=72

" where backup files are kept
set backupdir=~/.vim/backup
set directory=~/.vim/backup
"set noswapfile

" WINDOWS ---------------------------------------------------------------------
map <C-h> <C-w>h<C-w>
map <C-j> <C-w>j<C-w>
map <C-k> <C-w>k<C-w>
map <C-l> <C-w>l<C-w>
" moves around split windows
nnoremap <leader>w <C-w><C-w>

" BUFFERS ---------------------------------------------------------------------
" switches around buffers
nnoremap <F2> :bp<CR>
nnoremap <F3> :bn<CR>

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

" See :help clipboard for more detailed information.
set clipboard=unnamedplus
"vnoremap <C-c> "+y
" can use Maj+Inser to paste from system clipboard
" copying/pasting from the system clipboard will not work if
" :echo has('clipboard') returns 0
"vmap <C-C> "+y
"map <C-V> <esc>"+p
"imap <C-V> <esc>"+pi
"nnoremap ; :
" Enable/Disable paste mode, where data won't be autoindented

" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" ARROW KEYS ------------------------------------------------------------------
"noremap <up> <nop>
"inoremap <up> <nop>
"noremap <down> <nop>
"inoremap <down> <nop>
"noremap <left> <nop>
"noremap <right> <nop>
"inoremap <left> <nop>
"inoremap <right> <nop>
" B-A-<start>

nnoremap j gj
nnoremap k gk

" LINE NUMBERS ----------------------------------------------------------------
set number

" INDENTATION -----------------------------------------------------------------
set tabstop=4
set shiftwidth=4
set noexpandtab

" FOLDING ---------------------------------------------------------------------
set foldmethod=indent
set foldnestmax=10 "deepest fold is ten levels
set nofoldenable "dont fold by default
set foldlevel=1
" shortcuts za - zr (?)

" SEARCH & REPLACE ------------------------------------------------------------
" move toward more pythonic regex
nnoremap / /\v
vnoremap / /\v
set ignorecase " case-insensitive search...
set smartcase " ... unless an uppercase character is typed
set incsearch
"set showmatch
set hlsearch
" clearing highlighted search
nmap <silent> <leader><space> :nohlsearch<cr>

" TAGBAR ----------------------------------------------------------------------
" majutsushi.github.com/tagbar/
nmap <F9> :TagbarToggle<cr>

" ULTISNIPS -------------------------------------------------------------------
let g:UltiSnipsSnippetDirectories=["UltiSnips", "snippets_custom"]
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsListSnippets="<C-b>"
