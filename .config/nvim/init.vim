call plug#begin()

Plug 'mhinz/vim-startify'
Plug 'unblevable/quick-scope'

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'scrooloose/nerdcommenter'

Plug 'w0rp/ale'

" auto formatter
Plug 'rhysd/vim-clang-format'
Plug 'tpope/vim-surround'

" ctags indexer
Plug 'vim-scripts/DfrankUtil'
Plug 'vim-scripts/vimprj'
Plug 'vim-scripts/indexer.tar.gz'

" UltiSnips
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" web
Plug 'mattn/emmet-vim'
Plug 'alvan/vim-closetag'

" easy motion
Plug 'easymotion/vim-easymotion'

" matchit
Plug 'tmhedberg/matchit'
Plug 'raimondi/delimitmate'

" lightline
Plug 'itchyny/lightline.vim'

" php
" Plug 'phpactor/phpactor', {'for': 'php', 'do': 'composer install --no-dev -o'}
Plug 'StanAngeloff/php.vim', {'for': 'php'}
Plug 'adoy/vim-php-refactoring-toolbox', {'for': 'php'}
Plug 'roxma/LanguageServer-php-neovim',  {'do': 'composer install && composer run-script parse-stubs'}

" css-colors
Plug 'ap/vim-css-color'

" ts
Plug 'HerringtonDarkholme/yats.vim'

" coc
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

" fzf.vim
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

" unlet! skip_defaults_vim
" source ~/.config/nvim/defaults.vim

" Options (see :options)
" multi-byte characters (here so listchars works)
set encoding=utf-8

" moving around, searching and patterns
set path=.,**
set ignorecase
set smartcase
set number relativenumber

" tags
set tags=tags;/
set notagrelative

" displaying text
set fillchars+=vert:\ 
set lazyredraw
set list
set listchars=tab:►\ ,trail:·

" syntax, highlighting and spelling
set synmaxcol=200
set hlsearch
" set cursorline

" multiple windows
set laststatus=2
set statusline=
set statusline+=\ %f
set statusline+=\ %{&modified?'\ +':''}
set statusline+=\ %{&readonly?'\ ':''}
set statusline+=%=
set statusline+=\ %3p%%
set previewheight=5
set hidden
set splitbelow
set splitright

" terminal
set ttyfast

" messages and info
set terse
set noruler
set visualbell
set t_vb=

" selecting text
set clipboard^=unnamedplus,unnamed

" editing text
let g:ale_completion_enabled = 1
set undofile
set undodir=$HOME/.nvim/files/undodir
set textwidth=80
set formatoptions=qrnj1
set formatlistpat=^\\s*[\\[({]\\\?\\([0-9]\\+\\\|[iIvVxXlLcCdDmM]\\+\\\|[a-zA-Z]\\)[\\]:.)}]\\s\\+\\\|^\\s*[-+o*]\\s\\+
set complete=.,w,b,u,t,i,k,kspell,s
set omnifunc=ale#completion#OmniFunc
" set omnifunc=syntaxcomplete#Complete
set completeopt=menu,menuone,preview,noselect,noinsert
set pumheight=20
if has('unix')
    set dictionary=/usr/share/dict/spanish
    set dictionary+=/usr/share/dict/words
endif
set nojoinspaces

" tabs and indenting
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent

" folding
set foldlevel=99

" mapping
set timeoutlen=400
set ttimeoutlen=50

" reading and writing files
set fileformat=unix
set fileformats=unix
set nobackup
set nowritebackup
set autowrite
set autoread

" the swap file
set noswapfile

" command line editing
set wildmode=full
set wildignore+=*.swp,*.bak
set wildignore+=*.pyc,*.class,*.sln,*.Master,*.csproj,*.csproj.user,*.cache,*.dll,*.pdb,*.min.*,bundle.*
set wildignore+=*/.git/**/*,*/.hg/**/*,*/.svn/**/*
set wildignore+=*/min/*,*/vendor/*
set wildignore+=*/node_modules/*,*/bower_components/*
set wildignore+=*/java/*,*/target/*,*/out/*
set wildignore+=tags,cscope.*
set wildignore+=*.tar.*
set wildignorecase

" runnind make and jumping to errors
if executable('rg')
    set grepprg=rg\ --vimgrep
    set grepformat=%f:%l:%c:%m
elseif executable('ag')
    set grepprg=ag\ --vimgrep\ --ignore=\"**.min.js\"
    set grepformat=%f:%l:%c:%m,%f:%l:%m
elseif executable('ack')
    set grepprg=ack\ --nogroup\ --nocolor\ --ignore-case\ --column
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" quickscope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" UltiSnips
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"

" PHP7
let g:ultisnips_php_scalar_types = 1

" ################ NERDTree #########################

map <C-n> :NERDTreeToggle<CR>

" quit nerd tree on file open
let g:NERDTreeQuitOpen = 0

" show nerd tree always on the right
let g:NERDTreeWinPos = "left"

" close vim if only buffer is nerdree
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" auto opens nerd tree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

" various
set gdefault
set viminfo='100,n$HOME/.config/nvim/files/info/viminfo
set signcolumn=yes

" ############### SCRIPS ###########################

augroup AutoOpenQuickFix
    autocmd!
    autocmd QuickFixCmdPost [^l]* cwindow
augroup END

augroup GenTags
    autocmd!
    autocmd BufWritePost * call tags#GenTags()
augroup END


" Leader maps
let g:mapleader = "\<space>"

" Clear search highlights
nnoremap <leader>/ :noh<cr>

" Remove trailing whitespaces and blank lines
nnoremap <leader>s mz:silent! %s/\s\+$//<cr>:let @/='' <CR>`z
nnoremap <leader>S mz:silent! g/^\s*$/d<CR>`z

" Formats the whole buffer/the visual selection.
nnoremap <leader><leader> mzgg=G`z
xnoremap <leader><leader> =

" Align visual selection
xnoremap <silent> <leader>/ :<C-u>silent call utils#Align()<CR>

" Edit config file
nnoremap <leader>v :e $HOME/.config/nvim/init.vim<CR>

" F-# maps
" Spell
nnoremap <F8> :setlocal spell! spelllang=en_us<CR>
nnoremap <F9> :setlocal spell! spelllang=es<CR>

" Terminal
nnoremap <F10> :cwindow<CR>
nnoremap <F11> :lwindow<CR>
nnoremap <F12> :terminal<CR>

" Others
" Y like C and D
nnoremap Y y$

" Keep the center
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" Substitute
nnoremap gs :%s/\v

" [S]plit line (sister to [J]oin lines). cc still substitutes the line like S would
nnoremap S i<CR><Esc>

" Make
nnoremap <CR> :silen make % <CR> :silen redraw! <CR>

" Custom text objects
for s:char in [ '_', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '%', '-', '#' ]
    execute 'xnoremap i' . s:char . ' :<C-u>normal! T' . s:char . 'vt' . s:char . '<CR>'
    execute 'onoremap i' . s:char . ' :normal vi' . s:char . '<CR>'
    execute 'xnoremap a' . s:char . ' :<C-u>normal! F' . s:char . 'vf' . s:char . '<CR>'
    execute 'onoremap a' . s:char . ' :normal va' . s:char . '<CR>'
endfor

" ALE
let g:ale_completion_enabled = 1
let g:ale_sign_column_always = 1
let g:ale_sign_error = '●'
let g:ale_sign_warning = '●'
let g:ale_sign_column_always = 1
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
highlight ALEErrorSign ctermbg=none ctermfg=red
highlight ALEWarningSign ctermbg=none ctermfg=yellow
nnoremap <C-]> :ALEGoToDefinition<cr>
nnoremap <C-]>v :ALEGoToDefinitionInVSplit<cr>
nnoremap <C-f> :ALEFindReferences<cr>
nnoremap <C-h> :ALEHover<cr>

" Rg
autocmd VimEnter * command! -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)


" QF
let g:qf_mapping_ack_style = 1
let g:qf_statusline = {}
let g:qf_statusline.before = '%<\ '
let g:qf_statusline.after = '\ %f%=%l\/%-6L\ \ \ \ \ '

nmap [w <Plug>(qf_loc_previous)
nmap ]w <Plug>(qf_loc_next)
nmap [q <Plug>(qf_qf_previous)
nmap ]q <Plug>(qf_qf_next)

" Fzf
nnoremap <leader>p :Files<CR>
nnoremap <leader>t :Tags<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>n :Snippets<CR>

" Rg
nnoremap <leader>a :Rg<space>
nnoremap <leader>A :exec "Rg ".expand("<cword>")<cr>

" Matchit
packadd! matchit

" Mapping U to Redo
noremap U <c-r>
noremap <c-r> <NOP>

" window navigation
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
nnoremap <C-H> <C-W>h

" tabs mappings
nnoremap tn :tabnew<Space>
nnoremap tk :tabnext<CR>
nnoremap tj :tabprev<CR>
nnoremap th :tabfirst<CR>
nnoremap tl :tablast<CR>

nmap <silent> <F2> :.!figlet<CR>

" ================ Splits =========================== 

set splitbelow splitright

" Make adjusting split sizes a bit more friendly
noremap <silent> <C-Left> :vertical resize -5<CR>
noremap <silent> <C-Right> :vertical resize +5<CR>
noremap <silent> <C-Up> :resize -5<CR>
noremap <silent> <C-Down> :resize +5<CR>

" Change 2 split windows from vert or horiz to vert
map <Leader>th <C-w>t<C-w>H
map <Leader>tk <C-w>t<C-w>K

" Open split terminal
map <Leader>tt :vnew term://bash<CR>

" dont use arrow keys
nnoremap <Up> :echomsg "use k"<CR>
nnoremap <Down> :echomsg "use j"<CR>
nnoremap <Left> :echomsg "use h"<CR>
nnoremap <Right> :echomsg "use l"<CR>
