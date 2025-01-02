return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('harpoon'):setup()
    end,
    keys = {
      {
        '<space>ht',
        function()
          require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())
        end,
        desc = 'Harpoon - Toggle UI'
      },
      {
        '<space>ha',
        function()
          require('harpoon'):list():add()
        end,
        desc = 'Harpoon - Add Buf'
      },
      {
        '<space>hd',
        function()
          require('harpoon'):list():remove()
        end,
        desc = 'Harpoon - Remove Buf'
      },
      {
        '<space>hn',
        function()
          require('harpoon'):list():prev()
        end,
        desc = 'Harpoon - Prev Buf'
      },
      {
        '<space>hm',
        function()
          require('harpoon'):list():next()
        end,
        desc = 'Harpoon - NExt Buf'
      }
    }
  }
}
