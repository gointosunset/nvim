"  __  ____   __  _   ___     _____ __  __ ____   ____
" | \/  \ \ / / | \  | \ \   / /_ _ | \/    | _ \ / ___ |
" |             | \/ |              | \ V / | \|        | \ \ / / |   |    |       | \/  |   |  | _) |   |
" |             |    |              |       |           |         |   | \  | \ V / |     |   |  |    |   | _ <      |  | ___
" | _           |    | _            |       | _         |         | _ | \_ | \_/   | ___ | _ |  | _  | _ | \_\\____ |
set nocompatible
set re=0

set number                    " = 显示行号
set relativenumber            " = 显示相对行号·
" set cursorline                " = 高亮当前行
" set cursorcolumn              " = 高亮当前列
syntax on                     " = 语法高亮
syntax enable                 " =
filetype on                   " = 侦测文件类型
filetype indent on            " = 开启文件类型检查，并且载入与该类型对应的缩进规则
filetype plugin on            " = 针对不同的文件类型加载对应的插件
filetype plugin indent on     " = 启用自动补全
set showmode                  " = 在底部显示，当前处于命令模式还是插入模式
set showcmd                   " = 命令模式下，在底部显示，当前键入的指令
set mouse=a                   " = 支持使用鼠标
set t_Co=256                  " = 启用256色
set autoindent                " = 按下回车键后，下一行的缩进会自动跟上一行的缩进保持一致
set tabstop=2                 " = 按下 Tab 键时，Vim 显示的空格数
set shiftwidth=2              " = 在文本上按下>>（增加一级缩进）、<<（取消一级缩进）或者==（取消全部缩进）时，每一级的字符数
set expandtab                 " = 由于 Tab 键在不同的编辑器缩进不一致，该设置自动将 Tab 转为空格
set textwidth=80              " = 一行80个字符
set wrap                      " = 自动折行，即太长的行分成几行显示
set linebreak                 " = 只有遇到指定的符号（比如空格、连词号和其他标点符号），才发生折行。也就是说，不会在单词内部折行
set wrapmargin=2              " = 指定折行处与编辑窗口的右边缘之间空出的字符数
set scrolloff=5               " = 垂直滚动时，光标距离顶部/底部的位置（单位：行）
set sidescrolloff=15          " = 水平滚动时，光标距离行首或行尾的位置（单位：字符）。该配置在不折行时比较有用
set laststatus=2              " = 总显示最后一个窗口的状态行；设为1则窗口数多于一个的时候显示最后一个窗口的状态行；0不显示最后一个窗口的状态行
set ruler                     " = 在状态栏显示光标的当前位置（位于哪一行哪一列）
set showmatch                 " = 光标遇到圆括号、方括号、大括号时，自动高亮对应的另一个圆括号、方括号和大括号
set showtabline=2             " = 总是显示标签栏
set hlsearch                  " = 搜索时，高亮显示匹配结果
set ignorecase                " = 搜索忽略大小写
set nobackup                  " = 不创建备份文件。默认情况下，文件保存时，会额外创建一个备份文件，它的文件名是在原文件名的末尾，再添加一个波浪号（〜）
set noswapfile                " =
set helplang=cn               " = 中文文档
set nocompatible              " = 设置不兼容vi
set encoding=utf-8            " = 使用 utf-8 编码
set clipboard=unnamed


" === Leader 键
let mapleader=" "

" = 快速跳行
nnoremap J 10j
" = 快速跳行
nnoremap K 10k
" = 退出插入模式
inoremap jj <ESC>
" = 快速保存
nnoremap zz :w<CR>
" = 快速关闭窗口
noremap <Leader>q :q<CR>

" === Buffer 管理
nnoremap <Leader>e :tabn<CR>
nnoremap <Leader>b :tabp<CR>


" === NERDTree
noremap <F3> :NERDTreeToggle<CR> " = NERDTree / 打开NERDTree
noremap <Leader>l <c-w>l         " = 切换到右边窗口
noremap <Leader>w <c-w>w


let g:python3_host_prog="/Library/Frameworks/Python.framework/Versions/3.8/bin/python3"
" let g:loaded_python3_provider=1




" === 隐藏终端
let g:term_buf = 0
let g:term_win = 0

function! TermToggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize " . a:height
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let g:term_buf = bufnr("")
        endtry
        startinsert!
        let g:term_win = win_getid()
    endif
endfunction


nnoremap <F2> :call TermToggle(10)<cr>
tnoremap <F2> <C-\><C-n>:call TermToggle(10)<cr>



call plug#begin()


" A - 1 === 文件管理
" | 操作         | 描述                                                       | 目标        |
" |--------------+------------------------------------------------------------+-------------|
" | o            | Open files, directories and bookmarks                      | NERDTree-o  |
" | go           | Open selected file, but leave cursor in the NERDTree       | NERDTree-go |
" | t            | Open selected node/bookmark in a new tab                   | NERDTree-t  |
" | T            | Same as ‘t’ but keep the focus on the current tab          | NERDTree-T  |
" | i            | Open selected file in a split window（水平分割，分成上下） | NERDTree-i  |
" | gi           | Same as i, but leave the cursor on the NERDTree            | NERDTree-gi |
" | s            | Open selected file in a new vsplit(垂直分割，分成左右）    | NERDTree-s  |
" | gs           | Same as s, but leave the cursor on the NERDTree            | NERDTree-gs |
" | O            | Recursively open the selected directory                    | NERDTree-O  |
" | x            | Close the current nodes parent                             | NERDTree-x  |
" | X            | Recursively close all children of the current node         | NERDTree-X  |
" | e            | Edit the current dir                                       | NERDTree-e  |
" | <CR>         | same as                                                    | NERDTree-o  |
" | double-click | same as the                                                | NERDTree-o  |
" | middle-click | same as                                                    | NERDTree-i  |
" | D            | Delete the current bookmark                                | NERDTree-D  |
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" A - 2 === 表格动态对齐
Plug 'dhruvasagar/vim-table-mode' " === 表格插件  <Leader>tm

" A - 3 === 代码补全
" | 操作 | 描述     | 其他 |
" |------+----------+------|
" | K    | 查看文档 |      |
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=150

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> <Leader>h :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
" nmap <leader>rn <Plug>(coc-rename)
nmap <F6> <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
" nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
" nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
" nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
" nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
" nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
" nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
" nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
" nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>



let g:coc_global_extensions = [
      \ 'coc-css',
      \ 'coc-docker',
      \ 'coc-eslint',
      \ 'coc-explorer',
      \ 'coc-flutter-tools',
      \ 'coc-gitignore',
      \ 'coc-html',
      \ 'coc-json',
      \ 'coc-syntax',
      \ 'coc-tsserver',
      \ 'coc-snippets',
      \ 'coc-vetur',
      \ 'coc-go',
      \ 'coc-vimlsp',
      \ 'coc-yaml',
      \ 'coc-yank']

Plug 'posva/vim-vue'



" B - * === useful utilities
Plug 'jiangmiao/auto-pairs' " === auto pairs


" === 包裹
" | 操作  | 说明         | 其他                 |
" |-------+--------------+----------------------|
" | yssu' | 添加两边     | wrap the word with ' |
" | cst"  | 改变两边标签 |                      |
Plug 'tpope/vim-surround' " === ys | cs | ds + text object.


" === 注释
" | 操作    | 说明               | 其他 |
" |---------+--------------------+------|
" | gcc     | 注释               |      |
" | v >> gc | 可视模式 注释/撤销 |      |
Plug 'tpope/vim-commentary' " === gcc / v gc 注释或撤销 / gcu 撤销注释


" === 多光标
" | 操作  | 说明               | 其他 |
" |-------+--------------------+------|
" | <c-n> | 选择words/重复多选 |      |
" Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'terryma/vim-multiple-cursors'

" Default mapping
let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = '<Leader>n'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'




" === 状态栏
Plug 'vim-airline/vim-airline'


" === buffer 美化
" | 操作        | 说明                                                     | 其他 |
" |-------------+----------------------------------------------------------+------|
" | F5          | change tabline mode                                      |      |
" | N BS        | go to N tab (in tabs mode) or N buffer (in buffers mode) |      |
" | [b/]b       | go to count next/previous buffer                         |      |
" | cdw/cdl/cdt | set working directory (tab/local)                        |      |
" | cd?         | show tab informations (cwd, git dir, tag files)          |      |
" | \x?         | a list of all mappings                                   |      |
Plug 'mg979/vim-xtabline'


" === 标签
" | 操作       | 说明                                                                                        | 其他 |
" |------------+---------------------------------------------------------------------------------------------+------|
" | mx         | Toggle mark 'x' and display it in the leftmost column                                       |      |
" | dmx        | Remove mark 'x' where x is a-zA-Z                                                           |      |
" | m,         | Place the next available mark                                                               |      |
" | m.         | If no mark on line, place the next available mark. Otherwise, remove (first) existing mark. |      |
" | m-         | Delete all marks from the current line                                                      |      |
" | m<Space>   | Delete all marks from the current buffer                                                    |      |
" | ]`         | Jump to next mark                                                                           |      |
" | [`         | Jump to prev mark                                                                           |      |
" | ]'         | Jump to start of next line containing a mark                                                |      |
" | ['         | Jump to start of prev line containing a mark                                                |      |
" | `]         | Jump by alphabetical order to next mark                                                     |      |
" | `[         | Jump by alphabetical order to prev mark                                                     |      |
" | ']         | Jump by alphabetical order to start of next line having a mark                              |      |
" | '[         | Jump by alphabetical order to start of prev line having a mark                              |      |
" | m/         | Open location list and display marks from current buffer                                    |      |
" | m[0-9]     | Toggle the corresponding marker !@#$%^&*()                                                  |      |
" | m<S-[0-9]> | Remove all markers of the same type                                                         |      |
" | ]-         | Jump to next line having a marker of the same type                                          |      |
" | [-         | Jump to prev line having a marker of the same type                                          |      |
" | ]=         | Jump to next line having a marker of any type                                               |      |
" | [=         | Jump to prev line having a marker of any type                                               |      |
" | m?         | Open location list and display markers from current buffer                                  |      |
" | m<BS>      | Remove all markers                                                                          |      |
Plug 'kshenoy/vim-signature'


" === tags
Plug 'preservim/tagbar'

nmap <F8> :TagbarToggle<CR>


" === 文件检索j
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

nmap <c-\> :Files<CR>
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1





call plug#end()



