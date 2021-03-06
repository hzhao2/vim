source ~/.vim/bundles.vim
filetype plugin indent on                     "自动识别文件类型，用文件类型的plugin脚本，用对应的缩进定义
set nocompatible                              "关闭VI兼容模式

let g:neocomplcache_enable_at_startup = 1
"airline"{{{
let g:airline_left_sep=''
let g:airline_right_sep=''
"}}}

"syntastic "{{{
let g:syntastic_css_checkers = ['prettycss'] "}}}

"vim-expand-region"{{{
map L <Plug>(expand_region_expand)
map H <Plug>(expand_region_shrink)
call expand_region#custom_text_objects({
            \ "\/\\n\\n\<CR>": 1,
            \ 'a]' :1,
            \ 'ab' :1,
            \ 'i''' :1,
            \ 'aB' :1,
            \ 'ii' :0,
            \ 'ai' :0,
            \ })
"}}}

"光标所在行和列高亮"{{{
set cursorline cursorcolumn                   "高亮光标所在行和列
au WinLeave * set nocursorline nocursorcolumn "进入窗口的时候高亮所在的行和列
au WinEnter * set cursorline cursorcolumn     "离开窗口的时候取消对光标所在行和列的高亮"}}}

"搜索设置"{{{
set hlsearch                                  "搜索高亮
set incsearch                                 "搜索追踪
set ignorecase                                "忽略大小写$
set smartcase                                 "当查询串中有至少一个大写字母时对大小写敏感
set report=0                                  "显示被替换的次数
"}}}

"缩进设置"{{{
set smartindent                               "智能缩进
set tabstop=4                                 "缩进量
set shiftwidth=4                              "缩进值，用<<和>>的缩进量
set expandtab                                 "把制表符换为空格
"}}}

"系统设置"{{{
set t_Co=256                                  "256位色模式
colorscheme molokai                           "配色方案
set nobackup                                  "关闭自动备份
set mouse=                                    "关闭鼠标
set helplang=cn                               "帮助文档语言
syntax on                                     "语法高亮
"set autochdir                                 "自动将pwd切换为当前文件所在的目录
set backspace=indent,start                    "允许用退格符删除回车符
set autoindent                                "自动对齐
set list                                      "显示特殊字符
set listchars=tab:>-,eol:$                    "需要显示的特殊字符，tab显示为>----,换行显示为$
set ambiwidth=double                          "把所有的不明宽度字符的宽度设为两个字符
set selection=inclusive                       "可视模式下将当前光标所在的字符选中
set so=5                                      "在光标上下各留5行
set ruler                                     "在右下角显示当前光标位置
set foldmethod=marker                         "按照折叠符号折叠
set foldcolumn=2                              "行首显示折叠标识的空格数
set showmatch                                 "显示对应的半个括号位置
set nu                                        "显示行号
set wrap                                      "自动折行
set showmode                                  "在左下角显示当前模式
set winaltkeys=no                             "在windows下禁用菜单alt键，使得alt可以使用
set history=100                               "保留1000次历史
set showcmd                                   "在右下角显示当前已输入但还未执行的命令
set confirm                                   "关闭未保存的文件时提示
"set iskeyword+=$,%,#,-                        "碰到这些字符是时候仍然认为是一个词
set matchpairs+=<:>                           "添加对html的括号匹配
set pastetoggle=<F12>                         "F12作为粘贴模式的转换键
set laststatus=2                              "始终显示状态栏
"}}}

"文件编码相关的设置"{{{
set fileencodings=utf-8,chinese               "文件编码扫描类型
if has ('win32')
    set fileencoding=chinese                  "windows下默认的文件编码为gbk
    set encoding=chinese                      "当前终端输入的编码
    set clipboard+=unnamed                    "与windows共享剪切板
    set title
else
    set fileencoding=utf-8                    "强制将文件编码转为utf8
    set encoding=utf-8                        "当前终端输入的编码
endif
"}}}

"Cscope插件"{{{
set nocscopeverbose                           "如果找Cscope数据库失败时，不要报错
nmap <leader>f :cs find t <C-R>=expand("<cword>")<CR><CR>
"F3 重建cscope数据库
map <silent> <F3> <ESC> :!find ./src -name '*.php' > cscope.files ; cscope -bkq -i cscope.files<CR>
"}}}

"自动补全"{{{
set completeopt=preview,menu                  "自动补全时出最长无分歧的字符串和menu列表
let g:SuperTabRetainCompletionType=2
let g:SuperTabDefaultCompletionType="<C-N>"
"}}}

"选择快捷键组"{{{
map vi' <Esc>?'<CR>lv/'<CR>h
map vi" <Esc>?"<CR>lv/"<CR>h
map va' <Esc>?'<CR>v/'<CR>
map va" <Esc>?"<CR>v/"<CR>
map vix <Esc>?><CR>lv/<<CR>h
map vi= <ESC>?\s\+\S\+\s*=\s*\S\+<CR>lv/=<CR>/\S<CR>/[\s<>\n]<CR>h
map vi/ <Esc>?\/<CR>l<Esc>v/\/<CR>h
map vt) <ESC>v/)<CR>h
map vt' <ESC>v/'<CR>h
map vt" <ESC>v/"<CR>h
map vt; <ESC>v/;<CR>h
map vt, <ESC>v/,<CR>h
map vt} <ESC>v/}<CR>h"}}}

" 在插入模式下使用光标移动指令"{{{
" 需要修改xshell的keyboard配置Backspace为ASCII 127
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>"}}}

"php文件的特殊设置"{{{
autocmd FileType php :call PhpKeys()
function! PhpKeys()
    "php文件的缩进
    "    let php_folding=1
    "    set foldmethod=syntax
    set dictionary+=~/.vim/doc/php_funclist.txt
    set complete+=k
    vmap <silent> <leader>j yoecho json_encode(<ESC>pa, true);<ESC><CR>
    vmap <silent> <leader>v yovar_dump (<ESC>pa);<ESC><CR>
endfunction
"}}}

"多标签"{{{
if v:version >= 700
    map <C-w>p :tabprevious<cr>
    map <C-w>n :tabnext<cr>
    nmap <C-w>t :tabnew<cr>
endif
"}}}

"第81和101列高亮"{{{
if v:version >=703
    set cc=81,101
else
    hi ColorColumn ctermbg=red
    au BufNewFile,BufRead *.* match ColorColumn /\%<82v.\%>81v/
endif
"}}}

"图形界面设定"{{{
if has("gui_running")
    if has("win32")
        set guifont=Ubuntu\ Mono:h12        "字体字号
        autocmd GUIEnter * simalt ~x        "windows 下 gvim 启动时最大化
    elseif has("mac")
        set guifont=Ubuntu\ Mono:h20        "字体字号
        set lines=35                        "窗口打开时的行数
        set columns=129                     "窗口打开时的列数
    else
        set guifont=Ubuntu\ Mono:h12        "字体字号
    endif
endif
"}}}

"快速查找"{{{
nmap <silent> <leader>g :call MyGrep("normal")<CR>
vmap <silent> <leader>g :call MyGrep("visual")<CR>
function! MyGrep(mode) "{{{
    if !exists('g:proj_running')
        let l:files = '%'
    else
        let l:files = '**'
    endif
    if a:mode == "normal"
        let l:word=expand("<cword>")
    endif
    if a:mode == "visual"
        let l:word=eval('y')
    endif
    execute "vimgrep /". l:word ."/j ". l:files
    exec 'cw'
endfunction "}}}
"}}}

"自动补全忽略的文件"{{{
set wildignore+=*.log*,*.svn
set wildignore+=*.aux,*.out,*.toc " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif " binary images
set wildignore+=*.luac " Lua byte code
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.pyc " Python byte code
set wildignore+=*.spl " compiled spelling word lists
set wildignore+=*.sw? " Vim swap files
"}}}

"通用快捷键"{{{
"用q呼起project插件
nmap <silent> q <Plug>ToggleProject
"用F6呼起Tagbar插件
nmap <silent> <F6> :TagbarToggle<CR>
"快捷键自动对齐并去掉末尾的空格
nmap <silent> <F7> msgg=G's :w<CR>
"快捷键取消高亮
nmap <Leader>n :noh<cr>
"注释快捷键"{{{
nmap <leader>x <plug>NERDCommenterToggle
xmap <leader>x <plug>NERDCommenterToggle
let NERDCompactSexyComs=1
"}}}
"快捷键添加注释"{{{
nmap <silent> <leader>tl A//writen by LX<ESC>
nmap <silent> <leader>tn o//writen by LX<ESC>
"}}}
"调整窗口高度"{{{
map <silent> + :res +3<CR>
map <silent> _ :res -3<CR>
"}}}
"}}}
"
"Bundle 'majutsushi/tagbar'
"nmap  :TagbarToggle

nmap <F8> :TagbarToggle<CR>
let g:tagbar_type_go = {
  \ 'ctagstype' : 'go',
  \ 'kinds'  : [
    \ 'p:package',
    \ 'i:imports:1',
    \ 'c:constants',
    \ 'v:variables',
    \ 't:types',
    \ 'n:interfaces',
    \ 'w:fields',
    \ 'e:embedded',
    \ 'm:methods',
    \ 'r:constructor',
    \ 'f:functions'
  \ ],
  \ 'sro' : '.',
  \ 'kind2scope' : {
    \ 't' : 'ctype',
    \ 'n' : 'ntype'
  \ },
  \ 'scope2kind' : {
    \ 'ctype' : 't',
    \ 'ntype' : 'n'
  \ },
  \ 'ctagsbin'  : 'gotags',
  \ 'ctagsargs' : '-sort -silent'
\ }
"
"
"
"
