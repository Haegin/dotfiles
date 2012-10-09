" This is pretty much entirely based off the FreeAgent house style

setlocal tabstop=2                   " Tabstop = 2 chars
setlocal shiftwidth=2                " Tabstop = 2 chars (autoindenting)
setlocal softtabstop=2               " Width of spaces that vim uses as a tab

"" Ruby specific autocomplete stuff
setlocal omnifunc=rubycomplete#Complete
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_rails = 1
let g:rubycomplete_classes_in_global = 1
compiler ruby
