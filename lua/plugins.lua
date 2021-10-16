local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://hub.fastgit.org/wbthomason/packer.nvim', install_path})
end

function nvim_treesitter_config()
  local parsers = require "nvim-treesitter.parsers".get_parser_configs()
  for _, p in pairs(parsers) do
    p.install_info.url = p.install_info.url:gsub("github.com", "hub.fastgit.org")
  end

  ensure_installed = "maintained"
  highlight = {
    enable = true,
  }
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["am"] = "@comment.outer",
        ["ii"] = "@conditional.inner",
        ["ai"] = "@conditional.outer",
        ["il"] = "@loop.inner",
        ["al"] = "@loop.outer",
      }
    },
    move = {
      enable = true,
      goto_next_start = {
        ["]f"] = "@function.outer",
      },
      goto_previous_start = {
        ["[f"] = "@function.outer",
      }
    }
  }
  -- integrate with rainbow
  require "nvim-treesitter.highlight"
  local hlmap = vim.treesitter.highlighter.hl_map
  hlmap["punctuation.delimiter"] = "Delimiter"
  hlmap["punctuation.bracket"] = nil
end

local gitsigns_config = {
  nnoremap = false,
  ['n ghs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
  ['v ghs'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
  ['n ghu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
  ['n ghr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
  ['v ghr'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
  ['n ghR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
  ['n ghp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
  ['n ghb'] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',
  ['n ghS'] = '<cmd>lua require"gitsigns".stage_buffer()<CR>',
  ['n ghU'] = '<cmd>lua require"gitsigns".reset_buffer_index()<CR>',
  -- Text objects
  ['o ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
  ['x ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>'
}

return require('packer').startup({
  function()
    if packer_bootstrap then
      require('packer').sync()
    end
    use 'camspiers/lens.vim'
    use 'kongjun18/vim-rest-reminder'
    use 'kshenoy/vim-signature'
    use 'jeffkreeftmeijer/vim-numbertoggle'
    use 'kdav5758/TrueZen.nvim'
    use {'nacro90/numb.nvim', config=function() require('numb').setup() end}
    use 'andymass/vim-matchup'
    use 'rhysd/accelerated-jk'
    use 'bronson/vim-visual-star-search'
    use 'wincent/terminus'
    use 'vim-utils/vim-man'
    use 'farmergreg/vim-lastplace'
    use 'xolox/vim-misc'
    use 'xolox/vim-session'
    use {'skywind3000/vim-auto-popmenu', ft={'text', 'markdown', 'gitcommit', 'vimwiki'}}
    use {'skywind3000/vim-dict', ft={'text', 'markdown', 'gitcommit', 'vimwiki'}}
    use 'wellle/targets.vim'
    use 'haya14busa/is.vim'
    use 'tommcdo/vim-exchange'
    use {
      'kyazdani42/nvim-tree.lua',
      requires = 'kyazdani42/nvim-web-devicons',
      config = function() require'nvim-tree'.setup {} end
    }
    use {'preservim/nerdcommenter', config=function() vim.api.nvim_call_function('CreateCommenterMappings', {}) end}
    use 'jiangmiao/auto-pairs'
    use 'tpope/vim-repeat'
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
    use 'tpope/vim-fugitive'
    use 'tpope/vim-rhubarb'
    use 'junegunn/gv.vim'
    use {'lewis6991/gitsigns.nvim',
    requires='nvim-lua/plenary.nvim',
    config=function() require('gitsigns').setup(gitsigns_config) end }
    use 'luochen1990/rainbow'
    use 'itchyny/vim-cursorword'
    use 'lfv89/vim-interestingwords'
    use 'dag/vim-fish'
    use 'nvim-treesitter/nvim-treesitter'
    use {'nvim-treesitter/nvim-treesitter-textobjects',
    requires='nvim-treesitter/nvim-treesitter',
    config=nvim_treesitter_config
  }
  use {'turbio/bracey.vim',
  ft={'css', 'html', 'javascript'},
  run = 'npm install --prefix server'}
  use {'norcalli/nvim-colorizer.lua', config=function() require 'colorizer'.setup {
    'css';
    'javascript';
    'html';
  }
end
  }
  use {'kristijanhusak/vim-dadbod-ui', requires={'kristijanhusak/vim-packager', 'tpope/vim-dadbod'}}
  use 'tpope/vim-rsi'
  use 'tpope/vim-sleuth'
  use 'cormacrelf/vim-colors-github'
  use 'editorconfig/editorconfig-vim'
  use {'Yggdroot/LeaderF', run=':LeaderfInstallCExtension'}
  use {'neoclide/coc.nvim', run='yarn install'}
  use 'dense-analysis/ale'
  use {'kkoomen/vim-doge', run=':call doge#install'}
  use 'tpope/vim-projectionist'
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
end,
config={
  git ={
    default_url_format = 'https://hub.fastgit.org/%s'
  }
}
})
