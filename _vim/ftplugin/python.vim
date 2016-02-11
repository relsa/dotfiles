setlocal nosmartindent
setlocal smarttab
setlocal expandtab
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal commentstring=#%s

function! s:hl_python_keyword()
    highlight! link PythonIdentifier Identifier
    syntax keyword PythonIdentifier self cls
endfunction

autocmd BufWinEnter,ColorScheme,Syntax * call s:hl_python_keyword()
