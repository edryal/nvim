vim.api.nvim_create_autocmd("FileType", {
    desc = "Close specific windows with q",
    pattern = {
        "qf",
        "help",
        "man",
        "toggleterm",
        "fugitive",
        "nvim-undotree",
    },
    callback = function(args)
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = args.buf, silent = true, desc = "Close Window" })
        vim.bo[args.buf].buflisted = false
    end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    callback = function()
        vim.hl.on_yank()
    end,
})

local disable_useless_diagnostics = vim.api.nvim_create_augroup("DisableUselessDiagnostics", { clear = true })
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    desc = "Disable diagnostics for files inside node_modules/target",
    pattern = { "*/node_modules/*", "*/target/*" },
    callback = function(args)
        vim.diagnostic.enable(false, { bufnr = args.buf })
    end,
    group = disable_useless_diagnostics,
})

vim.api.nvim_create_autocmd("PackChanged", {
    desc = "Update treesitter parsers after nvim-treesitter is installed or updated",
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
            if not ev.data.active then
                vim.cmd.packadd("nvim-treesitter")
            end
            vim.cmd("TSUpdate")
        end
    end,
})
