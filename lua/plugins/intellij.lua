local home = os.getenv("HOME")

require("intellij-lsp").setup({
    -- skip the first-start screens (region / EULA / usage stats)
    accept_eula = true,
    region = "europe",
    data_sharing = "none",

    default_sdk = vim.fn.glob(home .. "/.sdkman/candidates/java/25.*-tem", true, true)[1],

    -- blink owns completion + signature help
    autotrigger = false,
    completeopt = false,
    enter_accepts_completion = false,
    signature_help = false,
    single_key_select = false,

    -- collides with your config
    keymaps = false,
    references = false,
    debug = false,
    colorscheme = false,
    git = false,
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("intellij-keymaps", { clear = true }),
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client or client.name ~= "intellij" then
            return
        end

        local bufnr = args.buf

        local function code_action(kinds, apply)
            return function()
                vim.lsp.buf.code_action({ context = { only = kinds }, apply = apply })
            end
        end

        vim.keymap.set("n", "<leader>jo", code_action({ "source.organizeImports" }, true),
            { desc = "Organize Imports", buffer = bufnr })

        vim.keymap.set("n", "<leader>ju", "<cmd>IntellijLspReload<cr>",
            { desc = "Update Projects", buffer = bufnr })

        -- Refactoring
        vim.keymap.set({ "n", "v" }, "<leader>je", code_action({ "refactor.extract" }),
            { desc = "Extract Menu", buffer = bufnr })

        -- Commands
        vim.keymap.set("n", "<leader>jc", "<cmd>IntellijLspCompilationErrors<cr>",
            { desc = "Compilation Errors", buffer = bufnr })

        -- Boilerplate
        local boiler = require("utils.java-boilerplate")

        vim.keymap.set("n", "<leader>jbc", function() boiler.generate_java_boilerplate("class") end,
            { desc = "New Class", buffer = bufnr })

        vim.keymap.set("n", "<leader>jbe", function() boiler.generate_java_boilerplate("enum") end,
            { desc = "New Enum", buffer = bufnr })

        vim.keymap.set("n", "<leader>jbi", function() boiler.generate_java_boilerplate("interface") end,
            { desc = "New Interface", buffer = bufnr })

        vim.keymap.set("n", "<leader>jbs", function() boiler.sync_java_identifier_name() end,
            { desc = "Sync Name to Filename", buffer = bufnr })
    end,
})
