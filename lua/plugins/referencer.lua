return {
  "romus204/referencer.nvim",
  config = function()
    require("referencer").setup({
      enable = true,
      format = "%d reference(s)",
      show_no_reference = true,
      kinds = { 12, 6, 5, 23, 8 },
      hl_group = "Comment",
      virt_text_pos = "eol",
      pattern = { "*.java" },
      lsp_servers = { "jdtls" },
    })

    local map = vim.api.nvim_set_keymap
    map("n", "<leader>ts", ":ReferencerToggle<cr>", Expand_Opts("LSP References"))
    map("n", "<leader>cu", ":ReferencerUpdate<cr>", Expand_Opts("Update References"))

    local timer
    local last_update = 0
    local debounce_time = 2000

    -- Throttle the updates, nice to have so you don't drown jdtls in requests
    local min_update_interval = 5000

    -- Skip files over 500KB, hopefully your entire codebase isn't in a single file
    local max_filesize = 500 * 1024

    local function should_update()
      local filename = vim.api.nvim_buf_get_name(0)
      local ok, stats = pcall(vim.uv.fs_stat, filename)
      if ok and stats and stats.size > max_filesize then
        return false
      end

      local current_time = vim.uv.now()
      if current_time - last_update < min_update_interval then
        return false
      end

      return true
    end

    vim.api.nvim_create_autocmd({ "InsertLeave", "BufWritePost" }, {
      pattern = "*.java",
      callback = function()
        if not should_update() then
          return
        end

        if timer then
          timer:stop()
        end

        timer = vim.defer_fn(function()
          vim.cmd("ReferencerUpdate")
          last_update = vim.uv.now()
        end, debounce_time)
      end,
    })
  end,
}
