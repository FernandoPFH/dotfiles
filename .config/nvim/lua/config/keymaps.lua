require("which-key").add({
  { "<space>E", ":Explore<CR>", desc = "Open Explorer", mode = "n", icon = { icon = "📂" } },
  { "<space>;", "gcc", desc = "Comment - Toggle", mode = "n", remap = true },
  {
    '<space>p',
    group = "Pomodoro",
    icon = { icon = "🍅" }
  },
  {
    '<space>t',
    group = "Telescope"
  },
  {
    '<space>h',
    group = "Harpoon",
    icon = { icon = "👣" }
  }
})
