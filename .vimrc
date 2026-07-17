set nocompatible              " be iMproved, required by Vundle
filetype off                  " required by Vundle


" ============================================================
" Vundle plugin manager
" ============================================================
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Vundle manages itself (leave this one enabled)
Plugin 'gmarik/Vundle.vim'

" --- Plugins are added back one at a time below ---
" Uncomment a line, then run :PluginInstall in vim.
Plugin 'rakr/vim-one'                " One color theme
Plugin 'preservim/nerdtree'          " File-tree sidebar (was scrooloose/nerdtree)
Plugin 'itchyny/lightline.vim'       " Statusline at the bottom
Plugin 'dense-analysis/ale'          " Async linter (was w0rp/ale)
Plugin 'neoclide/coc.nvim', {'branch': 'release'}  " LSP autocomplete (Node-based)

call vundle#end()             " required
filetype plugin indent on     " required


" ============================================================
" Plugin config (kept commented until each plugin is enabled)
" ============================================================

" --- lightline ---
set laststatus=2                          " always show the statusline
if !has('gui_running')
  set t_Co=256                            " use 256 colors in the terminal
endif
set noshowmode                            " hide the default -- INSERT --, lightline shows it
let g:lightline = {'colorscheme': 'one',} " match the vim-one theme

" --- NERDTree ---
" Close vim if NERDTree is the only window left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Toggle the file tree. (Was <C-w>, which clobbers vim's window-command prefix.)
nnoremap <C-n> :NERDTreeToggle<CR>

" --- ALE ---
" Linters report problems (they don't modify your file).
let g:ale_linters = {'python': ['pylint', 'pycodestyle'], 'sh': ['shellcheck']}

" --- coc.nvim (autocomplete) ---
" Tab / Shift-Tab to move through the completion popup.
inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ "\<Tab>"
inoremap <silent><expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
" Enter confirms the highlighted completion.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
" gd = go to definition, K = show docs in a popup.
nmap <silent> gd <Plug>(coc-definition)
nnoremap <silent> K :call CocActionAsync('doHover')<CR>


" ============================================================
" Core settings (built-in, no plugins needed)
" ============================================================
set number relativenumber
set backspace=indent,eol,start
syntax on
set tabstop=4
set background=dark

" vim-one theme (true colors give the best result in a modern terminal)
if (has("termguicolors"))
  set termguicolors
endif
colorscheme one

" Use the terminal's own background instead of the theme's gray.
" Must come AFTER colorscheme, or the theme overrides it.
highlight Normal      ctermbg=NONE guibg=NONE
highlight NonText     ctermbg=NONE guibg=NONE
highlight EndOfBuffer ctermbg=NONE guibg=NONE
