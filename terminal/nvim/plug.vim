let g:plug_home = stdpath('data') . '/plugged'

call plug#begin()

Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'cohama/lexima.vim'
Plug 'preservim/nerdtree'
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'hoob3rt/lualine.nvim'
Plug 'ryanoasis/vim-devicons'
Plug 'andweeb/presence.nvim'
Plug 'bluz71/vim-moonfly-colors'

call plug#end()
