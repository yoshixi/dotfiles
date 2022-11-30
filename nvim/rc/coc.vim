let g:coc_global_extensions = [
  \ 'coc-solargraph',
  \ 'coc-json',
  \ 'coc-tsserver',
  \ 'coc-prettier',
  \ 'coc-eslint',
  \ ]

nnoremap ,j :CocCommand prettier.formatFile<CR>
" nnoremap gd <Plug>(coc-definition)
nnoremap gd :call CocAction('jumpDefinition', 'vsplit')<CR>
nnoremap <C-]> :call CocAction('jumpDefinition', 'vsplit')<CR>

keyset("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})
keyset("n", "gr", "<Plug>(coc-references)", {silent = true})noremap gr <Plug>(coc-references)

inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
