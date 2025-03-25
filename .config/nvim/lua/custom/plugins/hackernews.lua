return {
  'martindotexe/hackernews.nvim',
  dir = '~/code/nvim/hackernews.nvim',

  config = function()
    require('hackernews').setup {
      keymap = '<leader>hn',
    }
  end,
}
