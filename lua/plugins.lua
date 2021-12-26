local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://hub.fastgit.org/wbthomason/packer.nvim', install_path})
  vim.cmd [[packadd packer.nvim]]
end


local packer = require('packer')
packer.startup({
  function()
    use 'camspiers/lens.vim'
    use 'kongjun18/vim-rest-reminder'
    use 'kshenoy/vim-signature'
    use 'jeffkreeftmeijer/vim-numbertoggle'
    use 'kdav5758/TrueZen.nvim'
    use 'nacro90/numb.nvim'
    use 'andymass/vim-matchup'
    use 'rhysd/accelerated-jk'
    use 'bronson/vim-visual-star-search'
    use 'wincent/terminus'
    use 'vim-utils/vim-man'
    use 'farmergreg/vim-lastplace'
    use 'xolox/vim-misc'
    use 'xolox/vim-session'
    use 'wellle/targets.vim'
    use 'haya14busa/is.vim'
    use 'tommcdo/vim-exchange'
    use {
      'kyazdani42/nvim-tree.lua',
      requires = {
        'kyazdani42/nvim-web-devicons',
      },
      config = function() require'nvim-tree'.setup {} end
    }
    use {'preservim/nerdcommenter', config=function() vim.api.nvim_call_function('CreateCommenterMappings', {}) end}
    use 'jiangmiao/auto-pairs'
    use 'kongjun18/vim-unimpaired'
    use 'junegunn/vim-easy-align'
    use 'Chiel92/vim-autoformat'
    use 'machakann/vim-sandwich'
    use 'machakann/vim-highlightedyank'
    use 'lilydjwg/fcitx.vim'
    use 'ianding1/leetcode.vim'
    use 'vimwiki/vimwiki'
    use 'vim-scripts/gtags.vim'
    use 'preservim/tagbar'
    use {'kongjun18/vim-gutentags', config='vim.cmd[[UseLspTag]]'}
    use 'skywind3000/gutentags_plus'
    use 'puremourning/vimspector'
    use 'junegunn/gv.vim'
    use {'lewis6991/gitsigns.nvim', requires='nvim-lua/plenary.nvim'}
    use 'luochen1990/rainbow'
    use 'itchyny/vim-cursorword'
    use 'lfv89/vim-interestingwords'
    use {'nvim-treesitter/nvim-treesitter',
    requires = {'nvim-treesitter/nvim-treesitter-textobjects',
    after='nvim-treesitter'},
  }
  use {'turbio/bracey.vim', ft={'css', 'html', 'javascript'},
  run = 'npm install --registry=https://registry.npm.taobao.org --prefix server'}
  use 'norcalli/nvim-colorizer.lua'
  use {'kristijanhusak/vim-dadbod-ui', requires={'kristijanhusak/vim-packager', 'tpope/vim-dadbod'}}
  use 'tpope/vim-projectionist'
  use 'tpope/vim-rsi'
  use 'tpope/vim-repeat'
  use 'tpope/vim-endwise'
  use 'tpope/vim-characterize'
  use 'tpope/vim-sleuth'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'cormacrelf/vim-colors-github'
  use 'editorconfig/editorconfig-vim'
  use {'Yggdroot/LeaderF', run=':LeaderfInstallCExtension'}
  use {'neoclide/coc.nvim', branch = 'master', run = 'yarn install --registry=https://registry.npm.taobao.org --frozen-lockfile'}
  use 'dense-analysis/ale'
  use {'https://gitee.com/kongjun18/vim-doge', run = function() vim.fn['doge#install']() end}
  use 'skywind3000/asyncrun.vim'
  use 'skywind3000/asynctasks.vim'
  use 'Shougo/echodoc.vim'
  use 'yianwillis/vimcdoc'
  use 'voldikss/vim-translator'
  use 'voldikss/vim-floaterm'
  use 'skywind3000/vim-terminal-help'
  use 'skywind3000/vim-quickui'
  use 'liuchengxu/graphviz.vim'
  use 'tweekmonster/startuptime.vim'
  if packer_bootstrap then
    packer.sync()
  end
end,
config={
  git ={
    default_url_format = 'https://hub.fastgit.org/%s',
    clone_timeout = 600 -- Prevent time out prematurely
  }
}
})
