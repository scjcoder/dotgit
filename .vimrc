" Auto reload .vimrc when changed
augroup reload_vimrc " {
	    autocmd!
	        autocmd BufWritePost $MYVIMRC source $MYVIMRC
	augroup END " }

set nocompatible              " be iMproved, required
filetype off                  " required

" Set Space bar to unfold text if on fold
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

augroup vimrc
	au BufReadPre * setlocal foldmethod=indent
	au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
augroup END

" Saves fold views when closing files & restores again when opened
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview

" set the runtime path to include Vundle and initialize
"set rtp+=~/.vim/bundle/Vundle.vim
"call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
"Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
"call vundle#end()            " required
"filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Vim tips from http://www.bestofvim.com
syntax on
set number
set laststatus=2
set showbreak=↪
filetype plugin indent on
let @a=':w<CR>:!./install<CR>a<ESC>'

" Markdown settings
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_frontmatter=1

" Airline Settings
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" Key mappings
nnoremap <F5> :GundoToggle<CR>
nnoremap <CR> :noh<CR><CR>

" Functionality duplicated by vim-airline
" Removes trailing spaces
"function! TrimWhiteSpace()
"	    %s/\s\+$//e
"    endfunction

"    nnoremap <silent> <Leader>rts :call TrimWhiteSpace()<CR>

"autocmd FileWritePre    * :call TrimWhiteSpace()
"autocmd FileAppendPre   * :call TrimWhiteSpace()
"autocmd FilterWritePre  * :call TrimWhiteSpace()
"autocmd BufWritePre     * :call TrimWhiteSpace()

" Pathogen Plugin Manager
call pathogen#infect()

" NerdTree opens if no file specified on vim open
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
