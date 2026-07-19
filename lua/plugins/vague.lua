require('vague').setup({
    transparent = true,
    on_highlights = function(hl, colors)
        hl.Pmenu = { fg = colors.fg, bg = colors.line }
        hl.PmenuSel = { fg = colors.bg, bg = colors.func, bold = true }
        hl.PmenuThumb = { bg = colors.comment }
        hl.Number = { fg = colors.builtin }
    end,
})
