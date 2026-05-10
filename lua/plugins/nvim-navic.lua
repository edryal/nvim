return {
  "SmiteshP/nvim-navic",
  event = "LspAttach",
  config = function()
    local features = require("settings.features")
    if not features.navic.enabled then
      -- vim.notify("Navic has been disabled. Check settings.features to manually enable it.", vim.log.levels.INFO)
      return nil
    end

    local navic = require("nvim-navic")
    navic.setup({
      icons = {
        File = " ",
        Module = " ",
        Namespace = " ",
        Package = " ",
        Class = " ",
        Method = " ",
        Property = " ",
        Field = " ",
        Constructor = " ",
        Enum = " ",
        Interface = " ",
        Function = " ",
        Variable = " ",
        Constant = " ",
        String = " ",
        Number = " ",
        Boolean = " ",
        Array = " ",
        Object = " ",
        Key = " ",
        Null = " ",
        EnumMember = " ",
        Struct = " ",
        Event = " ",
        Operator = " ",
        TypeParameter = " ",
      },
      lsp = {
        auto_attach = false,
        preference = nil,
      },
      highlight = true,
      separator = "  ",
      depth_limit = features.navic.limit,
      depth_limit_indicator = "..",
      safe_output = true,
      lazy_update_context = true,
      click = true,
      format_text = function(text)
        return text
      end,
    })
  end,
}
