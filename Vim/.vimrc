" Configuration file for vim

set belloff=all
set modelines=0		" CVE-2007-2438
set nocompatible	" Use Vim defaults instead of 100% vi compatibility
set backspace=2		" more powerful backspacing
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
set nospell			" 不要进行拼写检查
set showmatch		" 高亮显示对应的括号
set matchtime=5		" 对应括号高亮的时间（单位是十分之一秒）
set autowrite		" 在切换buffer时自动保存当前文件
set wildmenu		" 增强模式中的命令行自动完成操作
set linespace=2		" 字符间插入的像素行数目
set whichwrap=b,s,<,>,[,]	" 开启Normal或Visual模式下Backspace键，空格键，左方向键，右方向键，Insert或replace模式下左方向键，右方向键跳行的功能。
set foldmethod=indent
set foldlevel=99
execute pathogen#infect()
syntax on			" 语法高亮
filetype plugin on
hi Pmenu ctermfg=black ctermbg=gray  guibg=#444444
hi PmenuSel ctermfg=7 ctermbg=4 guibg=#555555 guifg=#ffffff

"==================自定义的键映射======================

"============"
"多窗口操作"
"============"
"nnoremap + <C-W>+ 
"nnoremap - <C-W>-  
nnoremap <C-l> <C-W>l
nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <f3> :ls<CR>

"复制操作
vnoremap <C-c> :w !pbcopy<CR><CR>

nnoremap <f2> :NERDTreeToggle<cr>

" <F4> 运行python程序
nnoremap <F4> :w<CR>:!python %<CR>

" 折叠
nnoremap <space> za

" 编译和运行Java程序
nnoremap <F5> :call CompileRunJava()<CR>
func! CompileRunJava()
	exec "w"
	exec "!javac %"
	exec "!java -Xms512m -Xmx1024m %<"
endfunc

" <F6>编译和运行C++程序
nnoremap <F6> :call CompileRunGpp<CR>
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
call vundle#begin()

Bundle 'gmarik/vundle'
Bundle 'bling/vim-airline'
Bundle 'scrooloose/syntastic'
Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Bundle 'nvie/vim-flake8'
Bundle 'tmhedberg/SimpylFold'
Bundle 'terryma/vim-expand-region'
Bundle 'majutsushi/tagbar'
Bundle 'git://github.com/scrooloose/nerdtree.git'

call vundle#end()

filetype plugin indent on " required

" for vim expand region
vmap v <Plug>(expand_region_expand)
vmap V <Plug>(expand_region_shrink)

" for tagbar
let g:tagbar_ctags_bin='/usr/local/bin/ctags'    "设置tagbar使用的ctags的插件,必须要设置对
let g:tagbar_width=30                            "设置tagbar的窗口宽度
let g:tagbar_left=0								 "设置tagbar的窗口显示的位置,为左边
nnoremap <F8> :TagbarToggle<CR>				     "映射tagbar的快捷键

" for nerdtree
let NERDTreeWinPos=0
""当NERDTree为剩下的唯一窗口时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" for syntastic
let g:syntastic_error_symbol='>>'
let g:syntastic_warning_symbol='>'
let g:syntastic_check_on_open=0
let g:syntastic_check_on_wq=0
let g:syntastic_check_on_w=0
let g:syntastic_enable_highlighting=0
let g:syntastic_python_checkers=['pyflakes'] " 使用pyflakes,速度比pylint快
let g:syntastic_quiet_messages = {'regex': ['warnings', 'trailing-newlines', 'invalid-name',
    \'too-many-lines', 'too-many-instance-attributes', 'too-many-public-methods',
    \'too-many-locals', 'too-many-branches'] }
let g:syntastic_always_populate_loc_list = 0    " to see error location list
let g:syntastic_auto_loc_list = 0
let g:syntastic_loc_list_height = 5
function! ToggleErrors()
    let old_last_winnr = winnr('$')
    lclose
    if old_last_winnr == winnr('$')
        " Nothing was closed, open syntastic error location panel
        Errors
    endif
endfunction
nnoremap <F7> :call ToggleErrors()
let g:pydiction_location = '/Users/colin/.vim/bundle/Pydiction/complete-dict'
let g:SimpylFold_docstring_preview=1 "看到折叠代码的文档字符串
let g:pydiction_location = '/Users/colin/.vim/bundle/pydiction/complete-dict'

" autocompletion keymap setting
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"	"回车即选中当前项
"上下左右键的行为 会显示其他信息
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"
