if &compatible
  set nocompatible
endif


" dein.vim

let s:dein_dir = expand('~/.vim/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
endif
execute 'set runtimepath^=' . s:dein_repo_dir


call dein#begin(s:dein_dir)

let s:toml_path = '~/.vim/dein.toml'
let s:toml_lazy_path = '~/.vim/deinlazy.toml'

if dein#load_cache([expand('<sfile>', s:toml_path, s:toml_lazy_path)])
  call dein#load_toml(s:toml_path, {'lazy': 0})
  call dein#load_toml(s:toml_lazy_path, {'lazy': 1})
  call dein#save_cache()
endif

call dein#end()

if dein#check_install()
  call dein#install()
endif

filetype plugin indent on


" Options

if exists('&ambiwidth')
  set ambiwidth=double
endif

set title
set number
set ruler
set cursorline
set laststatus=2
set showcmd

set wrap
set nowrapscan
set whichwrap=b,s,h,l,<,>,[,]

set showmatch
set matchpairs& matchpairs+=<:>

set backspace=indent,eol,start

set incsearch
set hlsearch | nohlsearch
set ignorecase
set smartcase

set smarttab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set shiftround
set autoindent
set smartindent

set noerrorbells
set novisualbell

set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,iso-2022-jp,cp932,sjis,euc-jp
set fileformats=unix,dos,mac

set foldmethod=manual
set textwidth=0
set wildmenu


" For white spaces

function! s:hl_trailing_spaces()
  highlight! link TrailingSpaces Error
  syntax match TrailingSpaces containedin=ALL /\s\+$/
endfunction
function! s:hl_zenkaku()
  highlight! link ZenkakuSpace Error
  syntax match ZenkakuSpace containedin=ALL /　/
endfunction

autocmd BufWinEnter,ColorScheme,Syntax * call s:hl_trailing_spaces()
autocmd BufWinEnter,ColorScheme,Syntax * call s:hl_zenkaku()

function! s:remove_trailing_white_spaces()
  let pos = winsaveview()
  silent! execute '%s/\s\+$//g'
  call winrestview(pos)
endfunction
command! RemoveTrailingWhiteSpaces call <SID>remove_trailing_white_spaces()
command! -range=% TrimSpace  <line1>,<line2>s!\s*$!!g | nohlsearch
command! -range=% RemoveTrailM  <line1>,<line2>s!\r$!!g | nohlsearch


" Colorscheme

set t_Co=256
colorscheme jellybeans
set background=dark
let g:jellybeans_overrides = {
\    'Search': {'attr': 'BOLD',
\               '256ctermfg': '255', '256ctermbg': '125'}
\ }
syntax enable


" Backup

set backup
if !isdirectory($HOME."/.vim_backup")
  call mkdir($HOME."/.vim_backup", "p")
endif
set backupdir=$HOME/.vim_backup
if !isdirectory($HOME."/.vim_swap")
  call mkdir($HOME."/.vim_swap", "p")
endif
set directory=$HOME/.vim_swap
if has('persistent_undo')
    if !isdirectory($HOME.'/.vim_undo')
        call mkdir($HOME.'/.vim_undo', 'p')
    endif
    set undofile
    set undoreload=1000
    set undodir=~/.vim_undo
endif
set writebackup
set history=1024


" Key maps

nnoremap ; <Nop>
xnoremap ; <Nop>
let mapleader = ';'

nnoremap j gj
nnoremap k gk
nnoremap <Leader>J J
nnoremap <Leader>K K
nnoremap J <Nop>
nnoremap K <Nop>

nnoremap <C-u> zz<C-u>
nnoremap <C-d> zz<C-d>
nnoremap G Gzz

inoremap  <C-a> <Home>
inoremap  <C-e> <End>
inoremap  <C-b> <Left>
inoremap  <C-f> <Right>
inoremap  <C-p> <Up>
inoremap  <C-n> <Down>
inoremap  <C-d> <Del>
inoremap  <C-u> <C-o>d0
inoremap  <C-k> <C-o>d$

inoremap jj <Esc>
cnoremap jj <Esc>
nnoremap <silent> <Esc><Esc> :<C-u>nohlsearch<CR>

cnoreabbrev w!! w !sudo tee > /dev/null %


" Plugins

if dein#tap('unite.vim')
  let g:unite_enable_start_insert = 1
  nnoremap [unite] <Nop>
  xnoremap [unite] <Nop>
  nmap <Space>u [unite]
  xmap <Space>u [unite]
  nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
  nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
  nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>
  nnoremap <silent> [unite]m :<C-u>Unite file_mru<CR>
  nnoremap <silent> [unite]u :<C-u>Unite buffer file_mru<CR>
  " nnoremap <silent> [unite]gs :<C-u>Unite giti/status<CR>
  " nnoremap <silent> [unite]gb :<C-u>Unite giti/branch<CR>
  nnoremap <silent> [unite]o :<C-u>Unite outline<CR>
endif

if dein#tap('neocomplete.vim')
  let g:acp_enableAtStartup = 0
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#enable_smart_case = 1
  let g:neocomplete#enable_underbar_completion = 1
  let g:neocomplete#enable_camel_case_completion = 1
  let g:neocomplete#sources#syntax#min_keyword_length = 3
  let g:neocomplete#auto_completion_start_length = 2
endif

if dein#tap('neosnippet.vim')
  let g:neosnippet#snippets_directory='~/.vim/dein/vim-snippets/snippets'
  imap <C-k> <Plug>(neosnippet_expand_or_jump)
  smap <C-k> <Plug>(neosnippet_expand_or_jump)
  xmap <C-k> <Plug>(neosnippet_expand_target)
  imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
              \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
  smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
              \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
endif

if dein#tap('vimfiler.vim')
  let g:vimfiler_as_default_explorer = 1
  nnoremap [filer] <Nop>
  xnoremap [filer] <Nop>
  nmap <Space>f [filer]
  xmap <Space>f [filer]
  nnoremap <silent> [filer]f :<C-u>VimFilerBufferDir<CR>
  nnoremap <silent> [filer]t :<C-u>VimFilerBufferDir -tab<CR>
  nnoremap <silent> [filer]s :<C-u>VimFilerBufferDir -split -simple -no-quit -winwidth=32<CR>
endif

if dein#tap('vim-quickrun')
 nnoremap <silent> <Leader>r <Nop><CR>
 nnoremap <silent> <Leader>qr :QuickRun<CR>
 let g:quickrun_config = get(g:, 'quickrun_config', {})
 let g:quickrun_config._ = {
       \ 'runner' : 'vimproc',
       \ 'runner/vimproc/updatetime' : 60,
       \ 'outputter/buffer/split' : ':botright 8sp',
       \ 'outputter/buffer/running_mark' : 'running...',
       \ }
 nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"
endif

if dein#tap('lightline.vim')
  let g:lightline = {
       \ 'colorscheme': 'jellybeans',
       \ }
endif

if dein#tap('vim-easymotion')
  let g:EasyMotion_do_mapping = 0
  let g:EasyMotion_do_shade = 0
  let g:EasyMotion_smartcase = 1
  let g:EasyMotion_enter_jump_first = 1
  nmap s <Plug>(easymotion-overwin-f2)
  omap f <Plug>(easymotion-bd-fl)
  xmap f <Plug>(easymotion-bd-fl)
  omap F <Plug>(easymotion-Fl)
  xmap F <Plug>(easymotion-Fl)
  omap t <Plug>(easymotion-tl)
  xmap t <Plug>(easymotion-tl)
  omap T <Plug>(easymotion-Tl)
  xmap T <Plug>(easymotion-Tl)
  nmap J <Plug>(easymotion-j)
  nmap K <Plug>(easymotion-k)
endif

if dein#tap('incsearch.vim')
  let g:incsearch#auto_nohlsearch = 1
  map /  <Plug>(incsearch-forward)
  map ?  <Plug>(incsearch-backward)
  map g/ <Plug>(incsearch-stay)
  map n  <Plug>(incsearch-nohl-n)zz
  map N  <Plug>(incsearch-nohl-N)zz
endif

if dein#tap('incsearch.vim') && dein#tap('vim-asterisk')
  map *  <Plug>(incsearch-nohl0)<Plug>(asterisk-z*)zz
  map g* <Plug>(incsearch-nohl0)<Plug>(asterisk-gz*)zz
  map #  <Plug>(incsearch-nohl0)<Plug>(asterisk-z#)zz
  map g# <Plug>(incsearch-nohl0)<Plug>(asterisk-gz#)zz
endif

" clever-f.vim
if dein#tap('clever-f.vim')
  let g:clever_f_not_overwrites_standard_mappings = 1
  let g:clever_f_smart_case = 1
  let g:clever_f_across_no_line = 1
  nmap f <Plug>(clever-f-f)
  nmap F <Plug>(clever-f-F)
endif

if dein#tap('vim-operator-replace')
  nmap R <Plug>(operator-replace)
  vmap R <Plug>(operator-replace)
endif

if dein#tap('vim-operator-surround')
  nmap <silent>ys <Plug>(operator-surround-append)
  nmap <silent>ds <Plug>(operator-surround-delete)
  nmap <silent>cs <Plug>(operator-surround-replace)
endif

if dein#tap('caw.vim')
  nmap <Leader>c <Plug>(caw:i:toggle)
  vmap <Leader>c <Plug>(caw:i:toggle)
endif

if dein#tap('indentLine')
  let g:indentLine_color_term = 239
  let g:indentLine_faster = 1
  nnoremap <silent> <Leader>i :<C-u>IndentLinesToggle<CR>
endif

if dein#tap('vim-fugitive')
  nnoremap [fugitive] <Nop>
  xnoremap [fugitive] <Nop>
  nmap <Space>g [fugitive]
  xmap <Space>g [fugitive]
  nnoremap [fugitive]s :<C-u>Gstatus<CR>
  nnoremap [fugitive]c :<C-u>Gcommit -v<CR>
  nnoremap [fugitive]a :<C-u>Gwrite<CR>
  nnoremap [fugitive]d :<C-u>Gdiff<CR>
  nnoremap [fugitive]b :<C-u>Gblame<CR>
endif

if dein#tap('gundo.vim')
  nnoremap <Leader>g :<C-u>GundoToggle<CR>
endif

if dein#tap('jedi-vim')
  let g:jedi#goto_command = ''
  let g:jedi#goto_assignments_command = '<Leader>G'
  let g:jedi#goto_definitions_command = ''
  let g:jedi#documentation_command = ''
  let g:jedi#usages_command = ''
  let g:jedi#completions_command = '<C-N>'
  let g:jedi#rename_command = '<Leader>R'
endif

if dein#tap('vim-markdown')
  let g:markdown_no_default_key_mappings = 1
  let g:vim_markdown_folding_disabled = 1
endif

