return {
  {
    'folke/trouble.nvim',
    opts = {
      focus = true,
      modes = {
        test = {
          mode = 'diagnostics',
          preview = {
            type = "split",
            realtive = "win",
            position = "right",
            size = 0.3,
          }
        }
      }
    },
    cmd = 'Trouble',
    keys = {
      {
        "<space>tt",
        function()
          require('trouble').toggle('test')
        end,
        desc = "Trouble - Diagnostics Toggle"
      }
    },
  }
}
