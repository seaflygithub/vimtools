"Adding Brief Headers(You can modify it)
"map <F2> :AddHeader<CR>        #Adds brief author information
"map <F2> :AddMinHeader<CR>     #Adds minified version of author information
"Adding Lincenses
"map <F2> :AddMITLicense<CR>    # Adds MIT License with author info
"map <F2> :AddApacheLicense<CR> # Adds Apache License with author info
"map <F2> :AddGNULicense<CR>    # Adds GNU License with author info

let g:header_field_filename = 1
let g:header_field_timestamp = 1
let g:header_field_timestamp_format = '%Y.%m.%d'
map <F2> :AddGNULicense<CR>
"let g:header_field_author = 'Your Name'
"let g:header_field_author_email = 'your@mail'
