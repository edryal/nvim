--[[
  Generate Java boilerplate for classes, enums, and interfaces.
  It preserves the 'package' line, clears everything else, and inserts the
  correct boilerplate based on the filename.
]]
local function generate_java_boilerplate(type)
  local name = vim.fn.expand('%:t:r')
  if name == '' then
    vim.notify("Buffer has no filename, defaulting to 'FILENAME'", vim.log.levels.WARN)
    name = "FILENAME"
  end

  -- Find and preserve the package line
  local package_line = ""
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  for _, line in ipairs(lines) do
    if string.match(line, "^%s*package%s+[%w_%.]+%s*;") then
      package_line = line
      break
    end
  end

  -- Boilerplate templates
  local templates = {
    class = {
      "public class " .. name .. " {",
      "    ",
      "}"
    },
    enum = {
      "public enum " .. name .. " {",
      "    ",
      "}"
    },
    interface = {
      "public interface " .. name .. " {",
      "    ",
      "}"
    }
  }

  local boilerplate = templates[type]
  if not boilerplate then
    vim.notify("Unknown structure type '" .. type .. "'", vim.log.levels.WARN)
    return
  end

  -- Construct the new file content
  local new_content = {}
  if package_line ~= "" then
    table.insert(new_content, package_line)
    table.insert(new_content, "")
  end

  -- Add all lines from the chosen boilerplate
  for _, line in ipairs(boilerplate) do
    table.insert(new_content, line)
  end

  -- Clear buffer and insert the new content
  vim.api.nvim_buf_set_lines(0, 0, -1, false, new_content)

  -- Place cursor on the empty line inside the braces
  vim.api.nvim_win_set_cursor(0, { #new_content - 1, 4 })
end

--[[
  Sync Java Identifier Name
  Finds the public class, enum, or interface and updates its name
  to match the current filename.
]]
local function sync_java_identifier_name()
  -- Get name from the filename
  local expected_name = vim.fn.expand('%:t:r')
  if expected_name == '' then
    vim.notify("Cannot sync since the buffer has no name", vim.log.levels.WARN)
    return
  end

  local search_pattern = [[\v(class|enum|interface)\s+\w+]]
  local line_number = vim.fn.search(search_pattern, 'nw')

  if line_number == 0 then
    vim.notify("No class, enum, or interface definition found", vim.log.levels.INFO)
    return
  end

  -- Get the current name
  local line_content = vim.fn.getline(line_number)
  local current_name = string.match(line_content, "class%s+([%w_]+)")
    or string.match(line_content, "enum%s+([%w_]+)")
    or string.match(line_content, "interface%s+([%w_]+)")

  -- If a name was found and it's different from the filename, replace it
  if current_name and current_name ~= expected_name then
    local new_line = string.gsub(line_content, current_name, expected_name, 1)
    vim.api.nvim_buf_set_lines(0, line_number - 1, line_number, false, { new_line })
    vim.notify("Updated name from '" .. current_name .. "' to '" .. expected_name .. "'.", vim.log.levels.INFO)
  elseif current_name then
    vim.notify("Name '" .. current_name .. "' is already in sync with the filename.", vim.log.levels.INFO)
  else
    vim.notify("Could not extract the current name.", vim.log.levels.WARN)
  end
end

vim.keymap.set('n', '<leader>jgc', function() generate_java_boilerplate('class') end, { desc = "Generate Class" })
vim.keymap.set('n', '<leader>jge', function() generate_java_boilerplate('enum') end, { desc = "Generate Enum" } )
vim.keymap.set('n', '<leader>jgi', function() generate_java_boilerplate('interface') end, { desc = "Generate Interface" })
vim.keymap.set('n', '<leader>jgn', sync_java_identifier_name, { desc = "Sync Name to Filename" })

return {
  -- {
  --   "JavaHello/spring-boot.nvim",
  --   ft = { "java", "yaml", "jproperties" },
  --   dependencies = {
  --     "mfussenegger/nvim-jdtls",
  --   },
  --   opts = {},
  -- },
  -- {
  --   "elmcgill/springboot-nvim",
  --   ft = "java",
  --   dependencies = {
  --     "neovim/nvim-lspconfig",
  --     "mfussenegger/nvim-jdtls",
  --   },
  --   config = function()
  --     local springboot_nvim = require("springboot-nvim")
  --     vim.keymap.set("n", "<leader>js", springboot_nvim.boot_run, { desc = "Run Project" })
  --
  --     vim.keymap.set('n', '<leader>jgc', function() generate_java_boilerplate('class') end, { desc = "Generate Class" })
  --     vim.keymap.set('n', '<leader>jge', function() generate_java_boilerplate('enum') end, { desc = "Generate Enum" } )
  --     vim.keymap.set('n', '<leader>jgi', function() generate_java_boilerplate('interface') end, { desc = "Generate Interface" })
  --     vim.keymap.set('n', '<leader>jgn', sync_java_identifier_name, { desc = "Sync Name to Filename" })
  --
  --     springboot_nvim.setup({})
  --   end,
  -- },
}
