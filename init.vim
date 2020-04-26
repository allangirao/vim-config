"""
""" NeoVim configuration
""" Allan Girao
"""

" Show line number
set number

" Set encoding
set encoding=UTF-8

" Set font (is it necessary?)
" set guifont=UbuntuMono\ Nerd\ Font\ 11

" filetype plugin on

"""------ Vim Plug -----

call plug#begin('~/.vim/plugged')

" Add file tab navigator
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Show git status flags for files in NERDTree.
Plug 'Xuyuanp/nerdtree-git-plugin'

" Add color to devicons. Not working yet.
" Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Add file icons. It requires an installation of a Nerd Font (https://github.com/ryanoasis/nerd-fonts).
" After installing the font, exit terminal and re-run.
Plug 'ryanoasis/vim-devicons'

" Shows signs for added, modified, and removed lines.
Plug 'airblade/vim-gitgutter'

" Dark theme PaleNight
Plug 'drewtempelmeyer/palenight.vim'

" Comment/uncomment row
Plug 'preservim/nerdcommenter'

call plug#end()

"""---------------------
"""----- NERDTree ------

" Open NERDTree automatically when vim starts up with no files specified.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | exe 'NERDTree' | endif

" Open NERDTree automatically when vim starts up on opening a directory.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" Close vim if the only window left open is a NERDTree.
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Hide folder arrows
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''

"""---------------------
"""------- Git  --------

" Set git status icons
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "M",
    \ "Staged"    : "A",
    \ "Untracked" : "U",
    \ "Renamed"   : "R",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "D",
    \ "Dirty"     : "•",
    \ "Clean"     : "✔︎",
    \ "Ignored"   : "☒",
    \ "Unknown"   : "?"
    \ }

"""---------------------
"""----- Dev icons -----

" Change folder icon if it's opened or closed
let g:DevIconsEnableFoldersOpenClose = 1

" Set regular file icon
let g:WebDevIconsUnicodeDecorateFileNodesDefaultSymbol = ''

"""---------------------
"""----- Comments ------

" Add space after comment character(s)
let g:NERDSpaceDelims = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1

"""---------------------
"""---- True Colors ----

if (has("nvim"))
  " For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

" For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
" Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  set termguicolors
endif

"""---------------------
"""------ Theme --------

set background=dark
colorscheme palenight

"""---------------------
"""---- Highlight ------

set cursorline
highlight CursorLine guibg=#404050
highlight Cursor guibg=#606070

"""---------------------
"""---- Shortcuts ------

" Ctrl + N => Open NERDTree
nmap <C-n> :NERDTreeToggle<CR>

" Ctrl + / => Toggle comment line (visual and normal mode)
nmap <C-_> <plug>NERDCommenterToggle
vmap <C-_> <plug>NERDCommenterToggle

"""---------------------

