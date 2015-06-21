" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if has('vim_starting')
	if &compatible
		set nocompatible               " Be iMproved
	 endif
" Required:
	set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!
NeoBundle 'bling/vim-airline'
"NeoBundle 'tpope/vim-fugitive'
"NeoBundle 'Lokaltog/vim-easymotion'
"NeoBundle 'tpope/vim-rails.git'
"NeoBundle 'SirVer/ultisnips'
"NeoBundle 'honza/vim-snippets'
NeoBundle 'scrooloose/nerdcommenter'
"NeoBundle 'Valloric/YouCompleteMe'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'tpope/vim-surround'
NeoBundle 'flazz/vim-colorschemes'
"NeoBundle 'wincent/command-t'
"NeoBundle 'Raimondi/delimitMate'
NeoBundle 'evidens/vim-twig'
NeoBundle 'Shougo/neocomplete.vim'

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
"NeoBundleCheck

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
if exists('+colorcolumn')
	set colorcolumn=80
endif

" BEHAVIOUR  ------------------------------------------------------------------
filetype off " required with Vundle
"filetype indent on
" from http://wiki.contextgarden.net/Vim
let g:tex_flavor = "latex" " use latex flavor for all .tex files
syntax on " turn on syntax highlighting
set encoding=utf-8
set hidden " allow modified buffers in the background
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
nmap <silent> <leader>ee :vsplit $MYVIMRC<CR>
nmap <silent> <leader>ss :so $MYVIMRC<CR>
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
nnoremap <F5> :tabprevious<CR>
nnoremap <F6> :tabnext<CR>

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

if has('unnamedplus')
	set clipboard=unnamedplus,unnamed
else
	" Vim now also uses the selection system clipboard for default yank/paste.
	set clipboard+=unnamed
endif
"vnoremap <C-c> "+y
" can use Maj+Inser to paste from system clipboard
" copying/pasting from the system clipboard will not work if
" :echo has('clipboard') returns 0

" http://stackoverflow.com/questions/2514445/turning-off-auto-indent-when-pasting-text-into-vim
set copyindent

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
set foldcolumn=2
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
nmap <silent> <leader><space> :nohlsearch<CR>

" TAGBAR ----------------------------------------------------------------------
nmap <F9> :TagbarToggle<CR>

" ULTISNIPS -------------------------------------------------------------------
"let g:UltiSnipsSnippetDirectories=["UltiSnips", "snippets_custom"]
"let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<tab>"
"let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
"let g:UltiSnipsListSnippets="<C-b>"

" AIRLINE ---------------------------------------------------------------------
let g:airline#extensions#tabline#enabled = 1
set laststatus=2

" NEOCOMPLETE -----------------------------------------------------------------
" Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
"
" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : ''
\ }
" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
	let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g> neocomplete#undo_completion()
inoremap <expr><C-l> neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
"inoremap <silent><CR><C-r> = <SID>my_cr_function()<CR>
"function! s:my_cr_function()
	"return neocomplete#close_popup() . "\<CR>"
	" For no inserting <CR> key.
	"return pumvisible() ? neocomplete#close_popup() : "\<CR>"
"endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS>	neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y> neocomplete#close_popup()
inoremap <expr><C-e> neocomplete#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" For cursor moving in insert mode (Not recommended)
"inoremap <expr><Left> neocomplete#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
"inoremap <expr><Up> neocomplete#close_popup() . "\<Up>"
"inoremap <expr><Down> neocomplete#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplete#enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplete#enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
	let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'"'

