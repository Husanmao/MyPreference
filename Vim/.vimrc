"   Configuration file for vim

set belloff=all
set modelines=0     " CVE-2007-2438
set nocompatible    " Use Vim defaults instead of 100% vi compatibility
set backspace=2     " more powerful backspacing
set smartindent     " 智能对齐
set autoindent      " 自动对齐
set confirm         " 在处理未保存或只读文件的时候，弹出确认
set tabstop=4       " Tab键的宽度
set softtabstop=4
set shiftwidth=4    " 统一缩进为4
set shortmess+=c
set expandtab       " 用空格代替制表符
set number          " 显示行号
set history=50      " 历史纪录数
set hlsearch        " 搜索逐字符高亮
set gdefault        " 行内替换
set encoding=utf-8
set fileencodings=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936,utf-16,big5,euc-jp,latin1    " 编码设置
set guifont=Menlo:h16:cANSI " 设置字体
set langmenu=zn_CN.UTF-8
set helplang=cn     " 语言设置
set cmdheight=2     " 命令行（在状态行）的高度，默认为1,这里是2
set ruler           " 在编辑过程中，在右下角显示光标位置的状态行
set laststatus=2    " 总是显示状态行
set showcmd         " 在状态行显示目前所执行的命令，未完成的指令片段亦会显示出来
set scrolloff=3     " 光标移动到buffer的顶部和底部时保持3行距离
set nospell         " 不要进行拼写检查
set showmatch       " 高亮显示对应的括号
set matchtime=5     " 对应括号高亮的时间（单位是十分之一秒）
set autowrite       " 在切换buffer时自动保存当前文件
set wildmenu        " 增强模式中的命令行自动完成操作
set linespace=2     " 字符间插入的像素行数目
set whichwrap=b,s,<,>,[,]   " 开启Normal或Visual模式下Backspace键，空格键，左方向键，右方向键，Insert或replace模式下左方向键，右方向键跳行的功能。
set foldmethod=indent
set foldlevel=99
call pathogen#infect()
call pathogen#helptags()
filetype plugin on
syntax on           " 语法高亮
hi Pmenu ctermfg=black ctermbg=gray  guibg=#444444
hi PmenuSel ctermfg=7 ctermbg=4 guibg=#555555 guifg=#ffffff

"==================自定义的键映射======================

let g:mapleader=","
noremap <leader>q :q<CR>
noremap <leader>h :%!xxd<CR>
noremap <leader>s :set invlist<CR>
noremap <leader>n :set nolist<CR>
noremap <leader>r :%retab!<CR>

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

" 折叠
nnoremap <space> za

" 编译和运行Java程序
nnoremap <F5> :call MyRun()<CR>
func! MyRun()
    exec "w"
    if &filetype == "py"
        exec "!python %"
    elseif &filetype == "sh"
        exec "!bash %"
    elseif &filetype == "java"
        exec "!javac %"
        exec "!java -Xms512m -Xmx1024m %<"
    endif
endfunc

" <F6>编译和运行C++程序
nnoremap <F6> :call CompileRunGpp<CR>
func! CompileRunGpp()
    exec "w"
    exec "!g++ % -o %<"
    exec "! ./<"
endfunc

" 当新建 .h .c .hpp .cpp .mk .sh等文件时自动调用SetTitle 函数  
autocmd BufNewFile *.py exec ":call MySetTitle()"  
func! MySetTitle()
    call setline(1, "#!/usr/bin/env python")
    call append(1, "# -*- coding:utf-8 -*-")
    normal G
    normal o
endfunc

"Bundle插件"
set rtp+=~/.vim/bundle/vundle/
call vundle#begin()

Bundle 'gmarik/vundle'
Bundle 'bling/vim-airline'
Bundle 'davidhalter/jedi-vim'
Bundle 'ervandew/supertab'
Bundle 'ctrlp.vim'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'
Bundle 'w0rp/ale'
Bundle 'terryma/vim-expand-region'
Bundle 'scrooloose/nerdcommenter'
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
let g:tagbar_left=0                              "设置tagbar的窗口显示的位置,为左边
nnoremap <F8> :TagbarToggle<CR>                  "映射tagbar的快捷键

" for nerdtree
let NERDTreeWinPos=0
""当NERDTree为剩下的唯一窗口时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

autocmd FileType python setlocal completeopt-=preview

" for java complete
autocmd FileType java setlocal omnifunc=javacomplete#Complete
autocmd FileType java setlocal completefunc=javacomplete#CompleteParamsInfo


au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |

let g:SimpylFold_docstring_preview=1 "看到折叠代码的文档字符串
" for jedi-vim
let g:SuperTabDefaultCompletionType = "context"  
let g:SuperTabRetainCompletionType = 2
let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
let g:jedi#popup_on_dot = 1
let g:jedi#popup_select_first = 1
let g:jedi#goto_command = "<leader>g"
let g:jedi#goto_assignments_command = "<leader>a"
let g:jedi#goto_definitions_command = "<leader>d"
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>u"
let g:jedi#completions_command = "<leader>c"
let g:jedi#rename_command = "<leader>r"
let g:jedi#max_doc_height = 10

" autocompletion keymap setting
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"    "回车即选中当前项
"上下左右键的行为 会显示其他信息
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

" for ctrlp
"ctrlp
"<Leader>p搜索当前目录下文件
let g:ctrlp_map = '<Leader>p'
let g:ctrlp_cmd = 'CtrlP'
"<Leader>f搜索MRU文件
nmap <Leader>f :CtrlPMRUFiles<CR>
"<Leader>b显示缓冲区文件，并可通过序号进行跳转
nmap <Leader>b :CtrlPBuffer<CR>
"设置搜索时忽略的文件
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn|rvm)$',
    \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz|pyc)$',
    \ }
let g:ctrlp_working_path_mode = 0
let g:ctrlp_match_window_bottom = 1
"修改QuickFix窗口显示的最大条目数
let g:ctrlp_max_height = 15
let g:ctrlp_match_window_reversed = 0
"设置MRU最大条目数为500
let g:ctrlp_mruf_max = 500
let g:ctrlp_follow_symlinks = 1
"默认使用全路径搜索，置1后按文件名搜索，准确率会有所提高，可以用<C-d>进行切换
let g:ctrlp_by_filename = 1
"默认不使用正则表达式，置1改为默认使用正则表达式，可以用<C-r>进行切换
let g:ctrlp_regexp = 0
"自定义搜索列表的提示符
let g:ctrlp_line_prefix = '♪ '

" for ale
let g:ale_linters = {'python': ['flake8'], 'reStructuredText': ['rstcheck']}
let g:ale_fixers = {'python': ['remove_trailing_lines', 'trim_whitespace', 'yapf']}
let g:ale_fix_on_save = 1
let g:ale_sign_column_always = 1
let g:ale_set_highlights = 0
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚡'
let g:ale_statusline_format = ['✗ %d', '⚡ %d', '✔ OK']
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
nmap sp <Plug>(ale_previous_wrap)
nmap sn <Plug>(ale_next_wrap)

" for snippets
imap <leader>w <Plug>snipMateNextOrTrigger
smap <leader>w <Plug>snipMateNextOrTrigger
let g:snips_author = "hudongfeng(HW)"
let g:snips_email = "2268897104colinhu@gmail.com"
