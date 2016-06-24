set nocompatible  "不使用vi的键盘模式, 而是vim自己的
let $LANG = 'en' "set message language
set langmenu=en "set menu's language of gvim. no spaces beside '='
set helplang=cn
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
set bsdir=buffer
"set autochdir
set nobackup
behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '

    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction


"---------------vim基本设置: 行号,配色方案,默认窗口大小-----------
set number
set wrap  "设置自动折行
set showcmd  "显示命令行输入
set background=dark "dark/light
colorscheme solarized "desert/darkblue
set lines=50 columns=150
set ignorecase
"syntax on
set laststatus=2
set autoindent  "自动缩进
set cindent
set tabstop=4  "tab键宽度
set softtabstop=4  "统一缩进为4
set noexpandtab  "不要用空格代替制表符
set autoread "设置当文件被改动时自动载入
set cursorline "突出显示当前行
set smartindent
filetype plugin on
set completeopt=longest,menu
set scrolloff=3
set clipboard=unnamed  "共享系统剪切板

"自动补全命令时使用菜单式匹配列表 Ctrl+x Ctrl+o 补全代码
set wildmenu
autocmd filetype python set omnifunc=python3complete#Complete
autocmd filetype javascript set omnifunc=javascriptcomplete#CompleteJS

"代码折叠
"按照语法高亮元素折叠代码
set foldmethod=syntax
"python按照缩进折叠代码
autocmd filetype python setlocal foldmethod=indent
"默认展开所有代码
set foldlevel=99
"随后可使用z系列命令管理代码折叠. za: 翻转当前位置的折叠状态
"zA: 递归翻转当前层所有代码的折叠状态
"zc: 折叠; zC: 对所在范围内所有嵌套的折叠点进行折叠
"zo: 展开折叠; zO: 对所在范围内所有嵌套的折叠点展开

"解决中文乱码的配置
set fileencodings=usc-bom,utf-8,gbk,euc-kr,euc-jp,big5,gb2312,gb18030,cp936,latin1
set fileencoding=utf-8
set encoding=utf-8
set gfn=Bitstream_Vera_Sans_Mono:h10:cANSI
"中文字体->NSimSun
set gfw=NSimSun:h10


"========Vundle --> vim插件管理工具========
"此处规定Vundle的路径
filetype off
set rtp+=$VIM/vimfiles/bundle/vundle/
call vundle#rc('$VIM/vimfiles/bundle/')
Bundle 'gmarik/vundle'
filetype plugin indent on

"plugin installation: vim一般模式下输入:plugininstall
"airline plugin --> vim 状态栏插件
Plugin 'bling/vim-airline'
let g:airline_theme = "powerlineish"    "luna
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ">>"
let g:airline#extensions#tabline#left_alt_sep = ">>"
let g:airline_section_b = "%{strftime('%c')}"	"statusline syntax customization
let g:airline_section_y = "BN: %{bufnr('%')}"	"statusline syntax customization
"关闭状态显示空白符号计数"
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#whitespace#symbol = '!'

"NERDTree plugin --> 显示文件目录树结构
Plugin 'scrooloose/nerdtree'
"开启/关闭文件目录
map <F9> :NERDTreeToggle<CR>
"autocmd VimEnter * NERDTree

"CtrlP plugin --> 搜索文件
Plugin 'ctrlpvim/ctrlp.vim'

"vim markdown plugin -->文本编辑标记语言
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
"=======markdown设置========"
let g:table_mode_corner=" |"
"=======open file in firefox======="
autocmd bufread,bufnewfile *.{md,mdown,mkd,mkdn,markdown,mdwn} map <leader>ff :!start "C:\Program Files (x86)\Mozilla Firefox\firefox.exe" "%"<cr>

"jedi-vim
"Plugin 'davidhalter/jedi-vim'
"let g:jedi#force_py_version = 3

"========定义快捷键的前缀--> <leader>========
let mapleader=" "
"快捷键配置
"Ctrl+l: next tab
map <C-l> :tabn<CR>
"previous tab
map <C-h> :tabp<CR>
"new tab
map <C-F8> :tabnew<CR>
"close current tab
map <C-c> :tabclose<CR>
"Ctrl+i: <Esc>
imap <C-i> <Esc>
