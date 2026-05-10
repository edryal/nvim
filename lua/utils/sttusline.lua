local M = {}

local function format_dap_status(status)
  if type(status) ~= "string" or not status:find("^Running: ") then
    return status
  end

  local base_name = status:sub(#"Running: " + 1)
  -- Trim leading/trailing whitespace
  base_name = base_name:match("^%s*(.-)%s*$")

  local short_name
  -- Try to capture non-empty content after the last colon.
  local last_colon_name = base_name:match("^.*:[ \t]*(.+)$")

  if last_colon_name then
    short_name = last_colon_name
  else
    short_name = base_name
  end

  if short_name ~= "" then
    -- Try to capture non-empty content after the last dot.
    local application_name = short_name:match("^.*%.([^.]+)$")
    if application_name then
      -- (e.g., "App" from "com.example.App")
      return application_name
    end
  end

  -- Otherwise, return the base name
  return base_name
end

local has_dap, dap = pcall(require, "dap")
if has_dap then
  M.dap = {
    name = "nvim-dap",
    event = { "CursorHold", "CursorMoved", "BufEnter" },
    update = function()
      return format_dap_status(dap.status())
    end,
    condition = function()
      local session = dap.session()
      return session ~= nil
    end,
  }
end

local has_navic, navic = pcall(require, "nvim-navic")
if has_navic then
  M.navic = {
    name = "navic",
    event = { "CursorHold" },
    update = function()
      return navic.get_location()
    end,
    condition = function()
      return navic.is_available()
    end,
  }
end

return M
