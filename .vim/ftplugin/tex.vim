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
nnoremap <F5> :w<CR>:VimtexCompile<CR>

