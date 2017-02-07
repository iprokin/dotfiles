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

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }

" special characters
" set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set list

" Enable folding
set foldmethod=indent
set foldlevel=99

" It's useful to show the buffer number in the status line.
set laststatus=2 statusline=%02n:%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

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

" split navigations
nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

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
    "ab ipdb import ipdb; ipdb.set_trace()
    ab ipdb from IPython.core.debugger import Tracer; Tracer()()
    ab pdb import pdb; pdb.set_trace()
    ab inp import numpy as np
    ab ipd import pandas as pd
    ab fxl for x in range(len(x)):
    ab iplt import matplotlib.pyplot as plt
endfunction

function OneSentencePerLine()
    execute '%s/\([a-z-:;]\) *\n *\([a-z-:;]\)/\1 \2/g'
    execute '%s/\([.!?]\)[ \n]*\([A-Z]\|\[\)/\1\r\2/g'
    execute '%s/ \+/ /g'
    execute '%s/\v^ +//g'
endfunction

" function OneSentencePerLineVis()
"     execute 's/\([a-z-:;]\) \*\n *\([a-z-:;]\)/\1 \2/g'
"     execute 's/\([.!?]\)[ \n]\*\([A-Z]\|\[\)/\1\r\2/g'
"     execute 's/ \+/ /g'
"     execute 's/\v^ +//g'
" endfunction

function SoftWrap()
    set wrap
    set linebreak
    set textwidth=0
    set wrapmargin=0
endfunction

" mutt
au BufRead /tmp/mutt-* call Mutt()
function Mutt()
    set tw=72
    set linebreak
    set spell spelllang=en_us,fr,ru
    set background=light
    ab crd Cordialement,
    ab br Best Regards
    ab bnj Bonjour
    ab mb maybe
    " call Set_PaperColorTheme()
endfunction

" tagbar
nmap <F8> :TagbarToggle<CR>

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

function! CopyMatches(reg)
  let hits = []
  %s//\=len(add(hits, submatch(0))) ? submatch(0) : ''/ge
  let reg = empty(a:reg) ? '+' : a:reg
  execute 'let @'.reg.' = join(hits, "\n") . "\n"'
endfunction
command! -register CopyMatches call CopyMatches(<q-reg>)

function TextMode()
    set nocursorline
    "set colorcolumn=73
    "set tw=72
    call SoftWrap()
    "noremap k gk
    "noremap j gj
    set spell spelllang=en_us
    let terminal_emulator=system("ps -o comm= -p \"$(($(ps -o ppid= -p \"$(($(ps -o sid= -p \"$$\")))\")))\"")
    "hi Normal ctermbg=none
    "if terminal_emulator=="lilyterm\n"
    "   hi Normal ctermbg=none
    "endif
    "let g:citation_vim_bibtex_file=["/home/ilya/Sync/PhD/Documents_PhD/phd_thesis_markdown/source/references.bib"]
    "let g:citation_vim_mode="bibtex"
    "nmap u [unite] nnoremap [unite]
    "nnoremap <silent>[unite]c       :<C-u>Unite -buffer-name=citation   -start-insert -default-action=append      bibtex<cr>
    "nmap <leader>c       :<C-u>Unite -buffer-name=citation   -start-insert -default-action=append      bibtex<cr>
endfunction

function ReplaceELIFE()
    execute '%s/\v([0-9\.]+)±([0-9\.]+)/$\1\\pm\2$/g'
    execute '%s/tLTD/t-LTD/g'
    execute '%s/tLTP/t-LTP/g'
    execute '%s/μ/$\\mu$/g'
    execute '%s/N\~pairings\~/$N_{pairings}$/g'
    execute '%s/Δt\~STDP\~/$\Delta t$/g'
    execute '%s/&gt;/>/g'
    execute '%s/&lt;/</g'
    execute '%s/τ/$\\tau$/g'
    execute '%s/\*W\*\~total\~/$W_{total}$/g'
    execute '%s/\*W\*\~post\~/$W_{post}$/g'
    execute '%s/\*W\*\~pre\~/$W_{pre}$/g'
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
