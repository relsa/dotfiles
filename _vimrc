"-----------------------------------------------------
" 基本的な設定
"-----------------------------------------------------
" 256色表示
set t_Co=256
" viとの互換性をとらない(vimの拡張機能を使うため）
set nocompatible
" 行頭の余白内でTabを打ち込むと'shiftwidth'の数だけインデントする
set smarttab
" 改- 行コードの自動認識
set fileformats=unix,dos,mac
" ビープ音を鳴らさない
set vb t_vb=
" バックスペースで削除できるものを指定
set backspace=indent,eol,start
" UTF-8の□や○でカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif
set foldmethod=manual

"-----------------------------------------------------
" キーバインド変更
"-----------------------------------------------------
" <Leader>
nnoremap ; <Nop>
xnoremap ; <Nop>
let mapleader = ';'

nnoremap j gj
nnoremap k gk

nnoremap <Leader>J J
nnoremap J <Nop>
nnoremap <Leader>K K
nnoremap K <Nop>

nnoremap <C-f> <C-f>zz
nnoremap <C-b> <C-b>zz

inoremap  <C-a> <Home>
inoremap  <C-e> <End>
inoremap  <C-b> <Left>
inoremap  <C-f> <Right>
inoremap  <C-p> <Up>
inoremap  <C-n> <Down>
inoremap  <C-d> <Del>
inoremap  <C-u> <C-o>d0
inoremap  <C-k> <C-o>d$

"-----------------------------------------------------
" ファイル操作関連
"-----------------------------------------------------
" Exploreでカレントディレクトリを開く
set browsedir=current

"-----------------------------------------------------
" バックアップ関連
"-----------------------------------------------------
" バックアップをとる
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
" ファイルの上書き前にバックアップ作成。成功したら削除
set writebackup


"-----------------------------------------------------
" プラグイン管理
"-----------------------------------------------------

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

if dein#tap('vim-quickrun')
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
  let g:neocomplete#enable_at_startup = 1
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
endif

if dein#tap('vim-quickrun')
 nnoremap <silent> <Leader>r <Nop><CR>
 nnoremap <silent> <Leader>qr :QuickRun<CR>
 let g:quickrun_config = get(g:, 'quickrun_config', {})
 let g:quickrun_config._ = {
       \ 'runner'    : 'vimproc',
       \ 'runner/vimproc/updatetime' : 60,
       \ 'outputter' : 'error',
       \ 'outputter/error/success' : 'buffer',
       \ 'outputter/error/error'   : 'quickfix',
       \ 'outputter/buffer/split'  : ':rightbelow 8sp',
       \ 'outputter/buffer/close_on_empty' : 1,
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
  map J <Plug>(easymotion-j)
  map K <Plug>(easymotion-k)
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

"-----------------------------------------------------
" 表示関係
"-----------------------------------------------------
" タイトルをウィンドウ枠に表示する
set title
" 行番号を表示する
set number
" ルーラーを表示
set ruler
" 入力中のコマンドをステータスに表示する
set showcmd
" ステータスラインを常に表示
set laststatus=2
" 括弧入力時に対応する括弧を表示
set showmatch
" 検索結果文字列のハイライトを有効にする
set hlsearch | nohlsearch
" コマンドライン補完を拡張モードにする
set wildmenu
" 行末から次の行へ移るようにする
set whichwrap=b,s,h,l,<,>,[,]
set backspace=indent,eol,start
" 入力されているテキストの最大幅を無効にする
set textwidth=0
" ウィンドウの幅より長い行は折り返して、次の行に続けて表示する
set wrap
" 現在の行をハイライト
set cursorline
" 行末と全角スペースをハイライト
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

" 文末の空白を除去
function! s:remove_trailing_white_spaces()
  let pos = winsaveview()
  silent! execute '%s/\s\+$//g'
  call winrestview(pos)
endfunction
command! RemoveTrailingWhiteSpaces call <SID>remove_trailing_white_spaces()
command! -range=% TrimSpace  <line1>,<line2>s!\s*$!!g | nohlsearch
command! -range=% RemoveTrailM  <line1>,<line2>s!\r$!!g | nohlsearch

let g:jellybeans_overrides = {
\    'Search': {'attr': 'BOLD',
\               '256ctermfg': '255', '256ctermbg': '125'}
\ }

colorscheme jellybeans
set background=dark
syntax enable

"-----------------------------------------------------
" 検索関係
"-----------------------------------------------------
" コマンド、検索パターンを100個まで履歴に残す
set history=1000
" 検索の時に大文字小文字を区別しない
set ignorecase
" 検索の時に大文字が含まれている場合は区別して検索する
set smartcase
" 最後まで検索したら先頭に戻らない
set nowrapscan
" インクリメンタルサーチを使う
set incsearch
" 検索後にジャンプした際に検索単語を画面中央に持ってくる -> incsearch
" nnoremap n nzz
" nnoremap N Nzz
" nnoremap * *zz
" nnoremap # #zz
" nnoremap g* g*zz
" nnoremap g# g#zz
" 対応括弧に'<'と'>'のペアを追加
set matchpairs& matchpairs+=<:>

"-----------------------------------------------------
" インデント
"-----------------------------------------------------
" ファイルごとに設定を変える
filetype plugin indent on
" タブが対応する空白の数
set tabstop=4
" タブやバックスペースの使用等の編集操作をするときに、タブが対応する空白の数
set softtabstop=4
" インデントの各段階に使われる空白の数
set shiftwidth=4
" タブを挿入するとき、代わりに空白を使う
set expandtab
" インデントをオプションの'shiftwidth'の値の倍数に丸める
set shiftround
" オートインデントを有効にする
set autoindent
" 新しい行を作ったときに高度な自動インデントを行う。 'cindent'
" がオンのときは、'smartindent' をオンにしても効果はない。
set smartindent

"----------------------------------------------------
"" 国際化関係
"----------------------------------------------------
" 文字コードの設定
" fileencodingsの設定ではencodingの値を一番最後に記述する
set encoding=utf-8
"set encoding=japan
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,iso-2022-jp,cp932,sjis,euc-jp

"----------------------------------------------------
" その他
"----------------------------------------------------

" 入力モード中に素早くjjと入力した場合はESCとみなす
inoremap jj <Esc>
cnoremap jj <Esc>

" w!! でスーパーユーザーとして保存（sudoが使える環境限定）
cnoreabbrev w!! w !sudo tee > /dev/null %

" 矩形選択で連番入力
" 数字を選んで co と入力
nnoremap <silent> co :ContinuousNumber <C-a><CR>
vnoremap <silent> co :ContinuousNumber <C-a><CR>
command! -count -nargs=1 ContinuousNumber let c = col('.')|for n in range(1, <count>?<count>-line('.'):1)|exec 'normal! j' . n . <q-args>|call cursor('.', c)|endfor

" ESCを二回押すことでハイライトを消す
nmap <silent> <Esc><Esc> :<C-u>nohlsearch<CR>
