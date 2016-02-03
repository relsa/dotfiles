"-----------------------------------------------------
" 基本的な設定
"-----------------------------------------------------
"色設定
syntax enable
set t_Co=256
colorscheme jellybeans
" viとの互換性をとらない(vimの拡張機能を使うため）
set nocompatible
" 行頭の余白内でTabを打ち込むと'shiftwidth'の数だけインデントする
set smarttab
" 改行コードの自動認識
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

" 矩形選択で連番入力
" 数字を選んで co と入力
nnoremap <silent> co :ContinuousNumber <C-a><CR>
vnoremap <silent> co :ContinuousNumber <C-a><CR>
command! -count -nargs=1 ContinuousNumber let c = col('.')|for n in range(1, <count>?<count>-line('.'):1)|exec 'normal! j' . n . <q-args>|call cursor('.', c)|endfor

" ESCを二回押すことでハイライトを消す
nmap <silent> <Esc><Esc> :nohlsearch<CR>
" 選択してccで文字数カウント
vnoremap <silent> cc :s/./&/gn<Esc><Esc> <CR>
" vを二回で行末まで選択
vnoremap v $h
" Yで行末までコピー
vnoremap Y y$

"-----------------------------------------------------
" キーバインド変更
"-----------------------------------------------------
" map CTRL-E to end-of-line (insert mode)
" map CTRL-A to beginning-of-line (insert mode)
imap  <C-a> <C-o>^
imap  <C-e> <End>
imap  <C-w> <esc>bcw
imap  <C-b> <Left>
imap  <C-f> <Right>
imap  <C-p> <Up>
imap  <C-n> <Down>
imap  <C-u> <C-u><C-o>d0
" imap  <C-x> <esc>xi
imap  <C-d> <Del>
imap  <C-k> <C-o>d$
map   <C-j> <C-w>p
"  map  % <C-o>:%s/
" <Leader>
let mapleader = ';'

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
if !filewritable($HOME."/.vim_backup")
  call mkdir($HOME."/.vim_backup", "p")
endif
set backupdir=$HOME/.vim_backup
if !filewritable($HOME."/.vim_swap")
  call mkdir($HOME."/.vim_swap", "p")
endif
set directory=$HOME/.vim_swap
"let &directory = &backup dir
" ファイルの上書き前にバックアップ作成。成功したら削除
set writebackup

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
" バックスラッシュやクエスチョンを状況に合わせ自動的にエスケープ
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'
" 検索後にジャンプした際に検索単語を画面中央に持ってくる
" nnoremap n nzz
" nnoremap N Nzz
" nnoremap * *zz
" nnoremap # #zz
" nnoremap g* g*zz
" nnoremap g# g#zz
" 対応括弧に'<'と'>'のペアを追加
set matchpairs& matchpairs+=<:>

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
" シンタックスハイライトを有効にする
syntax on
" 検索結果文字列のハイライトを有効にする
set hlsearch
" コマンドライン補完を拡張モードにする
set wildmenu
" 行末から次の行へ移るようにする
set whichwrap=b,s,[,],<,>
" set whichwrap=b,s,h,l,<,>,[,]
set backspace=indent,eol,start
" 入力されているテキストの最大幅を無効にする
set textwidth=0
" ウィンドウの幅より長い行は折り返して、次の行に続けて表示する
set wrap
" 現在の行をハイライト
set cursorline
highlight CursorLine ctermbg=53
" 行末の空白をハイライト
highlight WhitespaceEOL ctermbg=red guibg=red
autocmd WinEnter * match WhitespaceEOL /\s\+$/
matc WhitespaceEOL /\s\+$/
" 行末の空白文字を可視化
highlight WhitespaceEOL cterm=underline ctermbg=red guibg=#FF0000
au BufWinEnter * let w:m1 = matchadd("WhitespaceEOL", ' +$')
au WinEnter * let w:m1 = matchadd("WhitespaceEOL", ' +$')
" 全角スペースの表示
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
matc ZenkakuSpace /　/
" 保存時に行末の空白を除去する
autocmd BufWritePre * :%s/\s\+$//ge
function! s:remove_dust()
    let cursor = getpos(".")
    " 保存時に行末の空白を除去する
    %s/\s\+$//ge
    call setpos(".", cursor)
    unlet cursor
endfunction
autocmd BufWritePre * call <SID>remove_dust()
" markdownファイルの時は空白をハイライトする
highlight UnderLined cterm=NONE ctermbg=darkgray guibg=#FF0000
function! s:RTrim()
  let s:cursor = getpos(".")
  if &filetype == "markdown"
    %s/\s\+\(\s\{2}\)$/\1/e
    match UnderLined /\s\{2}/
  else
    %s/\s\+$//ge
  endif
  call setpos(".", s:cursor)
endfunction
autocmd BufWritePre * call <SID>RTrim()

"-----------------------------------------------------
" 移動
"-----------------------------------------------------
nnoremap j gj
nnoremap k gk
nnoremap <C-f> <C-f>zz
nnoremap <C-b> <C-b>zz

"-----------------------------------------------------
" タブ
"-----------------------------------------------------
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

"-----------------------------------------------------
" インデント
"-----------------------------------------------------
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
" w!! でスーパーユーザーとして保存（sudoが使える環境限定）
cmap w!! w !sudo tee > /dev/null %

"-----------------------------------------------------
" プラグイン管理
"-----------------------------------------------------
if has('vim_starting')
    set rtp+=~/.vim/plugged/vim-plug
    if !isdirectory(expand('~/.vim/plugged/vim-plug'))
        echo 'install vim-plug...'
        call system('mkdir -p ~/.vim/plugged/vim-plug')
        call system('git clone https://github.com/junegunn/vim-plug.git ~/.vim/plugged/vim-plug/autoload')
    end
endif

call plug#begin('~/.vim/plugged')
  Plug 'junegunn/vim-plug', {'dir': '~/.vim/plugged/vim-plug/autoload'}

  Plug 'Shougo/unite.vim'
  Plug 'Shougo/neomru.vim'
  Plug 'Shougo/neocomplete.vim'
  Plug 'Shougo/neosnippet'
  Plug 'Shougo/neosnippet-snippets'
  Plug 'Shougo/vimproc.vim', {'do': 'make'}
  Plug 'Shougo/vimfiler'
  Plug 'osyo-manga/shabadou.vim'
  Plug 'osyo-manga/vim-watchdogs'
  Plug 'thinca/vim-quickrun'
  Plug 'itchyny/lightline.vim'
  Plug 'tpope/vim-surround'
  Plug 'easymotion/vim-easymotion'
  Plug 'haya14busa/incsearch.vim'
  Plug 'rhysd/clever-f.vim'
  Plug 'kana/vim-operator-user'
  Plug 'kana/vim-operator-replace'
  Plug 'tyru/caw.vim'
  Plug 'Yggdroot/indentLine'
  Plug 'davidhalter/jedi-vim', {'for': 'python'}
  Plug 'jmcantrell/vim-virtualenv', {'for': 'python'}
call plug#end()

" Unite.vim
nnoremap [unite] <Nop>
xnoremap [unite] <Nop>
nmap <Leader>u [unite]
xmap <Leader>u [unite]
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> [unite]m :<C-u>Unite file_mru<CR>
nnoremap <silent> [unite]u :<C-u>Unite buffer file_mru<CR>

let g:neocomplete#enable_at_startup = 1

let g:neosnippet#snippets_directory='~/.vim/plugged/vim-snippets/snippets'
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
            \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
            \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

let g:vimfiler_as_default_explorer = 1
nnoremap <Leader>vb :VimFilerBufferDir<CR>
nnoremap <Leader>vf :VimFiler -buffer-name=explorer -split -simple -winwidth=35 -toggle -no-quit<CR>
nnoremap <Leader>vt :VimFilerBufferDir -tab<CR>

" vim-quickrun
nnoremap <silent> <Leader>r :QuickRun<CR>
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

" lightline.vim
let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ }

" vim-easymotion
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
map <Leader>h <Plug>(easymotion-linebackward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>l <Plug>(easymotion-lineforward)

" incsearch.vim
let g:incsearch#auto_nohlsearch = 1
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
map n  <Plug>(incsearch-nohl-n)zz
map N  <Plug>(incsearch-nohl-N)zz
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

" clever-f.vim
let g:clever_f_not_overwrites_standard_mappings = 1
let g:clever_f_smart_case = 1
let g:clever_f_across_no_line = 1
nmap f <Plug>(clever-f-f)
nmap F <Plug>(clever-f-F)

" vim-operator-replace
nmap R <Plug>(operator-replace)
vmap R <Plug>(operator-replace)

" caw.vim
nmap <Leader>c <Plug>(caw:i:toggle)
vmap <Leader>c <Plug>(caw:i:toggle)

" indentLine
let g:indentLine_color_term = 239
let g:indentLine_faster = 1
nmap <silent><Leader>i :<C-u>IndentLinesToggle<CR>

" jedi-vim
let g:jedi#rename_command = "<Leader>R"

"-----------------------------------------------------
" 文字コードの自動認識
"-----------------------------------------------------
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif

" 以下は最後に書くと機能するっぽい
" 改行コードの自動認識
set fileformats=unix,dos,mac
set whichwrap=b,s,h,l,<,>,[,]
