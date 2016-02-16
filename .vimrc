" set mouse=a
execute pathogen#infect()
let fortran_free_source=1
filetype plugin indent on
syntax on
set tabstop=4
set shiftwidth=4
set expandtab
set splitbelow
set splitright
set hlsearch
" eye candy
set t_Co=256
set background=dark
let g:gruvbox_contrast_light='hard'
let g:solarized_termcolors=256
" set background=light
colorscheme gruvbox
" colorscheme PaperColor
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
    set background=light
    colorscheme PaperColor
    set spell spelllang=en_us,ru
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
