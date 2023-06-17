set number "行番号を表示する
set title "編集中のファイル名を表示
set showmatch "括弧入力時の対応する括弧を表示
set expandtab
set tabstop=2 "インデントをスペース4つ分に設定
set shiftwidth=2
set autoindent "オートインデント
set completeopt+=menuone

set clipboard=unnamed

" # replace word in curor 
" https://qiita.com/itmammoth/items/312246b4b7688875d023
nmap # <Space><Space>:%s/<C-r>///g<Left><Left>
inoremap <C-]> <Esc><Right>
noremap <Leader>v vey

" for slim template https://qiita.com/_KASA_/items/f2a6507fede38b3662e3
autocmd BufRead,BufNewFile *.slim setfiletype slim

" for rust
au BufRead,BufNewFile *.rs setfiletype=rust
