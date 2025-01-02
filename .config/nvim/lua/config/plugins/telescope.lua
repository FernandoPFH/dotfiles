return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    {
      "xiyaowong/telescope-emoji.nvim",
      dependencies = {
        { 'echasnovski/mini.nvim', version = '*' },
        'nvim-tree/nvim-web-devicons'
      },
    }
  },
  config = function()
    require('telescope').load_extension('fzf')
    require('telescope').load_extension('emoji')
  end,
  keys = {
    {
      "<space>f",
      function()
        require("telescope.builtin").find_files()
      end,
      desc = "Telescope - Find Files",
    },
    {
      "<space>te",
      ":Telescope emoji<CR>",
      desc = "Telescope - emoji"
    }
  }
}
