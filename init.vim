set wildmenu
set incsearch
set nobackup
set noswapfile
syntax on
filetype plugin indent on

set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,sjis,iso-2022-jp,euc-jp,default
set fileformat=unix
set fileformats=unix,dos,mac
set langmenu=C.utf-8
language C

" My_Stile
set ambiwidth=single
set tabstop=4
set shiftwidth=4
set showcmd
set number
set showmatch
set notermguicolors
colorscheme vim
set bg=dark
set laststatus=2
set statusline=%F%m%h%w\ %=\ [%{&fenc!=''?&fenc:&enc},%{&ff},type:%Y]\ [%3l,%3v]
highlight NonText ctermfg=darkgray
set list
set listchars=tab:>-,trail:_,extends:>,precedes:<
