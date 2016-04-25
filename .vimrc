
" set mouse=a
set nocompatible
let mapleader=" "
execute pathogen#infect()
let fortran_free_source=1
filetype plugin indent on
syntax on
set cursorline
set wrap
set tabstop=4
set shiftwidth=4
set expandtab
set splitbelow
set splitright
set hlsearch

" buffers
let g:airline#extensions#tabline#enabled = 1
" Move to the next buffer
nmap <leader>l :bnext<CR>
" Move to the previous buffer
nmap <leader>h :bprevious<CR>

" eye candy
set t_Co=256

let g:gruvbox_bold=1
let g:gruvbox_italic=1
let g:gruvbox_contrast_light='hard'

function! CopyMatches(reg)
  let hits = []
  %s//\=len(add(hits, submatch(0))) ? submatch(0) : ''/ge
  let reg = empty(a:reg) ? '+' : a:reg
  execute 'let @'.reg.' = join(hits, "\n") . "\n"'
endfunction
command! -register CopyMatches call CopyMatches(<q-reg>)

function TextMode()
    set nocursorline
    set colorcolumn=73
    set tw=72
    "noremap k gk
    "noremap j gj
    set spell spelllang=en_us
    let terminal_emulator=system("ps -o comm= -p \"$(($(ps -o ppid= -p \"$(($(ps -o sid= -p \"$$\")))\")))\"")
    hi Normal ctermbg=none
    "if terminal_emulator=="lilyterm\n"
    "   hi Normal ctermbg=none
    "endif
endfunction

function Set_PaperColorTheme()
    set background=light
    colorscheme PaperColor
    " correct PaperColor's issue with spell
    hi SpellBad cterm=underline
    hi SpellLocal cterm=underline
endfunction


if $VIM_LIGHT
    call Set_PaperColorTheme()
else
    " set background=dark
    set background=light
    colorscheme gruvbox
endif

" special characters
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set list

" split navigations
nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
" Enable folding
set foldmethod=indent
set foldlevel=99

" pandoc
augroup pandoc_syntax
    au! BufNewFile,BufFilePRe,BufRead *.md set filetype=markdown.pandoc
augroup END

" for python
"autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
"autocmd BufRead *.py set nocindent
au BufNewFile,BufRead *.py call Pyth()
function Pyth()
    set tabstop=4
    set softtabstop=4
    set shiftwidth=4
    set textwidth=79
    set expandtab
    set autoindent
    set fileformat=unix
    normal m`:%s/\s\+$//e ``
    ab ipd import ipdb; ipdb.set_trace()
    ab fxl for x in range(len(x)):
endfunction

" mutt
au BufRead /tmp/mutt-* call Mutt()
function Mutt()
    set tw=72
    set spell spelllang=en_us,ru
    set background=light
    " call Set_PaperColorTheme()
endfunction

" tagbar
nmap <F8> :TagbarToggle<CR>
" It's useful to show the buffer number in the status line.
set laststatus=2 statusline=%02n:%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

" set linespace=5
" gvim stuff
set guifont=Envy\ Code\ R\ 11
function! ToggleGUICruft()
    if &guioptions=='i'
        exec('set guioptions=imTrL')
    else
        exec('set guioptions=i')
    endif
endfunction
map <F11> <Esc>:call ToggleGUICruft()<cr>
" by default, hide gui menus
set guioptions=i


