vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Remove neovim's default lsp gr* mappings (:h lsp-defaults-disable)
for _, lhs in ipairs({ "grn", "gra", "grr", "gri", "grt", "grx" }) do
    pcall(vim.keymap.del, "n", lhs)
end
pcall(vim.keymap.del, "x", "gra")

-- easier wrapped text navigation
vim.keymap.set("n", "j", function() return vim.v.count == 0 and "gj" or "j" end,
    { desc = "Down (in wrapped text)", expr = true, silent = true })

vim.keymap.set("n", "k", function() return vim.v.count == 0 and "gk" or "k" end,
    { desc = "Up (in wrapped text)", expr = true, silent = true })

vim.keymap.set("v", "<", "<gv", { desc = "Unindent and keep selection", silent = true })
vim.keymap.set("v", ">", ">gv", { desc = "Indent and keep selection", silent = true })
vim.keymap.set("n", "<Esc>", "<cmd>nohl<cr>", { desc = "Clear highlights", silent = true })

vim.keymap.set("n", "<leader>we", "<cmd>restart<cr>", { desc = "Neovim Config (:restart)", silent = true })
vim.keymap.set("n", "<leader>wv", "<cmd>vsplit<cr>", { desc = "Split Vertical", silent = true })
vim.keymap.set("n", "<leader>wh", "<cmd>split<cr>", { desc = "Split Horizontal", silent = true })
vim.keymap.set("n", "<leader>tr", "<cmd>set rnu!<cr>", { desc = "Relative Line Numbers", silent = true })

-- Don't record macro on Alt + q
vim.keymap.set("n", "<A-q>", "", { silent = true })

vim.keymap.set("n", "<leader>ou", function()
    vim.cmd.packadd("nvim.undotree")
    require("undotree").open()
end, { desc = "Builtin Undotree", silent = true })

vim.keymap.set("n", "L", "<cmd>lua vim.lsp.buf.signature_help()<cr>", { desc = "Show Signature Help", silent = true })
vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", { desc = "Show Hover information", silent = true })
vim.keymap.set("n", "gR", "<cmd>lua vim.lsp.buf.rename()<cr>", { desc = "Rename all references", silent = true })
vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", { desc = "Floating Diagnostics", silent = true })
vim.keymap.set("n", "<leader>cl", function() vim.lsp.codelens.run() end, { desc = "Run Codelens", silent = true })

vim.keymap.set({ "n", "v" }, "<leader>ca", function()
    vim.lsp.buf.code_action({ filter = function(action) return not action.disabled end })
end, { desc = "Code Action", silent = true })

vim.keymap.set({ "n", "v" }, "<leader>cf", function()
    vim.lsp.buf.format({
        async = true,
        filter = function(client)
            local has_biome = #vim.lsp.get_clients({ bufnr = 0, name = "biome" }) > 0
            return not has_biome or client.name == "biome"
        end,
    })
end, { desc = "Code Format", silent = true })

vim.keymap.set("n", "gn", function() vim.diagnostic.jump({ count = 1 }) end, { desc = "Next Diagnostic", silent = true })
vim.keymap.set("n", "gp", function() vim.diagnostic.jump({ count = -1 }) end, { desc = "Prev Diagnostic", silent = true })

vim.keymap.set("n", "<leader>ts", function()
    local on = not vim.wo.spell
    vim.wo.spell = on
    vim.notify("Spellcheck: " .. (on and "ON" or "OFF"))
end, { desc = "Spellcheck", silent = true })
