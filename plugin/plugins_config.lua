local function setup(mod, config)
  local ok, plugin = pcall(require, mod)
  if (not ok) then
    return
  end
  if config then
    plugin.setup(config)
  end
end

setup('numb')
setup('nvim-tree')
setup('colorizer', {'css','javascript','html'})
setup('gitsigns', {
  keymaps = {
    noremap = true,

    ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'"},
    ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'"},

    ['n ghs'] = '<cmd>Gitsigns stage_hunk<CR>',
    ['v ghs'] = ':Gitsigns stage_hunk<CR>',
    ['n ghu'] = '<cmd>Gitsigns undo_stage_hunk<CR>',
    ['n ghr'] = '<cmd>Gitsigns reset_hunk<CR>',
    ['v ghr'] = ':Gitsigns reset_hunk<CR>',
    ['n ghR'] = '<cmd>Gitsigns reset_buffer<CR>',
    ['n ghp'] = '<cmd>Gitsigns preview_hunk<CR>',
    ['n ghb'] = '<cmd>lua require"gitsigns".blame_line{full=true}<CR>',
    ['n ghS'] = '<cmd>Gitsigns stage_buffer<CR>',
    ['n ghU'] = '<cmd>Gitsigns reset_buffer_index<CR>',

    -- Text objects
    ['o ih'] = ':<C-U>Gitsigns select_hunk<CR>',
    ['x ih'] = ':<C-U>Gitsigns select_hunk<CR>'
  }
})


local ok, treesitter = pcall(require, 'nvim-treesitter.configs')
if (not ok) then
  return
end

-- Download packages from hub.fastgit.org
local parsers = require "nvim-treesitter.parsers".get_parser_configs()
for _, p in pairs(parsers) do
  p.install_info.url = p.install_info.url:gsub("github.com", "hub.fastgit.org")
end

treesitter.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
  },
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
}
-- integrate with rainbow
require "nvim-treesitter.highlight"
local hlmap = vim.treesitter.highlighter.hl_map
hlmap["punctuation.delimiter"] = "Delimiter"
hlmap["punctuation.bracket"] = nil
