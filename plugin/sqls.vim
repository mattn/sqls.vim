let g:sqls_loaded = 1

command! SqlsExecuteQuery call sqls#execute_query()
command! SqlsShowDatabases call sqls#show_databases()
command! SqlsShowConnections call sqls#show_connections()
command! SqlsShowTables call sqls#show_tables()
command! SqlsDescribeTable call sqls#describe_table()
command! -nargs=? SqlsSwitchDatabase call sqls#switch_database(<f-args>)
command! -nargs=? SqlsSwitchConnection call sqls#switch_connection(<f-args>)

nnoremap <plug>(sqls-execute-query) :<C-U>call sqls#execute_query()<CR>
nnoremap <plug>(sqls-show-databases) :<C-U>call sqls#show_databases()<CR>
nnoremap <plug>(sqls-show-connections) :<C-U>call sqls#show_connections()<CR>
nnoremap <plug>(sqls-show-tables) :<C-U>call sqls#show_tables()<CR>
nnoremap <plug>(sqls-describe-table) :<C-U>call sqls#describe_table()<CR>
nnoremap <plug>(sqls-switch-database) :<C-U>call sqls#switch_database()<CR>
nnoremap <plug>(sqls-switch-connection) :<C-U>call sqls#switch_connection()<CR>
