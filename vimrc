set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
 set rtp+=~/.vim/bundle/Vundle.vim
 call vundle#begin()
" " alternatively, pass a path where Vundle should install plugins
" "call vundle#begin('~/some/path/here')
"
" " let Vundle manage Vundle, required
 Plugin 'gmarik/Vundle.vim'
"
" " The following are examples of different formats supported.
" " Keep Plugin commands between vundle#begin/end.
" " plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" " plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" " Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" " git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" " The sparkup vim script is in a subdirectory of this repo called vim.
" " Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" " Avoid a name conflict with L9
" Plugin 'user/L9', {'name': 'newL9'}


 Plugin 'scrooloose/syntastic'
 Plugin 'scrooloose/nerdtree'
 Plugin 'a.vim'
 Plugin 'molokai'
 Plugin 'scrooloose/nerdcommenter'
 Plugin 'unimpaired.vim'
 Plugin 'vim-scripts/cscope.vim'
 Plugin 'mattn/webapi-vim'
 Plugin 'mattn/gist-vim'
"
" " All of your Plugins must be added before the following line
 call vundle#end()            " required
 filetype plugin indent on    " required
" " To ignore plugin indent changes, instead use:
" "filetype plugin on
" "
" " Brief help
" " :PluginList       - lists configured plugins
" " :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" " :PluginSearch foo - searches for foo; append `!` to refresh local cache
" " :PluginClean      - confirms removal of unused plugins; append `!` to
" auto-approve removal
" "
" " see :h vundle for more details or wiki for FAQ
" " Put your non-Plugin stuff after this line

"set shortmess=atI   " 启动的时候不显示那个援助乌干达儿童的提示
"set nocompatible " 关闭 vi 兼容模式
syntax on " 自动语法高亮
colorscheme molokai " 设定配色方案
set number " 显示行号
set cursorline " 突出显示当前行
set ruler " 打开状态栏标尺
set shiftwidth=4 " 设定 << 和 >> 命令移动时的宽度为 4
set softtabstop=4 " 使得按退格键时可以一次删掉 4 个空格
set tabstop=4 " 设定 tab 长度为 4
set nobackup " 覆盖文件时不备份
set autochdir " 自动切换当前目录为当前文件所在的目录
filetype plugin indent on " 开启插件
set backupcopy=yes " 设置备份时的行为为覆盖
set ignorecase smartcase " 搜索时忽略大小写，但在有一个或以上大写字母时仍保持对大小写敏感
set nowrapscan " 禁止在搜索到文件两端时重新搜索
set incsearch " 输入搜索内容时就显示搜索结果
set hlsearch " 搜索时高亮显示被找到的文本
set noerrorbells " 关闭错误信息响铃
set novisualbell " 关闭使用可视响铃代替呼叫
set t_vb= " 置空错误铃声的终端代码
" set showmatch " 插入括号时，短暂地跳转到匹配的对应括号
" set matchtime=2 " 短暂跳转到匹配括号的时间
set magic " 设置魔术
set hidden " 允许在有未保存的修改时切换缓冲区，此时的修改由 vim 负责保存
set guioptions-=T " 隐藏工具栏
set guioptions-=m " 隐藏菜单栏
set smartindent " 开启新行时使用智能自动缩进
set backspace=indent,eol,start
" 不设定在插入状态无法用退格键和 Delete 键删除回车符
set cmdheight=1 " 设定命令行的行数为 1
set laststatus=2 " 显示状态栏 (默认值为 1, 无法显示状态栏)
set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ %{&encoding}\ %c:%l/%L%)\ 
" 设置在状态行显示的信息
set whichwrap+=<,>,h,l
" 可以在buffer的任何地方使用鼠标（类似office中在工作区双击鼠标定位）
set mouse=a
set selection=exclusive
set selectmode=mouse,key
" 通过使用: commands命令，告诉我们文件的哪一行被改变过
set report=0
set foldenable " 开始折叠
set foldmethod=syntax " 设置语法折叠
set foldcolumn=0 " 设置折叠区域的宽度
setlocal foldlevel=1 " 设置折叠层数为
" set foldclose=all " 设置为自动关闭折叠 
" nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
" 用空格键来开关折叠

"自动补全
:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap { {<CR>}<ESC>O
:inoremap } <c-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>
:inoremap " ""<ESC>i
:inoremap ' ''<ESC>i
function! ClosePair(char)
	if getline('.')[col('.') - 1] == a:char
		return "\<Right>"
	else
		return a:char
	endif
endfunction
filetype plugin indent on 
"打开文件类型检测, 加了这句才可以用智能补全
set completeopt=longest,menu
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""新文件标题
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"新建.c,.h,.sh,.java文件，自动插入文件头 
autocmd BufNewFile *.py,*.cc,*.cpp,*.[ch],*.sh,*.java exec ":call SetTitle()" 
""定义函数SetTitle，自动插入文件头 
func SetTitle() 
	"如果文件类型为.sh文件 
	if &filetype == 'sh' 
		call setline(1,"\#########################################################################") 
		call append(line("."), "\# File Name: ".expand("%")) 
		call append(line(".")+1, "\# Author: Crayon Chaney") 
		call append(line(".")+2, "\# mail: mmmmmcclxxvii@gmail.com") 
		call append(line(".")+3, "\# Created Time: ".strftime("%c")) 
		call append(line(".")+4, "\#########################################################################") 
		call append(line(".")+5, "\#!/bin/bash") 
		call append(line(".")+6, "") 

	elseif &filetype == 'python'	
		call setline(1,"\#!/usr/bin/python") 
		call append(line("."), "\#-*- coding: utf-8 -*-")
		call append(line(".")+1, "\# File Name: ".expand("%"))	
		call append(line(".")+2, "\# Created Time: ".strftime("%c")) 
		call append(line(".")+3, "")
	else	
		call setline(1, "/*************************************************************************") 
		call append(line("."), "	> File Name: ".expand("%")) 
		call append(line(".")+1, "	> Author: Crayon Chaney") 
		call append(line(".")+2, "	> Mail:mmmmmcclxxvii@gmail.com") 
		call append(line(".")+3, "	> Created Time: ".strftime("%c")) 
		call append(line(".")+4, " ************************************************************************/") 
		call append(line(".")+5, "")
	endif
	if &filetype == 'cpp'
		call append(line(".")+6, "#include<iostream>")
		call append(line(".")+7, "using namespace std;")
		call append(line(".")+8, "")
	endif
	if &filetype == 'c'
		call append(line(".")+6, "#include<stdio.h>")
		call append(line(".")+7, "#include<stdlib.h>")
		call append(line(".")+8, "")
	endif
	if &filetype == 'python'
		call append(line(".")+4, "\__author__ = 'Crayon Chaney <mmmmmcclxxvii@gmail.com>'")
		call append(line(".")+5, "")
	endif
	if &filetype == 'java'
			call append(line(".")+6,"public class ".expand("%"))
			call append(line(".")+7,"")
	endif
	if &filetype == 'cc'
		call append(line(".")+6, "#include<iostream>")
		call append(line(".")+7, "using namespace std;")
		call append(line(".")+8, "")
	endif
	"新建文件后，自动定位到文件末尾
	autocmd BufNewFile * normal !G
endfunc 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set cursorcolumn
"光标列移动
hi CursorLine cterm=NONE ctermbg=1 ctermfg=white
hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white

" return OS type, eg: windows, or linux, mac, et.st..
function! MySys()
if has("win16") || has("win32") || has("win64") || has("win95")
return "windows"
elseif has("unix")
return "linux"
endif
endfunction

" 用户目录变量$VIMFILES
if MySys() == "windows"
let $VIMFILES = $VIM.'/vimfiles'
elseif MySys() == "linux"
let $VIMFILES = $HOME.'/.vim'
endif

" 设定doc文档目录
let helptags=$VIMFILES.'/doc'

" 设置字体 以及中文支持
if has("win32")
set guifont=Inconsolata:h12:cANSI
endif

" 配置多语言环境
if has("multi_byte")
" UTF-8 编码
set encoding=utf-8
set termencoding=utf-8
set formatoptions+=mM
set fencs=utf-8,gbk

if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'
set ambiwidth=double
endif

if has("win32")
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
language messages zh_CN.utf-8
endif
else
echoerr "Sorry, this version of (g)vim was not compiled with +multi_byte"
endif

" Buffers操作快捷方式!
nnoremap <C-RETURN> :bnext<CR>
nnoremap <C-S-RETURN> :bprevious<CR>

" Tab操作快捷方式!
nnoremap <C-TAB> :tabnext<CR>
nnoremap <C-S-TAB> :tabprev<CR>

"关于tab的快捷键
" map tn :tabnext<cr>
" map tp :tabprevious<cr>
" map td :tabnew .<cr>
" map te :tabedit
" map tc :tabclose<cr>

"窗口分割时,进行切换的按键热键需要连接两次,比如从下方窗口移动
"光标到上方窗口,需要<c-w><c-w>k,非常麻烦,现在重映射为<c-k>,切换的
"时候会变得非常方便.
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"一些不错的映射转换语法（如果在一个文件中混合了不同语言时有用）
nnoremap <leader>1 :set filetype=xhtml<CR>
nnoremap <leader>2 :set filetype=css<CR>
nnoremap <leader>3 :set filetype=javascript<CR>
nnoremap <leader>4 :set filetype=php<CR>
nnoremap <leader>5 :set filetype=c<CR>
nnoremap <leader>6 :set filetype=cpp<CR>
nnoremap <leader>7 :set filetype=python<CR>
" set fileformats=unix,dos,mac
" nmap <leader>fd :se fileformat=dos<CR>
" nmap <leader>fu :se fileformat=unix<CR>

" use Ctrl+[l|n|p|cc] to list|next|previous|jump to count the result
" map <C-x>l <ESC>:cl<CR>
" map <C-x>n <ESC>:cn<CR>
" map <C-x>p <ESC>:cp<CR>
" map <C-x>c <ESC>:cc<CR>


" 让 Tohtml 产生有 CSS 语法的 html
" syntax/2html.vim，可以用:runtime! syntax/2html.vim
let html_use_css=1

" Python 文件的一般设置，比如不要 tab 等
autocmd FileType python set tabstop=4 shiftwidth=4 expandtab
autocmd FileType python map <F12> :!python %<CR>

" 选中状态下 Ctrl+c 复制
vmap <C-c> "+y

" 打开javascript折叠
let b:javascript_fold=1
" 打开javascript对dom、html和css的支持
let javascript_enable_domhtmlcss=1
" 设置字典 ~/.vim/dict/文件的路径
"autocmd filetype javascript set dictionary=$VIMFILES/dict/javascript.dict
"autocmd filetype css set dictionary=$VIMFILES/dict/css.dict
"autocmd filetype php set dictionary=$VIMFILES/dict/php.dict

"-----------------------------------------------------------------
" plugin - bufexplorer.vim Buffers切换
" \be 全屏方式查看全部打开的文件列表
" \bv 左右方式查看 \bs 上下方式查看
"-----------------------------------------------------------------



"-----------------------------------------------------------------
"Plugin - scroooloose/nerdtree
"-----------------------------------------------------------------
autocmd vimenter * NERDTree
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd vimenter * wincmd w
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"
"
"


"-----------------------------------------------------------------
" plugin - taglist.vim 查看函数列表，需要ctags程序
" F4 打开隐藏taglist窗口
"-----------------------------------------------------------------
if MySys() == "windows" " 设定windows系统中ctags程序的位置
let Tlist_Ctags_Cmd = '"'.$VIMRUNTIME.'/ctags.exe"'
elseif MySys() == "linux" " 设定windows系统中ctags程序的位置
let Tlist_Ctags_Cmd = '/usr/bin/ctags'
endif
nnoremap <silent><F4> :TlistToggle<CR>
let Tlist_Show_One_File = 1 " 不同时显示多个文件的tag，只显示当前文件的
let Tlist_Exit_OnlyWindow = 1 " 如果taglist窗口是最后一个窗口，则退出vim
let Tlist_Use_Right_Window = 1 " 在右侧窗口中显示taglist窗口
let Tlist_File_Fold_Auto_Close=1 " 自动折叠当前非编辑文件的方法列表
let Tlist_Auto_Open = 0
let Tlist_Auto_Update = 1
let Tlist_Hightlight_Tag_On_BufEnter = 1
let Tlist_Enable_Fold_Column = 0
let Tlist_Process_File_Always = 1
let Tlist_Display_Prototype = 0
let Tlist_Compact_Format = 1

"-----------------------------------------------------------------
"cscope setting
"-----------------------------------------------------------------
if has("cscope")
		set csprg=/usr/local/bin/cscope
		set csto=0
		set cscopetag
		set cst
		set nocsverb
		" add any database in current directory
		if filereadable("cscope.out")
		    cs add cscope.out
		" else add database pointed to by environment
		elseif $CSCOPE_DB != ""
		    cs add $CSCOPE_DB
		endif
		set csverb
		
		nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>	
		nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>	
		nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>	
		nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>	
		nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>	
		nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>	
		nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
		nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

		 nmap <C-@>s :scs find s <C-R>=expand("<cword>")<CR><CR>	
		 nmap <C-@>g :scs find g <C-R>=expand("<cword>")<CR><CR>	
		 nmap <C-@>c :scs find c <C-R>=expand("<cword>")<CR><CR>	
		 nmap <C-@>t :scs find t <C-R>=expand("<cword>")<CR><CR>	
		 nmap <C-@>e :scs find e <C-R>=expand("<cword>")<CR><CR>	
		 nmap <C-@>f :scs find f <C-R>=expand("<cfile>")<CR><CR>	
		 nmap <C-@>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>	
		 nmap <C-@>d :scs find d <C-R>=expand("<cword>")<CR><CR>

		nmap <C-@><C-@>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
		nmap <C-@><C-@>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
		nmap <C-@><C-@>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
		nmap <C-@><C-@>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
		nmap <C-@><C-@>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
		nmap <C-@><C-@>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>	
		nmap <C-@><C-@>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>	
		nmap <C-@><C-@>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>


endif


"-----------------------------------------------------------------
" plugin - mark.vim 给各种tags标记不同的颜色，便于观看调式的插件。
" \m mark or unmark the word under (or before) the cursor
" \r manually input a regular expression. 用于搜索.
" \n clear this mark (i.e. the mark under the cursor), or clear all highlighted marks .
" \* 当前MarkWord的下一个 \# 当前MarkWord的上一个
" \/ 所有MarkWords的下一个 \? 所有MarkWords的上一个
"-----------------------------------------------------------------



"-----------------------------------------------------------------
" plugin - NERD_commenter.vim 注释代码用的，
" [count],cc 光标以下count行逐行添加注释(7,cc)
" [count],cu 光标以下count行逐行取消注释(7,cu)
" [count],cm 光标以下count行尝试添加块注释(7,cm)
" ,cA 在行尾插入 /* */,并且进入插入模式。 这个命令方便写注释。
" 注：count参数可选，无则默认为选中行或当前行
"-----------------------------------------------------------------
let NERDSpaceDelims=1 " 让注释符与语句之间留一个空格
let NERDCompactSexyComs=1 " 多行注释时样子更好看


"-----------------------------------------------------------------
" plugin - DoxygenToolkit.vim 由注释生成文档，并且能够快速生成函数标准注释
"-----------------------------------------------------------------
let g:DoxygenToolkit_authorName="Asins - asinsimple AT gmail DOT com"
let g:DoxygenToolkit_briefTag_funcName="yes"
map <leader>da :DoxAuthor<CR>
map <leader>df :Dox<CR>
map <leader>db :DoxBlock<CR>
map <leader>dc a /* */<LEFT><LEFT><LEFT>


"-----------------------------------------------------------------
" plugin – ZenCoding.vim 很酷的插件，HTML代码生成
" 插件最新版：http://github.com/mattn/zencoding-vim
" 常用命令可看：http://nootn.com/blog/Tool/23/
"-----------------------------------------------------------------


"-----------------------------------------------------------------
" plugin – checksyntax.vim JavaScript常见语法错误检查
" 默认快捷方式为 F5
"-----------------------------------------------------------------
" let g:checksyntax_auto = 0 " 不自动检查


"-----------------------------------------------------------------
" plugin - NeoComplCache.vim 自动补全插件
"-----------------------------------------------------------------
" let g:AutoComplPop_NotEnableAtStartup = 1
" let g:NeoComplCache_EnableAtStartup = 1
" let g:NeoComplCache_SmartCase = 1
" let g:NeoComplCache_TagsAutoUpdate = 1
" let g:NeoComplCache_EnableInfo = 1
" let g:NeoComplCache_EnableCamelCaseCompletion = 1
" let g:NeoComplCache_MinSyntaxLength = 3
" let g:NeoComplCache_EnableSkipCompletion = 1
" let g:NeoComplCache_SkipInputTime = '0.5'
" let g:NeoComplCache_SnippetsDir = $VIMFILES.'/snippets'
" " <TAB> completion.
" inoremap <expr><TAB> pumvisible() ? \<C-n>" : \<TAB>"
" " snippets expand key
" imap <silent> <C-e> <Plug>(neocomplcache_snippets_expand)
" smap <silent> <C-e> <Plug>(neocomplcache_snippets_expand)


"-----------------------------------------------------------------
" plugin - matchit.vim 对%命令进行扩展使得能在嵌套标签和语句之间跳转
" % 正向匹配 g% 反向匹配
" [% 定位块首 ]% 定位块尾
"-----------------------------------------------------------------


"-----------------------------------------------------------------
" plugin - vcscommand.vim 对%命令进行扩展使得能在嵌套标签和语句之间跳转
" SVN/git管理工具
"-----------------------------------------------------------------


"-----------------------------------------------------------------
" plugin – a.vim
"----------------------------------------------------------------


"----------------------------------------------------------------
"vim-powerline
"----------------------------------------------------------------
let g:Powerline_symbols = 'fancy'


"----------------------------------------------------------------
"nerdcomment
"----------------------------------------------------------------
" [count]<leader>cc |NERDComComment|
" Comment out the current line or text selected in visual mode.

" [count]<leader>cn |NERDComNestedComment|
" Same as <leader>cc but forces nesting.

" [count]<leader>c |NERDComToggleComment|
" Toggles the comment state of the selected line(s). If the topmost selected line is commented, all selected lines are uncommented and vice versa.

" [count]<leader>cm |NERDComMinimalComment|
" Comments the given lines using only one set of multipart delimiters.

" [count]<leader>ci |NERDComInvertComment|
" Toggles the comment state of the selected line(s) individually.

" [count]<leader>cs |NERDComSexyComment|
" Comments out the selected lines ``sexily''

" [count]<leader>cy |NERDComYankComment|
" Same as <leader>cc except that the commented line(s) are yanked first.

" <leader>c$ |NERDComEOLComment|
" Comments the current line from the cursor to the end of line.

" <leader>cA |NERDComAppendComment|
" Adds comment delimiters to the end of line and goes into insert mode between them.

" |NERDComInsertComment|
" Adds comment delimiters at the current cursor position and inserts between. Disabled by default.

" <leader>ca |NERDComAltDelim|
" Switches to the alternative set of delimiters.

" [count]<leader>cl
" [count]<leader>cb |NERDComAlignedComment|
" Same as |NERDComComment| except that the delimiters are aligned down the left side (<leader>cl) or both sides (<leader>cb).

" [count]<leader>cu |NERDComUncommentLine|
" Uncomments the selected line(s).
"
"

"----------------------------------------------------------------
"
"----------------------------------------------------------------
"scrooloose/syntastic
"----------------------------------------------------------------
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" "
"----------------------------------------------------------------
