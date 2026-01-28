set nocompatible

" vimplug see: https://github.com/junegunn/vim-plug?tab=readme-ov-file
" and: https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

" List your plugins here
Plug 'tomasiser/vim-code-dark'  " Dark color scheme for Vim and vim-airline, inspired by Dark+ in Visual Studio Code 
Plug 'sheerun/vim-polyglot'  " A solid language pack for Vim. (syntax highlighting)
Plug 'neoclide/coc.nvim', {'branch': 'release'}  " Nodejs extension host, load extensions like VSCode and host language servers.
Plug 'jiangmiao/auto-pairs'  " Vim plugin, insert or delete brackets, parens, quotes in pair
Plug 'preservim/nerdtree'  " A tree explorer plugin for vim. 
Plug 'Yggdroot/indentLine'  " A vim plugin to display the indention levels with thin vertical lines
Plug 'lervag/vimtex'

call plug#end()

autocmd VimEnter * if isdirectory(expand('~/.vim/plugged/coc.nvim')) && !len(glob('~/.config/coc/extensions/node_modules/coc-clangd')) | CocInstall -sync coc-clangd coc-pyright | endif

syntax on
colorscheme codedark
set foldmethod=syntax
filetype plugin indent on

" === Autocompletion like VSCode / PyCharm ===

" Use <Tab> for trigger completion or navigate
inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ "\<Tab>"

" Use <S-Tab> (Shift-Tab) to go backwards in the popup
inoremap <silent><expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Press Enter to confirm the selection, or fallback to newline
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

" Trigger completion manually (like Ctrl+Space in VSCode)
inoremap <silent><expr> <C-Space> coc#refresh()

inoremap <c-b> <Esc>:NERDTreeToggle<cr>
nnoremap <c-b> <Esc>:NERDTreeToggle<cr>

" Set cursor shape for Insert mode (I-beam)
let &t_SI = "\<Esc>[6 q"  " I-beam cursor in Insert mode (GUI/true color terminals)
let &t_EI = "\<Esc>[2 q"  " Block cursor in Normal mode (GUI/true color terminals)

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

au BufNewFile,BufRead *.py set tabstop=4
au BufNewFile,BufRead *.py set softtabstop=4
au BufNewFile,BufRead *.py set shiftwidth=4
au BufNewFile,BufRead *.py set textwidth=79
au BufNewFile,BufRead *.py set expandtab
au BufNewFile,BufRead *.py set autoindent
au BufNewFile,BufRead *.py set fileformat=unix

let python_highlight_all=1

" Enable VimTeX syntax and indentation
filetype plugin indent on
" Enable continuous compilation
let g:vimtex_compiler_method = 'latexmk'
" Enable automatic PDF viewer
let g:vimtex_view_method = 'zathura'
" Disable concealment completely
let g:tex_conceal = ""
let g:vimtex_syntax_conceal_disable = 1
set conceallevel=0
set concealcursor=
let g:indentLine_fileTypeExclude = ['tex']
" save & compile shortcut [F5]
nnoremap <F5> :w<CR>:VimtexCompile<CR>:echo "Compiled!"<CR>
" disable warnings
"let g:vimtex_quickfix_mode = 0

" view .choreo files as .json
autocmd BufRead,BufNewFile *.choreo set filetype=json

