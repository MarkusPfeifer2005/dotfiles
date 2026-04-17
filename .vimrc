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
Plug 'Yggdroot/indentLine'  " A vim plugin to display the indention levels with thin vertical lines
Plug 'lervag/vimtex'

call plug#end()

autocmd VimEnter * if isdirectory(expand('~/.vim/plugged/coc.nvim')) && !len(glob('~/.config/coc/extensions/node_modules/coc-clangd')) | CocInstall -sync coc-clangd coc-pyright | endif

syntax on
colorscheme codedark
set foldmethod=syntax

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

" Set cursor shape for Insert mode (I-beam)
let &t_SI = "\<Esc>[6 q"  " I-beam cursor in Insert mode (GUI/true color terminals)
let &t_EI = "\<Esc>[2 q"  " Block cursor in Normal mode (GUI/true color terminals)

filetype on
filetype plugin on
filetype indent on

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" view .choreo files as .json
autocmd BufRead,BufNewFile *.choreo set filetype=json

" Fix clipboard on sway (wayland)
" https://www.reddit.com/r/Fedora/comments/ax9p9t/vim_and_system_clipboard_under_wayland/
xnoremap "+y y:call system("wl-copy", @")<cr>
nnoremap "+p :let @"=substitute(system("wl-paste --no-newline"), '<C-v><C-m>', '', 'g')<cr>p
nnoremap "*p :let @"=substitute(system("wl-paste --no-newline --primary"), '<C-v><C-m>', '', 'g')<cr>p

