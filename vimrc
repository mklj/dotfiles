" Skip initialization for vim-tiny or vim-small.
if 0 | endif

if &compatible
    set nocompatible
endif
set all& "reset everything to their defaults

" ======= plugins manager initialization
call plug#begin('~/.vim/plugins')

" ======= functions
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

function! <SID>StripTrailingWhitespaces()
    call Preserve("%s/\\s\\+$//e")
endfunction
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" ======= appearance
set t_Co=256 " 256 colors terminal
set cursorline " highlight the line the cursor is on
set titlestring=%t
set title " show filename in terminal title
syntax enable
set encoding=utf-8
set noerrorbells
set novisualbell
"set t_vb=
if exists('+colorcolumn')
    set colorcolumn=80,120
endif

" ======= behaviour
let mapleader="," " change the mapleader from \ to ,
set hidden " allow modified buffers in the background
set autoread "auto reload if file saved externally
set lazyredraw " Don't update the display while executing macros
set scrolloff=3 " minimum lines to keep above and below cursor
set scrolljump=5 "minimum number of lines to scroll
"set showmatch
set number
set relativenumber
set mouse=a " unleash the rodent
set ttymouse=xterm2
set backspace=indent,eol,start "allow backspacing everything in insert mode
nnoremap <F1> <nop>
nnoremap Q <nop>
nnoremap K <nop>

" ======= filetypes
" git commit messages: spell checking and automatic wrapping at 72 columns
autocmd Filetype gitcommit setlocal spell textwidth=72
" use latex flavor for all .tex files
let g:tex_flavor = "latex"
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd BufNewFile,BufReadPost *.sls set filetype=yaml
autocmd BufNewFile,BufReadPost *.conf set filetype=conf

" where backup files are kept
set backupdir=~/.vim/backup
set directory=~/.vim/swap

set wrap
set textwidth=79
set formatoptions=qn1
set viminfo='50,n~/.vim/viminfo

inoremap jj <ESC>
cmap w!! w !sudo tee % >/dev/null

" ======= buffers, windows
nnoremap <F2> :bprevious<CR>
nnoremap <F3> :bnext<CR>
nnoremap <F5> :tabprevious<CR>
nnoremap <F6> :tabnext<CR>
nnoremap <Leader>d :bdelete<CR>
" moves around split windows
nnoremap <leader>w <C-w><C-w>

" ======= moving around
" Treat long lines as break lines (useful when moving around in them)
noremap j gj
noremap k gk
" see :help /magic
noremap / /\V
noremap ? ?\V
noremap f /\v
noremap F ?\v
set ignorecase " case-insensitive search...
set smartcase " ... unless an uppercase character is typed
set incsearch
"set hlsearch
" clearing highlighted search
"nmap <silent> <leader><space> :nohlsearch<CR>

" allows incsearch highlighting for range commands
cnoremap $t <CR>:t''<CR>
cnoremap $T <CR>:T''<CR>
cnoremap $m <CR>:m''<CR>
cnoremap $M <CR>:M''<CR>
cnoremap $d <CR>:d<CR>

" EASYMOTION ------------------------------------------------------------------
"Plug 'easymotion/vim-easymotion'

"let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Bi-directional find motion
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
"nmap f <Plug>(easymotion-s)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
"nmap f <Plug>(easymotion-s2)

" Turn on case insensitive feature
"let g:EasyMotion_smartcase = 1

" JK motions: Line motions
"map <Leader>j <Plug>(easymotion-j)
"map <Leader>k <Plug>(easymotion-k)

" <Leader>f{char} to move to {char}
"map  f <Plug>(easymotion-bd-f)
"nmap f <Plug>(easymotion-overwin-f)


" s{char}{char} to move to {char}{char}
"nmap s <Plug>(easymotion-overwin-f2)

" Move to line
"map <Leader>L <Plug>(easymotion-bd-jk)
"nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
"map  w <Plug>(easymotion-bd-w)
"nmap w <Plug>(easymotion-overwin-w)

" ======= copy - paste

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
"nmap <silent> <leader>p :set paste<CR>"*p:set nopaste<CR>

"On Mac OSX
"copy selected part: visually select text(type v or V in normal mode) and type :w !pbcopy
"copy the whole file :%w !pbcopy
"past from the clipboard :r !pbpaste

"On most Linux Distros, you can substitute:
"pbcopy above with xclip -i -sel c or xsel -i -b
"pbpaste using xclip -o -sel c or xsel -o -b

"On linux this works with :w !xclip -sel c or :w !xsel -b –  Zeus77 yesterday
if executable('xclip')
    vnoremap <silent> <Leader>y :write !xclip -i -selection clipboard<CR><CR>
    nnoremap <silent> <Leader>p :read !xclip -o -selection clipboard<CR>
endif

" D deletes from the cursor to the end of the line; C changes from the cursor
" to the end of the line. For some reason, however, Y yanks the entire line,
" both before and after the cursor. We don't want this.
nnoremap Y y$

" ======= indentation
" To convert tabs to space
" :set expandtab
" :retab!
" To convert spaces to tabs
" :set noexpandtab
" :retab!

" tabstop: How many columns a tab should be made up of in the editor view, it
" takes care only of how tabs will be rendered and has no effect on the actual
" text.
set tabstop=4
" expandtab: Enabling this option will insert the appropriate number of spaces
" when in insert mode.
set noexpandtab
" shiftwidth: how many columns text will be indented when using indent
" operations (such as << or >>) in normal or visual mode; this also covers
" automatic C-style indentation.
set shiftwidth=4
" softtabstop: results in different behaviours depending on its own value and
" the one set for tabstop and the status of the expandtab toggle:
"     * softtabstop < tabstop, noexpandtab - This will result in a combination
"     of tabs and spaces to make up the total spacing
"     * softtabstop == tabstop, noexpandtab - This will always force the use of
"     tabs
"     * expandtab - The value of softtabstop will be ignored and spaces will be
"     forced
set softtabstop=4

" Tabs and spaces visibility
" trailing whitespace appears red
"autocmd syntax * syntax match ExtraWhitespace /\s\+$\| \+\ze\t/ containedin=ALL
"autocmd colorscheme * highlight ExtraWhitespace ctermbg=red guibg=red
" tabs are underlined
"autocmd syntax * syntax match Tab /\t/ containedin=ALL
"autocmd colorscheme * highlight Tab cterm=underline gui=underline

" ======= folding
set foldenable "enable folds by default
set foldcolumn=2
set foldmethod=indent
set foldnestmax=10 "deepest fold is ten levels
"set foldlevel=1
set foldlevelstart=99 "open all folds by default
let g:xml_syntax_folding=1 "enable xml folding

" commands to convert between spaces and tabs :
" Space2Tab 	Convert spaces to tabs, only in indents.
" Tab2Space 	Convert tabs to spaces, only in indents.
" RetabIndent 	Execute Space2Tab (if 'expandtab' is set), or Tab2Space (otherwise).
" Each command accepts an argument that specifies the number of spaces in a tab
" column. By default, the 'tabstop' setting is used.
"
" Return indent (all whitespace at start of a line), converted from
" tabs to spaces if what = 1, or from spaces to tabs otherwise.
" When converting to tabs, result has no redundant spaces.
function! Indenting(indent, what, cols)
  let spccol = repeat(' ', a:cols)
  let result = substitute(a:indent, spccol, '\t', 'g')
  let result = substitute(result, ' \+\ze\t', '', 'g')
  if a:what == 1
    let result = substitute(result, '\t', spccol, 'g')
  endif
  return result
endfunction

" Convert whitespace used for indenting (before first non-whitespace).
" what = 0 (convert spaces to tabs), or 1 (convert tabs to spaces).
" cols = string with number of columns per tab, or empty to use 'tabstop'.
" The cursor position is restored, but the cursor will be in a different
" column when the number of characters in the indent of the line is changed.
function! IndentConvert(line1, line2, what, cols)
  let savepos = getpos('.')
  let cols = empty(a:cols) ? &tabstop : a:cols
  execute a:line1 . ',' . a:line2 . 's/^\s\+/\=Indenting(submatch(0), a:what, cols)/e'
  call histdel('search', -1)
  call setpos('.', savepos)
endfunction

command! -nargs=? -range=% Space2Tab call IndentConvert(<line1>,<line2>,0,<q-args>)
command! -nargs=? -range=% Tab2Space call IndentConvert(<line1>,<line2>,1,<q-args>)
command! -nargs=? -range=% RetabIndent call IndentConvert(<line1>,<line2>,&et,<q-args>)

" ======= status line
set noshowmode
set wildmenu " enhanced command-line completion
if exists('&wildignorecase')
    set wildignorecase
endif
set wildmode=longest,list
set wildignore+=*.so,*.swp,*.zip,*.bz,*.bz2,*.gz
set laststatus=2
"set ruler "show line,column
set showcmd
" plugin: bling/vim-airline
Plug 'bling/vim-airline'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

" airline-whitespace
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#whitespace#symbol = '!'
let g:airline#extensions#whitespace#checks = [ 'indent', 'trailing' ]
let g:airline#extensions#whitespace#show_message = 1
let g:airline#extensions#whitespace#trailing_format = 'trailing[%s]'
let g:airline#extensions#whitespace#mixed_indent_format = 'mixed-indent[%s]'

" buffer name format

" The `unique_tail` algorithm will display the tail of the filename, unless
" there is another file of the same name, in which it will display it along
" with the containing parent directory.
let g:airline#extensions#tabline#formatter = 'unique_tail'

" The `unique_tail_improved` - another algorithm, that will smartly uniquify
" buffers names with similar filename, suppressing common parts of paths.
    "let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

" ======= plugin: Shougo/unite.vim
if v:version > 702
    Plug 'Shougo/unite.vim'
    Plug 'Shougo/neoyank.vim'
    Plug 'tsukkee/unite-help'
    Plug 'Shougo/unite-outline'

    let g:unite_source_history_yank_enable = 1

    if executable('grep')
        let g:unite_source_grep_command='grep'
        let g:unite_source_grep_default_opts='-i --color=auto --line-number'
        let g:unite_source_grep_recursive_opt='-iR --color=auto --line-number'
    endif

    nnoremap <Leader>l :Unite -start-insert buffer file_rec/async:!<CR>
    nnoremap <Leader>g :Unite grep:! -auto-preview<CR>
    nnoremap <Leader>r :Unite history/yank<CR>
    nnoremap <Leader>b :Unite -quick-match buffer:!<CR>
    nnoremap <Leader>o :Unite outline<CR>
    nnoremap <Leader>h :Unite help<CR>
endif

" ======= completion
" neocomplete if lua is available, neocomplcache otherwise

if has('lua')
    Plug 'Shougo/neocomplete.vim'
    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#enable_smart_case = 1
    let g:neocomplete#sources#syntax#min_keyword_length = 3
else
    Plug 'Shougo/neocomplcache.vim'
    let g:neocomplcache_enable_at_startup=1
    let g:neocomplcache_enable_fuzzy_completion=1
endif

" shared key mappings
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" =======
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'evidens/vim-twig'
"Plug 'majutsushi/tagbar'
"nmap <F9> :TagbarToggle<CR>
Plug 'scrooloose/nerdcommenter'
map <leader>? <Plug>NERDCommenterToggle<CR>
Plug 'tpope/vim-surround'

Plug 'kien/rainbow_parentheses.vim'
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" colorschemes
Plug 'arcticicestudio/nord-vim'
Plug 'chriskempson/tomorrow-theme'
Plug 'cocopon/iceberg.vim'
Plug 'jacoborus/tender.vim'
Plug 'jnurmine/Zenburn'
Plug 'joshdick/onedark.vim'
Plug 'lokaltog/vim-distinguished'
Plug 'mhinz/vim-janah'
autocmd ColorScheme janah highlight Normal ctermbg=235
Plug 'morhetz/gruvbox'
Plug 'nanotech/jellybeans.vim'
Plug 'nlknguyen/papercolor-theme'
Plug 'reedes/vim-colors-pencil'
Plug 'reewr/vim-monokai-phoenix'
Plug 'sjl/badwolf'
Plug 'tomasr/molokai'
Plug 'vim-scripts/calmar256-lightdark.vim'
Plug 'vim-scripts/mayansmoke'
Plug 'vim-scripts/wombat256.vim'
Plug 'w0ng/vim-hybrid'
Plug 'zeis/vim-kolor'
Plug 'jamessan/vim-gnupg'

" ======= end of initialization
call plug#end()

"filetype plugin indent on " vim-plug already does that in plug#end()
set background=dark
colorscheme gruvbox

