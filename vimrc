if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=ucs-bom,utf-8,latin1
endif

set nocompatible	" Use Vim defaults (much better!)
set bs=indent,eol,start		" allow backspacing over everything in insert mode
"set ai			" always set autoindenting on
"set backup		" keep a backup file
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
			" than 50 lines of registers
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time

" Only do this part when compiled with support for autocommands
if has("autocmd")
  augroup fedora
  autocmd!
  " In text files, always limit the width of text to 78 characters
  " autocmd BufRead *.txt set tw=78
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
  " don't write swapfile on most commonly used directories for NFS mounts or USB sticks
  autocmd BufNewFile,BufReadPre /media/*,/mnt/* set directory=~/tmp,/var/tmp,/tmp
  " start with spec file template
  autocmd BufNewFile *.spec 0r /usr/share/vim/vimfiles/template.spec
  augroup END
endif


if has("cscope") && filereadable("/usr/bin/cscope")
   set csprg=/usr/bin/cscope
   set csto=0
   set cst
   set nocsverb
   " add any database in current directory
   if filereadable("cscope.out")
      cs add $PWD/cscope.out
   " else add database pointed to by environment
   elseif $CSCOPE_DB != ""
      cs add $CSCOPE_DB
   endif
   set csverb
endif

" Switch syntax highlighting on, when the terminal has colorg
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

if &term=="xterm"
     set t_Co=8
     set t_Sb=[4%dm
     set t_Sf=[3%dm
endif

let python_highlight_all = 1
set t_Co=256
"autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
"set nu
"set foldcolumn=1

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'bling/vim-airline'
Plugin 'rosenfeld/conque-term'
Plugin 'klen/python-mode'
Plugin 'tpope/vim-fugitive'
call vundle#end()

filetype on
filetype plugin on
filetype plugin indent on

let g:pymode = 1
let g:pymode_rope = 1
let g:pymode_rope_completion = 1
let g:pymode_rope_complete_on_dot = 0
let g:pymode_rope_completion_bind = '<tab>'
let g:pymode_warnings = 1
let g:pymode_options = 0
let g:pymode_indent = 0
let g:pymode_syntax = 1
let g:pymode_lint = 1
let g:pymode_syntax_all = 1
let g:pymode_lint_checker = "pylint,pyflakes"
let g:pymode_lint_ignore="W191,E302,E251,E309,E128,E731,W391"
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all
let g:pymode_syntax_string_formatting = g:pymode_syntax_all
let g:pymode_syntax_string_format = g:pymode_syntax_all
let g:pymode_syntax_string_templates = g:pymode_syntax_all
let g:pymode_syntax_builtin_objs = g:pymode_syntax_all
let g:pymode_syntax_builtin_types = g:pymode_syntax_all
let g:pymode_syntax_highlight_exceptions = g:pymode_syntax_all
let g:pymode_syntax_docstrings = g:pymode_syntax_all
let g:pymode_syntax_doctests = g:pymode_syntax_all
let g:pymode_folding = 0
let g:pymode_lint_on_write = 1
let g:pymode_lint_cwindow = 0
let g:pymode_run = 1
let g:pymode_run_bind = '<leader>r'
let g:pymode_doc = 1
let g:pymode_doc_bind = '?'
"--------------------------------------------------------------

set tags+=tags,/root/repos/tests/tags

set ls=2
" illuminate over 80 symbols
augroup vimrc_autocmds
	autocmd!
	autocmd FileType ruby,python,javascript,c,cpp highlight Excess ctermbg=DarkGrey guibg=Black
	autocmd FileType ruby,python,javascript,c,cpp match Excess /\%80v.*/
	autocmd FileType ruby,python,javascript,c,cpp set nowrap
augroup END

set laststatus=2
"-----------------------------------------------------------
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'default'
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#empty_message = ''
let g:airline_powerline_fonts=1
let g:airline_detect_modified=1
let g:airline_detect_paste=1
let g:airline#extensions#branch#empty_message = ''
let g:airline#extensions#branch#displayed_head_limit = 30
let g:airline_enable_fugitive=1
let g:airline_left_sep = '>'
let g:airline_right_sep = '<'
let g:airline_linecolumn_prefix = '¶'
let g:airline_fugitive_prefix = 'V'
let g:airline_section_c = '%t'
let g:airline_section_x = ''
let g:airline_section_y = ''
"let g:airline_section_gutter = ''
"let g:airline_section_warning = ''
let g:airline#extensions#tabline#left_sep = '>'
let g:airline#extensions#tabline#left_alt_sep = '>'
let g:airline#extensions#tabline#right_sep = '<'
let g:airline#extensions#tabline#right_alt_sep = '<'
"---------------------------------------------------------
map <F4> :TagbarToggle<CR>
let g:tagbar_autofocus = 1
let g:tagbar_sort = 0
let g:tagbar_foldlevel = 0
"---------------------------------------------------------
map <F3> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\~$', '\.pyc$', '\.pyo$']
"---------------------------------------------------------
nnoremap <F5> :ConqueTermSplit ipython<CR>
nnoremap <F6> :exe "ConqueTermSplit ipython " . expand("%")<CR>
let g:ConqueTerm_StartMessages = 0
let g:ConqueTerm_CloseOnEnd = 0
"---------------------------------------------------------
autocmd FileType python map <buffer> <leader>8 :PymodeLint<CR>
autocmd FileType python map <buffer> <leader>9 :PymodeLintAuto<CR>
"---------------------------------------------------------
colorscheme darkblue

" Don't wake up system with blinking cursor:
" http://www.linuxpowertop.org/known.php
let &guicursor = &guicursor . ",a:blinkon0"

"set copyindent
"set preserveindent
set noexpandtab
"set softtabstop=0
"set shiftwidth=8
"set tabstop=4

function InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-x>\<c-o>"
    endif
endfunction

"imap <tab> <c-r>=InsertTabWrapper()<cr>
set complete=""
set complete+=.
set complete+=k
set complete+=b
set complete+=t
set completeopt-=preview
set completeopt+=longest

map <F2> <ESC>:w<CR>
imap <F2> <ESC>:w<CR>a
"-------- turn off sounds -------
set visualbell t_vb=

if &diff
	colorscheme murphy
endif
