return {
  "koralle/winresizer.nvim",
  config = function()
    require("winresizer").setup({
      start_key = "<leader>wr",
      start_mode = "resize",
      resize_count = 3,
      keycode_left = 104, -- 'h'
      keycode_down = 106, -- 'j'
      keycode_up = 107, -- 'k'
      keycode_right = 108, -- 'l'
      keycode_finish = 13, -- 'Enter'
      keycode_cancel = 113, -- 'q'
    })
  end,
}
