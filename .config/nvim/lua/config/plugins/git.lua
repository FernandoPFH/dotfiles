return {
  {
    "lewis6991/gitsigns.nvim",
    dependencies = {
      "tpope/vim-fugitive"
    },
    config = function()
      require("gitsigns").setup {
        attach_to_untracked = true,
        current_line_blame = true,
        current_line_blame_opts = {
          delay = 100
        }
      }
    end
  }
}
