filetype off

execute pathogen#infect()
execute pathogen#helptags()

let g:UltiSnipsSnippetDir="~/.vim/bundle/vim-snippets"

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

if !has('gui_running')
    set t_Co=256
endif

colorscheme solarized
let g:solarized_termtrans=1

hi Normal ctermbg=none
hi NonText ctermbg=none
" set t_Co=256
" let g:solarized_termcolors=256


let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'component': {
      \   'readonly': '%{&readonly?"":""}',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }


let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"

let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_pylint_args='--rcfile=./.pylint.rc'

let mapleader =","

let NERDTreeIgnore = ['\.pyc']

syntax enable " enable syntax highlighting

augroup CursorLine
  au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
      au WinLeave * setlocal nocursorline
  augroup END

set laststatus=2

set relativenumber

set foldmethod=indent

set foldlevelstart=99

set showcmd " show command in bottom bar

set ts=4 " set tabs to have 4 spaces
    
set autoindent " indent when moving to the next line while writing code

set expandtab "tabs are spaces 

set shiftwidth=4 " when using the >> or << commands, shift lines by 4 spaces

set background=dark

set showmatch " show the matching part of the pair for [] {} and ()

let python_highlight_all = 1 " enable all Python syntax highlighting features

filetype plugin indent on " kan se vilken filtyp

nnoremap <F1> :call ToggleRelativeRowNumbers()<cr>

nnoremap <F2> :TagbarToggle<cr>

nnoremap <F5> :call RunOrBuild()<cr>

nnoremap <F6> :call AutoPEP8()<cr>

nnoremap <F3> :NERDTreeToggle<cr>

" disabled h and l

nnoremap j gj

nnoremap k gk

"omnisharp / cs specific skit
augroup omnisharp_commands
    au!
    au CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()
    au FileType cs setlocal omnifunc=OmniSharp#Complete
    au FileType cs inoremap <C-N> <C-X><C-O>
augroup END

au FileType py let g:jedi#completions_command = "<C-N>"



function ToggleRelativeRowNumbers()
    if (&number==0)
        let &number=1
    elseif (&relativenumber==0)
        let &relativenumber=1
    else 
        let &number=0
        let &relativenumber=0
    endif
endfunction

function AutoPEP8()
    if (&ft=="python")
        :%!autopep8 %
        SyntasticCheck()
    elseif (&ft=="cs")
        :OmniSharpCodeFormat
        SyntasticCheck()
    endif
endfunction

function RunOrBuild()
    if (&ft=="python")
        :w
        :w !python2.7 %
    elseif (&ft=="cs")
        :OmniSharpBuildAsync
    endif
endfunction
