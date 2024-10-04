"Set the spelling
set spelllang=en_us
set spellfile=~/.config/nvim/spell/en.utf-8.add

"Disable visual mode with mouse:
set mouse=
set clipboard=unnamedplus

" Set the text width (tw) for automatic line breaking at 80 characters
set tw=80

" Disable line wrapping; long lines will continue horizontally and not wrap to the next line
set nowrap

" Disable all beeps and visual bells
set belloff=all

" Set the number of spaces that a tab character represents
set tabstop=4

" Convert tabs to spaces; this affects the behavior of the tab key and auto-indenting
set expandtab

" Set the number of spaces to use for each step of (auto)indent
set shiftwidth=4

" Begin Copilot suggested

" Set number of spaces for a tab when editing
set softtabstop=4

" Automatically indent new lines to match the indentation of the previous line
set autoindent

" Smartly decides on the indentation for new lines
set nosmartindent

" Use smart behavior for the tab key based on the text in the current line
set smarttab

" Automatically adjust case when searching
set smartcase

" Incrementally search while typing
set incsearch

" Highlight all matches while searching
set hlsearch

" Ignore case when searching, unless capital letters are used
set ignorecase

" Show line numbers on the left
set number

" Show line numbers relative to the current line
set relativenumber

" Highlight the line where the cursor is located
" set cursorline

" Set a column for visual alignment guides at column 80
" set colorcolumn=80

" Keep 5 lines above or below the cursor when scrolling
set scrolloff=5

" Enhance command-line completion to show a menu of possible options
set wildmenu

" Set the behavior of the command-line completion
set wildmode=list:longest

" Highlight matching brackets and parentheses
set showmatch

" Set the time to show matching parentheses
set matchtime=2

" Define additional pairs of characters to be considered as matching pairs
set matchpairs+=<:>

" Define another set of matching pairs
set matchpairs+=<:>
set matchpairs+=*:*

hi Visual ctermbg=green ctermfg=black

function! OllamaFormat() range
    " Save the current register contents
    let save_reg = getreg('"')
    let save_regtype = getregtype('"')
    
    " Yank the selected text
    normal! gvy
    
    " Get the selected text
    let selected_text = @"
    
    " Call the Python script with the selected text
    let result = system('python3 ai.py', selected_text)
    
    " Replace the selected text with the result
    exe "normal! gvc" . result . "\<Esc>"
    
    " Restore the register
    call setreg('"', save_reg, save_regtype)
endfunction

" Map the function to a key combination in visual mode
vnoremap <leader>s :call OllamaFormat()<CR>

" New Journal Entry
let @j = '/Beginning of .*\v(Notes|Journal\v)okkkk80i-j! date +"\%a \%b \%d, \%Y, \%H:\%M"idate: 0ji---kkkkkkkkkkkkkkkkkkkkzzi'

" Git commit and push macro
" let @g = ':w:!git add .:!git commit -m "Work Journal Entry":!git push'
let @z = ':w:!cp ~/.config/nvim/init.vim ./:!git add .:!git commit -am "Work Journal Entry":!git push'

" Git commit Obsidian
let @o = ':w:!cd ~/Repos/Obsidian && git add . && git commit -m "Obsidian Update" && git push; cd -'

let @g = '@z@o'

" Re-load init.vim
let @i = ':source ~/.config/nvim/init.vim'

" Automatically correct the before-cursor mispelling
let @s = '[s1z=e'

" Python SimpleNotes import and delete
let @p = ':!python3 import_notes.py:r simplenote.md'
let @d = ':!python3 permanently_delete_notes.py'

let g:copilot_filetypes = {
\ 'python': v:true,
\ 'markdown': v:false,
\ 'text': v:false
\ }

" noremap <F3> :set relativenumber! <CR> :set number! <CR>
let @n = ':set relativenumber! <CR> :set number! <CR>'

au BufRead,BufNewFile journal.txt set filetype=markdown
