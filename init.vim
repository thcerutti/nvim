call plug#begin("~/.vim/plugged")
 Plug 'dracula/vim'
 Plug 'scrooloose/nerdtree'
 Plug 'neoclide/coc.nvim', {'branch': 'release'}
 let g:coc_global_extensions = ['coc-emmet', 'coc-css', 'coc-cssmodules', 'coc-html', 'coc-json', 'coc-prettier', 'coc-tsserver', 'coc-angular',  'coc-git', 'coc-highlight', 'coc-snippets' ]
 Plug 'OmniSharp/omnisharp-vim'
 Plug 'tpope/vim-fugitive'
 Plug 'puremourning/vimspector'
 Plug 'dense-analysis/ale'
 Plug 'leafgarland/typescript-vim'
 Plug 'github/copilot.vim'
 Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
 Plug 'junegunn/fzf.vim'
 Plug 'vim-airline/vim-airline'
 Plug 'vim-airline/vim-airline-themes'
 Plug 'ryanoasis/vim-devicons'
call plug#end()

" Airline configuraiton
let g:airline_theme='dracula'
let g:airline_extensions = ['branch', 'tabline']
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = ' '
let g:airline#extensions#tabline#formatter = 'default'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#coc#enabled = 1
let airline#extensions#coc#error_symbol = 'E:'
let airline#extensions#coc#warning_symbol = 'W:'
let g:airline#extensions#coc#show_coc_status = 1
let g:airline#extensions#fzf#enabled = 1
let g:airline_powerline_fonts = 1
let g:webdevicons_enable_airline_tabline = 1
let g:vimspector_enable_mappings = 'HUMAN'

" Configure Airline Symbols
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.colnr = ':'
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ' :'
let g:airline_symbols.maxlinenr = ' | '
let g:airline_symbols.dirty='⚡'

" General settings
syntax enable
colorscheme dracula
set number          " Line numbers
set mouse+=a
set t_Co=256        " Support 256 colors
set updatetime=300  " Faster completion
set timeoutlen=500  " By default timeoutlen is 1000 ms
set splitright 		  " open new split panes to right and below
set splitbelow
set encoding=utf-8  " Set internal encoding of vim, not needed on neovim
set hidden          " TextEdit might fail if hidden is not set.
set nobackup        " Some servers have issues with backup files, see #649.
set nowritebackup
set cmdheight=2     " Give more space for displaying messages.
set updatetime=300  " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable delays and poor user experience.
set shortmess+=c    " Don't pass messages to 'ins-completion-menu'.
set clipboard=unnamedplus   " set clipboard provider

" tab configuration
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent
set expandtab       " tabs are space
set autoindent
set copyindent      " copy indent from the previous line

" OmniSharp key bindings
nnoremap <silent> <C-p><C-d> :OmniSharpPreviewDefinition<CR>
nnoremap <silent> <C-p><C-a> :OmniSharpGetCodeActions<CR>
nnoremap <silent> <C-p><C-g> :OmniSharpGotoDefinition<CR>
nnoremap <silent> <C-p><C-r> :OmniSharpRename<CR>
nnoremap <silent> <C-p><C-i> :OmniSharpFindImplementations<CR>

" GitHub Copilot
imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

" NERDTree configutration
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
" Toggle NERDTree
nnoremap <c-t> :NERDTreeToggle<CR> 

" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>
" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
" open terminal on ctrl+n
function! OpenTerminal()
  split term://bash
 " resize 10
endfunction
nnoremap <c-n> :call OpenTerminal()<CR>

" ---[FZF key mapping]---
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1
nnoremap <A-g> :GFiles<CR>
nnoremap <A-o> :Files<CR>
" ---[FZF key mapping]---

" ---[Vimspector key mapping]---
nnoremap <silent> <A-v><A-r> :VimspectorReset<CR>
" for normal mode - the word under the cursor
nmap <Leader>di <Plug>VimspectorBalloonEval
" for visual mode, the visually selected text
xmap <Leader>di <Plug>VimspectorBalloonEval

function CreateSampleDotnetDebuggerFile()
    terminal cp ~/.config/nvim/vimspector-debuggers/dotnet.json .vimspector.json
endfunction
nnoremap <A-v><A-j> :call CreateSampleDotnetDebuggerFile()<CR>
" ---[Vimspector key mapping]---

" use alt+hjkl to move between split/vsplit panels
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Buffers key bidings
nnoremap <A-,> :bprevious<CR>
nnoremap <A-.> :bnext<CR>
