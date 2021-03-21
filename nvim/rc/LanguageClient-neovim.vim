" 各言語の Language Server の起動コマンド
let g:LanguageClient_serverCommands = {
            \'go': [
            \  'gopls'
            \],
            \'rust': [
            \  '/path/to/rls',
            \],
            \'vue': ['vls'],
            \'ruby': ['solargraph', 'stdio'],
            \'html': [],
            \'css': [],
            \'javascript': ['javascript-typescript-stdio'],
            \'typescript': ['javascript-typescript-stdio'],
            \ }

" Golang
let g:LanguageClient_diagnosticsSignsMax                = v:null
let g:LanguageClient_changeThrottle                     = v:null
let g:LanguageClient_autoStart                          = 1
let g:LanguageClient_autoStop                           = 1
let g:LanguageClient_selectionUI                        = 'fzf'
let g:LanguageClient_selectionUI_autoOpen               = 0
let g:LanguageClient_trace                              = 'off'
let g:LanguageClient_diagnosticsEnable                  = 1
let g:LanguageClient_loadSettings                       = 1
let g:LanguageClient_windowLogMessageLevel              = 'Warning'
let g:LanguageClient_hoverPreview                       = 'Always'
let g:LanguageClient_fzfContextMenu                     = 1
let g:LanguageClient_diagnosticsList                    = 'Quickfix'
let g:LanguageClient_useVirtualText                     = 'Diagnostics'
let g:LanguageClient_virtualTextPrefix                  = '>> '
let g:LanguageClient_useFloatingHover                   = 1
let g:LanguageClient_usePopupHover                      = 1
let g:LanguageClient_floatingHoverHighlight             = 'Normal:Pmenu'
let g:LanguageClient_completionPreferTextEdit           = 0
let g:LanguageClient_waitOutputTimeout                  = 100
let g:LanguageClient_echoProjectRoot                    = 0
let g:LanguageClient_hideVirtualTextsOnInsert           = 1
let g:LanguageClient_diagnosticsMaxSeverity             = 'Hint'
let g:LanguageClient_applyCompletionAdditionalTextEdits = 1
let g:LanguageClient_preferredMarkupKind                = ['markdown', 'plaintext']
let g:LanguageClient_floatingWindowStyle                = 'minimal'
let g:LanguageClient_diagnosticsIgnoreSources           = ['go mod tidy']

" vue
let g:LanguageClient_loadSettings=1
let g:LanguageClient_settingsPath="$HOME/.config/nvim/lang-client-settings.json"



" ドキュメントのハイライトをトグルさせるための設定
let s:ls_is_highlighting_document = v:false
function! s:ls_toggle_document_highlight() abort
    if !s:ls_is_highlighting_document
        call LanguageClient#textDocument_documentHighlight()
        let s:ls_is_highlighting_document = v:true
    else
        call LanguageClient#clearDocumentHighlight()
        let s:ls_is_highlighting_document = v:false
    end
endfunction

" ドキュメントの表示をトグルさせるための設定
function! s:ls_toggle_document_hover() abort
    let hover_buf = s:ls_get_hover_buf()
    if hover_buf == 0
        call LanguageClient#textDocument_hover()
    else
        execute(printf('bwipe! %s', hover_buf))
    endif
endfunction

function! s:ls_get_hover_buf() abort
    for w in nvim_list_wins()
        let bufnum = nvim_win_get_buf(w)
        let bufname = bufname(bufnum)
        if bufname ==# '__LanguageClient__'
            return bufnum
        endif
    endfor

    return 0
endfunction

" 定義ジャンプ後にコールバックで呼ぶ関数
function! Language_client_definition_callback(output, ...) abort
    normal! zz
    call vista#util#Blink(3, 100)
endfunction

" マッピングの設定
function! s:map_language_client_functions() abort
    if has_key(g:LanguageClient_serverCommands, &filetype)
        nnoremap <silent> lv        :<C-u>call LanguageClient#explainErrorAtPoint()<CR>
        nnoremap <silent> li        :<C-u>call LanguageClient#textDocument_implementation()<CR>
        nnoremap <silent> lkr       :<C-u>call LanguageClient#textDocument_references()<CR>
        nnoremap <silent> lr        :<C-u>call LanguageClient#textDocument_rename()<CR>
        nnoremap <silent> <Leader>i :<C-u>call <SID>ls_toggle_document_hover()<CR>
        " nnoremap <silent> gd        :<C-u>call LanguageClient#textDocument_definition({'handle': v:true}, function('Language_client_definition_callback'))<CR>
        nnoremap ld        :<C-u>call LanguageClient#textDocument_definition()<CR>
        nnoremap <silent> gsi       :<C-u>silent call <SID>ls_toggle_document_highlight()<CR>
        nnoremap <silent> gc        :<C-u>silent Vista finder fzf:lcn<CR>
    endif
endfunction

autocmd FileType * call s:map_language_client_functions()
autocmd BufWritePre *.go :call LanguageClient#textDocument_formatting_sync()

