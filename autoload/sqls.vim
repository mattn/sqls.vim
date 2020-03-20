let s:commands = {}

function! sqls#execute_query() abort
    call sqls#lsp_execute_command({
    \   'server_name': 'sqls',
    \   'command_name': 'executeQuery',
    \   'command_args': [get(lsp#get_text_document_identifier(), 'uri', v:null)],
    \   'sync': v:false,
    \   'bufnr': bufnr('%'),
    \ })
endfunction

function! sqls#show_databases() abort
    echo 'no implements'
endfunction

function! sqls#show_tables() abort
    echo 'no implements'
endfunction

function! sqls#describe_table() abort
    echo 'no implements'
endfunction

function! sqls#lsp_execute_command(params) abort
    let l:command_name = a:params['command_name']
    let l:command_args = get(a:params, 'command_args', v:null)
    let l:server_name = get(a:params, 'server_name', '')
    let l:bufnr = get(a:params, 'bufnr', -1)
    let l:sync = get(a:params, 'sync', v:false)

    " create command.
    let l:command = { 'command': l:command_name }
    if l:command_args isnot v:null
        let l:command['arguments'] = l:command_args
    endif

    " execute command on local.
    if has_key(s:commands, l:command_name)
        try
            call s:commands[l:command_name]({
            \   'bufnr': l:bufnr,
            \   'server_name': l:server_name,
            \   'command': l:command,
            \ })
        catch /.*/
            call lsp#utils#error(printf('Execute command failed: %s', string(a:params)))
        endtry
        return
    endif

    " execute command on server.
    if !empty(l:server_name)
        call lsp#send_request(l:server_name, {
        \   'method': 'workspace/executeCommand',
        \   'params': l:command,
        \   'sync': l:sync,
        \   'on_notification': function('s:handle_execute_command', [l:server_name, l:command]),
        \ })
    endif
endfunction

function! s:handle_execute_command(server_name, command, data) abort
    if lsp#client#is_error(a:data['response'])
        call lsp#utils#error('Execute command failed on ' . a:server_name . ': ' . string(a:command) . ' -> ' . string(a:data))
    else
        " echo a:data['response']['result']
        call lsp#ui#vim#output#preview(a:server_name, a:data['response']['result'], {'statusline': ' LSP ExecuteCommand'})
    endif
endfunction