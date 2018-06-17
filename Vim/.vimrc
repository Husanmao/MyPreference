" Configuration file for vim

set belloff=all
set modelines=0		" CVE-2007-2438
set nocompatible	" Use Vim defaults instead of 100% vi compatibility
set backspace=2		" more powerful backspacing
syntax on			" 语法高亮
set smartindent		" 智能对齐
set autoindent		" 自动对齐
set confirm			" 在处理未保存或只读文件的时候，弹出确认
set tabstop=4		" Tab键的宽度
set softtabstop=4
set shiftwidth=4	"  统一缩进为4
set noexpandtab		" 不要用空格代替制表符
set number			" 显示行号
set history=50		" 历史纪录数
set hlsearch		" 搜索逐字符高亮
set gdefault		" 行内替换
set encoding=utf-8
set fileencodings=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936,utf-16,big5,euc-jp,latin1	" 编码设置
set guifont=Menlo:h16:cANSI	" 设置字体
set langmenu=zn_CN.UTF-8
set helplang=cn		" 语言设置
set cmdheight=2		" 命令行（在状态行）的高度，默认为1,这里是2
set ruler			" 在编辑过程中，在右下角显示光标位置的状态行
set laststatus=2	" 总是显示状态行
set showcmd			" 在状态行显示目前所执行的命令，未完成的指令片段亦会显示出来
set scrolloff=3		" 光标移动到buffer的顶部和底部时保持3行距离
set showmatch		" 高亮显示对应的括号
set matchtime=5		" 对应括号高亮的时间（单位是十分之一秒）
set autowrite		" 在切换buffer时自动保存当前文件
set wildmenu		" 增强模式中的命令行自动完成操作
set linespace=2		" 字符间插入的像素行数目
set whichwrap=b,s,<,>,[,]	" 开启Normal或Visual模式下Backspace键，空格键，左方向键，右方向键，Insert或replace模式下左方向键，右方向键跳行的功能。
hi Pmenu ctermfg=black ctermbg=gray  guibg=#444444
hi PmenuSel ctermfg=7 ctermbg=4 guibg=#555555 guifg=#ffffff

"==================自定义的键映射======================

"============"
"多窗口操作"
"============"
map + <C-W>+ 
map - <C-W>-  
map <C-l> <C-W>l
map <C-h> <C-W>h
map <C-j> <C-W>j
map <C-k> <C-W>k
map <f3> :ls<CR>

"复制操作
vmap <C-c> :w !pbcopy<CR><CR>

map <f2> :NERDTreeToggle<cr>

" <F4> 运行python程序
map <F4> :w<CR>:!python %<CR>	

" 编译和运行Java程序
map <F5> :call CompileRunJava()<CR>
func! CompileRunJava()
	exec "w"
	exec "!javac %"
	exec "!java -Xms512m -Xmx1024m %<"
endfunc

" <F6>编译和运行C++程序
map <F6> :call CompileRunGpp<CR>
func! CompileRunGpp()
	exec "w"
	exec "!g++ % -o %<"
	exec "! ./<"
endfunc

" 当新建 .h .c .hpp .cpp .mk .sh等文件时自动调用SetTitle 函数  
autocmd BufNewFile *.py,*.sh exec ":call MySetTitle()"  
func! MySetTitle()
	if &filetype == 'sh'
		call setline(1, "#!/usr/bin/env bash")
		call setline(2, "")
	else
		call setline(1, "#!/usr/bin/env python")
		call append(1, "#-*- coding:utf-8 -*-")
		call append(2,"# Created at:".strftime('%Y-%m-%d %T',localtime()))
		call append(3,"# Author: Hu.Colin")
		normal G
		normal o
		normal o
	endif
endfunc

"Bundle插件"
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'bling/vim-airline'
Bundle 'Valloric/YouCompleteMe'
" 自动补全配置
set completeopt=preview,menu "让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
autocmd InsertLeave * if pumvisible() == 0|pclose|endif "离开插入模式后自动关闭预览窗口	

"回车即选中当前项
inoremap <expr> <CR> pumvisible() ? "<C-y>" : "<CR>"

"上下左右键的行为 会显示其他信息
inoremap <expr> <Down> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up> pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp> pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

"youcompleteme 默认tab s-tab 和自动补全冲突
"let g:ycm_key_list_select_completion=['<c-n>']
let g:ycm_key_list_select_completion = ['<Down>']
"let g:ycm_key_list_previous_completion=['<c-p>']
let g:ycm_key_list_previous_completion = ['<Up>']
let g:ycm_confirm_extra_conf=0 "关闭加载.ycm_extra_conf.py提示
let g:ycm_collect_identifiers_from_tags_files=1 " 开启 YCM 基于标签引擎
let g:ycm_min_num_of_chars_for_completion=2 " 从第2个键入字符就开始罗列匹配项
let g:ycm_cache_omnifunc=0 " 禁止缓存匹配项,每次都重新生成匹配项
let g:ycm_seed_identifiers_with_syntax=1 " 语法关键字补全
let g:ycm_collect_identifiers_from_tag_files = 1
"let g:indentLine_color_term = 239
"nnoremap <F5> :YcmForceCompileAndDiagnostics<CR> "force recomile with syntastic
"nnoremap <leader>lo :lopen<CR> "open locationlist
"nnoremap <leader>lc :lclose<CR> "close locationlist
inoremap <leader><leader> <C-x><C-o>
"在注释输入中也能补全
let g:ycm_complete_in_comments = 1
"在字符串输入中也能补全
let g:ycm_complete_in_strings = 1
"注释和字符串中的文字也会被收入补全
let g:ycm_collect_identifiers_from_comments_and_strings = 0

nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR> " 跳转到定义处

Bundle 'terryma/vim-expand-region'
vmap v <Plug>(expand_region_expand)
vmap V <Plug>(expand_region_shrink)

"安装tagbar插件
Bundle 'majutsushi/tagbar'
"设置tagbar使用的ctags的插件,必须要设置对
let g:tagbar_ctags_bin='/usr/local/bin/ctags'
"设置tagbar的窗口宽度
let g:tagbar_width=30
"设置tagbar的窗口显示的位置,为左边
let g:tagbar_left=0
"打开文件自动 打开tagbar
"autocmd BufReadPost *.py,*.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen()
"映射tagbar的快捷键
map <F8> :TagbarToggle<CR>

"=========="
"Plugins"
"=========="
Bundle 'git://github.com/scrooloose/nerdtree.git'
let NERDTreeWinPos=0
" autoload needtree
"autocmd vimenter * NERDTree
""当NERDTree为剩下的唯一窗口时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
filetype plugin indent on " required
