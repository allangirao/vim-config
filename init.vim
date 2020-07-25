"""
""" NeoVim configuration
""" Allan Girao
"""

" Show line number
set number

" Set encoding
set encoding=UTF-8

" Smart indent
" set smartindent
set autoindent
set expandtab
set softtabstop=2
set shiftwidth=2
" set tabstop=2

" Set font (is it necessary?)
" set guifont=UbuntuMono\ Nerd\ Font\ 11

" filetype plugin on

" Set abandoned buffers as hidden, not unloading them
set hidden

""" Set diff to vertical
:set diffopt+=vertical

"""------ Vim Plug -----

call plug#begin('~/.vim/plugged')

" Add file navigator
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Show git status flags for files in NERDTree.
Plug 'Xuyuanp/nerdtree-git-plugin'

" Add color to devicons.
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
" TODO: this plugin is overriding executable files color

" Add file icons. It requires an installation of a Nerd Font (https://github.com/ryanoasis/nerd-fonts).
" After installing the font, exit terminal and re-run.
Plug 'ryanoasis/vim-devicons'

" Shows signs for added, modified, and removed lines.
Plug 'airblade/vim-gitgutter'

" Dark theme PaleNight
Plug 'drewtempelmeyer/palenight.vim'

" Comment/uncomment row
Plug 'preservim/nerdcommenter'

" Git command inside Vim
Plug 'tpope/vim-fugitive'

" Search in project
Plug 'ctrlpvim/ctrlp.vim'

" Typescript highlight
" Plug 'leafgarland/typescript-vim'

" Autocomplete
" Plug 'valloric/youcompleteme'

Plug 'vim-airline/vim-airline'

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#show_tab_nr = 0

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

" Remove 'Press ? for help'
let NERDTreeMinimalUI = 1

"""---------------------
"""----- Dev icons -----

" Change folder icon if it's opened or closed
let g:DevIconsEnableFoldersOpenClose = 1

" Set regular file icon
let g:WebDevIconsUnicodeDecorateFileNodesDefaultSymbol = ''

"""---------------------
"""----- nerdcommenter ------

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
"""------ CtrlP --------

" Ignore some files and folders
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](site\-packages|node_modules|__pycache__)|(\.(git|hg|svn))$',
  \ 'file': '\v\.(pyc|exe|so|dll)$',
  \ }

"""---------------------
"""------ Theme --------

set background=dark
colorscheme palenight
" Change colors on vimdiff
highlight DiffAdd    gui=none guifg=bg guibg=#90D090
highlight DiffDelete gui=none guifg=bg guibg=#EC7C7C
highlight DiffChange gui=none guifg=bg guibg=#6090C0
highlight DiffText   gui=none guifg=bg guibg=#8FBFE7
"""---------------------
"""---- Highlight ------

set cursorline
highlight CursorLine guibg=#404050
highlight Cursor guibg=#606070

"""---------------------
"""---- Column 80 ------

set colorcolumn=80
"""---------------------
"""----- Commands ------

" Close current buffer
command! Q :call CloseCurrentBuffer(0)

"""---------------------
"""---- Shortcuts ------

" Ctrl + N => Open NERDTree
nmap <C-n> :NERDTreeToggle<CR>
nmap <C-f> :NERDTreeFind<CR>

" Ctrl + => Go to NERDTree TODO


" Ctrl + / => Toggle comment line (visual and normal mode)
nmap <C-_> <plug>NERDCommenterToggle
vmap <C-_> <plug>NERDCommenterToggle


" Switch between different windows by their direction
nnoremap <silent> <A-Down> <C-w>j| "switching to below window
nnoremap <silent> <A-Up> <C-w>k| "switching to above window
nnoremap <silent> <A-Right> <C-w>l| "switching to right window
nnoremap <silent> <A-Left> <C-w>h| "switching to left window

" Switch between different buffers by their direction
nnoremap <silent> <C-Right> :call NextBuf()<CR>
nnoremap <silent> <C-Left> :call PrevBuf()<CR>

" Map Ctrl + P to search for files in current directory,
" where current directory is NERDTree Root (if available) or cwd
let g:ctrlp_map = 0
nmap <C-p> :CtrlP GetCwd()<CR>

" Exchange line position with Alt+k (line up) or Alt+j (line down)
nmap <A-k> ddkP
nmap <A-j> ddp

" Map to copy to clipboard
vmap <C-c> "+y
vmap <C-v> "+p

"""---------------------
"""---- Automation -----

" Remove all trailing spaces on save
autocmd BufWritePre * %s/\s\+$//e

" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
            \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif

" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" Autorefresh NERDTree
" TODO: TOO SLOW
" autocmd CursorHold,CursorHoldI * if (exists("g:NERDTree")) | exe 'NERDTreeRefreshRoot' | endif
"""---------------------
function! GetCwd()
  if exists('g:NERDTree')
    return g:NERDTree.ForCurrentTab().getRoot().path.str()
  else
    return getcwd()
  endif
endfunction

function! CloseCurrentBuffer(force)
  let current_buff = bufnr("%")
  let is_modified = &mod
  if a:force
    exe 'bd! '.current_buff | bp
  elseif is_modified
    " Improve to look like natural quit command
    echo 'Your file has unsaved changes'
  else
      exe 'bp'
      exe 'bd '.current_buff
  endif
  "
endfunction

function! NextBuf()
  if IsCurrentBufferNERDTree()
    exe "normal \<C-W>\<C-w>"
  else
    exe 'bn'
  endif
endfunction

function! PrevBuf()
  if IsCurrentBufferNERDTree()
    exe "normal \<C-W>\<C-w>"
  else
    exe 'bp'
  endif
endfunction

function! IsCurrentBufferNERDTree()
  let nerdtree_regex = g:NERDTreeCreator.BufNamePrefix().'*'
  let current_buffer_name = bufname('%')
  return current_buffer_name =~ nerdtree_regex
endfunction
