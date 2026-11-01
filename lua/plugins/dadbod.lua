vim.g.db_ui_use_nerd_fonts = 1
vim.g.db_ui_use_nvim_notify = 1
vim.g.db_ui_disable_mappings_sql = 1
vim.g.db_ui_execute_on_save = 0
vim.g.db_ui_env_variable_url = "DATABASE_URL"

-- Statement / subquery under the cursor (DataGrip style)
local statement_ns = vim.api.nvim_create_namespace("sql_current_statement")
vim.api.nvim_set_hl(0, "SqlCurrentStatement", { link = "CursorLine", default = true })
vim.api.nvim_set_hl(0, "SqlCurrentSubquery", { link = "Visual", default = true })

local function node_at_cursor()
    local parser = vim.treesitter.get_parser(0, "sql", { error = false })
    if not parser then
        return
    end
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    return parser:parse()[1]:root():named_descendant_for_range(row - 1, col, row - 1, col)
end

local function current_statement()
    local node = node_at_cursor()
    while node and node:parent() and node:parent():type() ~= "program" do
        node = node:parent()
    end
    if node and vim.tbl_contains({ "statement", "transaction", "block" }, node:type()) then
        local start_row, _, end_row, _ = node:range()
        return start_row, end_row
    end
end

-- innermost (subquery) or CTE body
local function current_subquery()
    local node = node_at_cursor()
    while node do
        local parent = node:parent()
        if node:type() == "subquery" or (node:type() == "statement" and parent and parent:type() == "cte") then
            return node
        end
        node = parent
    end
end

vim.keymap.set("n", "<leader>od", "<cmd>DBUIToggle<cr>", { desc = "Database UI", silent = true })

-- every dadbod buffer (query, drawer, results)
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "sql", "dbui", "dbout" },
    callback = function(args)
        require("which-key").add({ { "<leader>d", group = "Database", buffer = args.buf } })
        vim.keymap.set("n", "<leader>dd", "<cmd>DBUIToggle<cr>", { desc = "Database UI", buffer = args.buf })
    end,
})

-- query buffers
vim.api.nvim_create_autocmd("FileType", {
    pattern = "sql",
    callback = function(args)
        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "TextChanged", "TextChangedI" }, {
            buffer = args.buf,
            callback = function()
                vim.api.nvim_buf_clear_namespace(args.buf, statement_ns, 0, -1)
                local start_row, end_row = current_statement()
                if start_row then
                    vim.api.nvim_buf_set_extmark(args.buf, statement_ns, start_row, 0,
                        { end_row = end_row + 1, hl_group = "SqlCurrentStatement", hl_eol = true, strict = false })
                end

                local subquery = current_subquery()
                if subquery then
                    local sr, sc, er, ec = subquery:range()
                    vim.api.nvim_buf_set_extmark(args.buf, statement_ns, sr, sc,
                        { end_row = er, end_col = ec, hl_group = "SqlCurrentSubquery", priority = 5000, strict = false })
                end
            end,
        })

        vim.keymap.set("n", "<leader>de", function()
            local start_row, end_row = current_statement()
            if not start_row then
                return vim.notify("No statement under cursor", vim.log.levels.WARN)
            end
            local view = vim.fn.winsaveview()
            vim.api.nvim_feedkeys(vim.keycode((start_row + 1) .. "GV" .. (end_row + 1) .. "G<Plug>(DBUI_ExecuteQuery)"),
                "mx", false)
            vim.fn.winrestview(view)
        end, { desc = "Execute Statement", buffer = args.buf })

        vim.keymap.set("n", "<leader>dq", function()
            local node = current_subquery()
            if not node then
                return vim.notify("No subquery under cursor", vim.log.levels.WARN)
            end
            local text = vim.treesitter.get_node_text(node, 0)
            if node:type() == "subquery" then
                text = text:match("^%((.*)%)$") or text
            end
            local file = vim.fn.tempname() .. ".sql"
            vim.fn.writefile(vim.split(text, "\n"), file)
            vim.cmd("DB < " .. file)
        end, { desc = "Execute Subquery", buffer = args.buf })

        vim.keymap.set("v", "<leader>de", "<Plug>(DBUI_ExecuteQuery)",
            { desc = "Execute Selection", buffer = args.buf, remap = true })

        vim.keymap.set("n", "<leader>dE", "<Plug>(DBUI_ExecuteQuery)",
            { desc = "Execute File", buffer = args.buf, remap = true })

        vim.keymap.set("n", "<leader>ds", "<Plug>(DBUI_SaveQuery)",
            { desc = "Save Query", buffer = args.buf, remap = true })

        vim.keymap.set("n", "<leader>db", "<Plug>(DBUI_EditBindParameters)",
            { desc = "Edit Bind Parameters", buffer = args.buf, remap = true })

        vim.keymap.set("n", "<leader>da", "<cmd>DBUIFindBuffer<cr>", { desc = "Attach Connection", buffer = args.buf })
    end,
})

-- results buffer
vim.api.nvim_create_autocmd("FileType", {
    pattern = "dbout",
    callback = function(args)
        vim.opt_local.foldlevel = 99

        vim.keymap.set("n", "<leader>do", "<Plug>(DBUI_ToggleResultLayout)",
            { desc = "Toggle Result Layout", buffer = args.buf, remap = true })
    end,
})
