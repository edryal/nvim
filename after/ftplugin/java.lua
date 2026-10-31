if vim.bo.filetype ~= "java" then
    return
end

local root_markers = {
    -- ".git",
    "mvnw",
    "gradlew",
    "pom.xml",
    "build.gradle",
}

local jdtls = require("jdtls")
local root_dir = vim.fs.root(0, root_markers)

local function get_jdtls_paths()
    local mason_packages = vim.fn.stdpath("data") .. "/mason/packages"
    local jdtls_install = mason_packages .. "/jdtls"

    local path = {}
    path.lombok = jdtls_install .. "/lombok.jar"
    path.launcher_jar = vim.fn.glob(jdtls_install .. "/plugins/org.eclipse.equinox.launcher_*.jar")

    local home

    if vim.fn.has("unix") == 1 then
        home = os.getenv("HOME")
        path.platform_config = jdtls_install .. "/config_linux"
    elseif vim.fn.has("win32") == 1 then
        home = os.getenv("USERPROFILE")
        path.platform_config = jdtls_install .. "/config_win"
        if home then
            home = home:gsub("\\", "/")
        end
    end

    if not home then
        vim.notify("Could not determine home directory for JDTLS workspace.", vim.log.levels.ERROR)
        return nil
    end

    path.workspace_dir = home .. "/jdtls-workspaces"
    path.bundles = {}

    ---
    -- Include java-debug-adapter bundle if present
    ---
    local java_debug_path = mason_packages .. "/java-debug-adapter"
    local java_debug_jars = vim.fn.glob(java_debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar",
        true, true)

    if java_debug_jars[1] then
        table.insert(path.bundles, java_debug_jars[1])
    end

    ---
    -- Include java-test bundle if present
    ---
    local java_test_path = mason_packages .. "/java-test/extension/server"
    local java_test_bundles = vim.fn.glob(java_test_path .. "/*.jar", true, true)
    local excluded = {
        "com.microsoft.java.test.runner-jar-with-dependencies.jar",
        "jacocoagent.jar",
    }

    for _, jar in ipairs(java_test_bundles) do
        if not vim.tbl_contains(excluded, vim.fn.fnamemodify(jar, ":t")) then
            table.insert(path.bundles, jar)
        end
    end

    ---
    -- Include springboot bundle if present, needs HelloJava's plugin
    ---
    local features = require("features")
    if features.java.springboot then
        vim.list_extend(path.bundles, require("spring_boot").java_extensions())
    end

    ---
    -- Useful if you're starting jdtls with a Java version that's
    -- different from the one the project uses.
    ---
    local jdks = {
        { name = "JavaSE-25", path = home .. "/.sdkman/candidates/java/25.*-tem", default = true },
        -- { name = "JavaSE-21", path = home .. "/.sdkman/candidates/java/21.*-tem" },
        -- { name = "JavaSE-17", path = home .. "/.sdkman/candidates/java/17.*-tem" },
        -- { name = "JavaSE-11", path = home .. "/.sdkman/candidates/java/11.*-tem" },
        -- { name = "JavaSE-1.8", path = home .. "/.sdkman/candidates/java/8.*-tem" },
    }

    path.runtimes = {}
    local added = {}

    for _, jdk in ipairs(jdks) do
        local found = vim.fn.glob(jdk.path, true, true)[1]
        if found and not added[jdk.name] then
            added[jdk.name] = true
            table.insert(path.runtimes, { name = jdk.name, path = found, default = jdk.default })
        end
    end

    return path
end

local function jdtls_on_attach(_, bufnr)
    local test_opts = {
        config_overrides = {
            console = "internalConsole",
            shortenCommandLine = "argfile",
        },
    }

    vim.keymap.set("n", "<leader>jo", function() jdtls.organize_imports() end,
        { desc = "Organize Imports", buffer = bufnr })

    vim.keymap.set("n", "<leader>ju", function() jdtls.update_projects_config() end,
        { desc = "Refresh Projects", buffer = bufnr })

    -- Refactoring
    vim.keymap.set("n", "<leader>je", function() jdtls.extract_variable_all() end,
        { desc = "Extract Variable", buffer = bufnr })

    vim.keymap.set("v", "<leader>je", "<Esc><Cmd>lua require('jdtls').extract_variable_all({ visual = true })<CR>",
        { desc = "Extract Variable", buffer = bufnr })

    vim.keymap.set("n", "<leader>jg",
        ---@diagnostic disable-next-line: assign-type-mismatch
        function() vim.lsp.buf.code_action({ context = { only = { "source.generate", "source.overrideMethods" } }, }) end,
        { desc = "Generate Menu", buffer = bufnr })

    -- Commands
    vim.keymap.set("n", "<leader>jR", "<cmd>JdtSetRuntime<cr>", { desc = "Set Java Runtime", buffer = bufnr })
    vim.keymap.set("n", "<leader>jc", "<cmd>JdtCompile full<cr>", { desc = "Compile Project", buffer = bufnr })

    -- Testing
    vim.keymap.set("n", "<leader>jtp", function() jdtls.pick_test(test_opts) end,
        { desc = "Pick Test Method", buffer = bufnr })

    vim.keymap.set("n", "<leader>jtm", function() jdtls.test_nearest_method(test_opts) end,
        { desc = "Test Method Under Cursor", buffer = bufnr })

    vim.keymap.set("n", "<leader>jtc", function() jdtls.test_class(test_opts) end,
        { desc = "Test Entire Class", buffer = bufnr })

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
end

local function jdtls_setup()
    local path = get_jdtls_paths()
    if not path then
        vim.notify("Failed to get JDTLS paths. JDTLS setup aborted.", vim.log.levels.ERROR)
        return {}
    end

    local workspace_dir = path.workspace_dir .. "/" .. vim.fn.fnamemodify(root_dir or vim.fn.getcwd(), ":p:h:t")

    -- nvim-jdtls starts jdtls via vim.lsp.start(), which skips vim.lsp.config("*"),
    -- so we can just pass the shared capabilities (blink.cmp + lsp-file-operations) explicitly
    local capabilities = vim.lsp.config["*"].capabilities

    require("jdtls.dap").setup_dap({ config_overrides = { console = "internalConsole" } })

    local cmd = {
        "java",

        -- JVM options
        "-XX:+UseParallelGC",
        "-XX:GCTimeRatio=4",
        "-XX:AdaptiveSizePolicyWeight=90",
        "-Dsun.zip.disableMemoryMapping=true",
        "-Xmx10G",
        "-Xms256m",
        "-Xlog:disable",

        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",

        -- '-Dlog.protocol=true',
        "-Dlog.level=INFO",

        "-javaagent:" .. path.lombok,
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",

        "-jar",
        path.launcher_jar,

        "-configuration",
        path.platform_config,

        "-data",
        workspace_dir,
    }

    local settings = {
        java = {
            edit = {
                validateAllOpenBuffersOnChanges = true,
            },
            diagnostic = {
                filter = {
                    "**/target",
                },
            },
            maxConcurrentBuilds = 1,
            eclipse = {
                downloadSources = true,
            },
            configuration = {
                updateBuildConfiguration = "interactive",
                runtimes = path.runtimes,
            },
            maven = {
                downloadSources = true,
            },
            implementationCodeLens = "all",
            references = {
                includeDecompiledSources = true,
            },
            referencesCodeLens = {
                enabled = true,
            },
            saveActions = {
                organizeImports = false,
            },
            inlayHints = {
                parameterNames = {
                    enabled = "all",
                },
            },
            format = {
                enabled = true,
                settings = {
                    url = vim.fn.stdpath("config") .. "/format-styles/perfect-intellij-formatting.xml",
                    -- url = root_dir .. "/logistica/eclipseCodeStyle.xml",
                },
            },
            signatureHelp = {
                enabled = false,
            },
            completion = {
                favoriteStaticMembers = {
                    "org.hamcrest.MatcherAssert.assertThat",
                    "org.hamcrest.Matchers.*",
                    "org.hamcrest.CoreMatchers.*",
                    "org.junit.jupiter.api.Assertions.*",
                    "java.util.Objects.requireNonNull",
                    "java.util.Objects.requireNonNullElse",
                    "org.mockito.Mockito.*",
                },
                filteredTypes = {
                    "com.sun.*",
                    "io.micrometer.shaded.*",
                    "java.awt.*",
                    "jdk.*",
                    "sun.*",
                },
                guessMethodArguments = true,
            },
            contentProvider = {
                preferred = "fernflower",
            },
            sources = {
                organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999,
                },
            },
            codeGeneration = {
                toString = {
                    template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
                },
                useBlocks = true,
            },
        },
    }

    jdtls.start_or_attach({
        cmd = cmd,
        settings = settings,
        on_attach = jdtls_on_attach,
        capabilities = capabilities,
        root_dir = root_dir,
        init_options = { bundles = path.bundles },
        handlers = { ["language/status"] = function() end },
    })
end

jdtls_setup()
