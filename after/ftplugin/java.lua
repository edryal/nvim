if vim.bo.filetype ~= "java" and vim.bo.filetype ~= "jsp" then
  return
end

local root_markers = {
  -- ".git",
  -- ".jdtls-root",
  -- "mvnw",
  -- "gradlew",

  "logistica.iml",
  "logistica.eml",

  -- 'pom.xml',
  -- 'build.gradle',
}

local jdtls = require("jdtls")

-- local root_dir = vim.fs.root(0, root_markers)
local root_dir = "/home/catalin/Projects/c-tower"
-- local root_dir = "/home/catalin/Projects/java_ee_serv"

local cache_vars = {}
local java_cmds = vim.api.nvim_create_augroup("java_cmds", { clear = true })

local function get_jdtls_paths()
  if cache_vars.paths then
    return cache_vars.paths
  end

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
  local java_debug_jar = vim.fn.glob(java_debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar", true)

  if java_debug_jar ~= "" then
    table.insert(path.bundles, java_debug_jar)
  end

  ---
  -- Include java-test bundle if present
  ---
  local java_test_path = mason_packages .. "/java-test"
  local java_test_bundle = vim.split(vim.fn.glob(java_test_path .. "/extension/server/*.jar"), "\n")

  -- Useful when building test bundles manually
  -- local java_test_bundle = vim.split(vim.fn.glob(home .. "/vscode-java-test-0.43.1/server/*.jar"), "\n")

  if java_test_bundle[1] ~= "" then
    vim.list_extend(path.bundles, java_test_bundle)
  end

  ---
  -- Include springboot bundle if present
  ---

  local features = require("settings.features")
  if features.java.springboot then
    vim.list_extend(path.bundles, require("spring_boot").java_extensions())
  end

  ---
  -- Useful if you're starting jdtls with a Java version that's
  -- different from the one the project uses.
  ---

  path.runtimes = {
    -- {
    --   name = "JavaSE-21",
    --   path = home .. "/.sdkman/candidates/java/21.0.8-tem",
    -- },
    -- {
    --   name = "JavaSE-17",
    --   path = home .. "/.sdkman/candidates/java/17.0.16-tem",
    -- },
    -- {
    --   name = "JavaSE-1.8",
    --   path = home .. "/.sdkman/candidates/java/8.0.462-tem",
    --   default = true,
    -- },
    {
      name = "JavaSE-1.8",
      path = home .. "/Documents/jdk1.8.0_202",
      default = true,
    },
  }

  cache_vars.paths = path

  return path
end

local function enable_codelens(bufnr)
  pcall(vim.lsp.codelens.refresh)
  vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
    buffer = bufnr,
    group = java_cmds,
    desc = "Refresh Codelens",
    callback = function()
      pcall(vim.lsp.codelens.refresh)
    end,
  })
end

local function enable_debugger(bufnr)
  jdtls.setup_dap()
  require("jdtls.dap").setup_dap_main_class_configs()
end

local function jdtls_on_attach(client, bufnr)
  local features = require("settings.features")

  if features.codelens then
    enable_codelens(bufnr)
  end

  if features.java.debugger then
    enable_debugger(bufnr)
  end

  if features.navic.enabled then
    require("utils.lsp").attach_navic(client, bufnr)
  end

  local test_opts = {
    config = {
      console = "internalConsole",
    },
    junit = {
      useJUnitPlatform = true,
    },
    -- config_overrides = {
    --   shortenCommandLine = "argfile",
    -- },
  }

  local set = vim.keymap.set
  set("n", "<leader>jo", "<cmd>lua require'jdtls'.organize_imports()<cr>", Expand_Opts("Organize Imports"))
  set("n", "<leader>ju", "<cmd>lua require'jdtls'.update_project_config()<cr>", Expand_Opts("Refresh Project"))

  -- Refactoring
  set("n", "<leader>jev", "<cmd>lua require('jdtls').extract_variable()<cr>", Expand_Opts("Variable"))
  set("n", "<leader>jec", "<cmd>lua require('jdtls').extract_constant()<cr>", Expand_Opts("Constant"))
  set("v", "<leader>jev", "<esc><cmd>lua require('jdtls').extract_variable(true)<cr>", Expand_Opts("Variable"))
  set("v", "<leader>jem", "<esc><cmd>lua require('jdtls').extract_method(true)<cr>", Expand_Opts("Method"))

  -- Commands
  set("n", "<leader>jr", "<cmd>JdtSetRuntime<cr>", Expand_Opts("Set Java Runtime"))
  set("n", "<leader>jc", "<cmd>JdtCompile full<cr>", Expand_Opts("Compile Project"))

  -- Testing
  set("n", "<leader>jtp", function()
    jdtls.pick_test(test_opts)
  end, Expand_Opts("Pick Method"))
  set("n", "<leader>jtm", function()
    jdtls.test_nearest_method(test_opts)
  end, Expand_Opts("Method Under Cursor"))
  set("n", "<leader>jtc", function()
    jdtls.test_class(test_opts)
  end, Expand_Opts("Entire Class"))
end

local function jdtls_setup()
  local path = get_jdtls_paths()
  if not path then
    vim.notify("Failed to get JDTLS paths. JDTLS setup aborted.", vim.log.levels.ERROR)
    return {}
  end

  -- local workspace_dir = path.workspace_dir .. "/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
  local workspace_dir = path.workspace_dir .. "/c-tower"
  -- "/home/catalin/Projects/c-tower"

  -- LSP capabilities to override
  local capabilities = {
    workspace = {
      configuration = true,
      fileOperations = {
        dynamicRegistration = true,
        didCreate = true,
        willCreate = true,
        didRename = true,
        willRename = true,
        didDelete = true,
        willDelete = true,
      },
    },
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = false,
        },
      },
    },
  }
  capabilities = require("utils.lsp").setup_capabilities(capabilities)

  -- JDTLS capabilities
  jdtls.extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

  local cmd = {
    "java",

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
      jdt = {
        ls = {
          -- You can define the java home especially for the JDTLS server here. In this way it doesn't matter what is your JAVA_HOME environmental variable anymore.
          -- Convenient to solve version mismatches for some old projects
          -- java = { home = path.runtimes[1].path },
          vmargs = "-XX:+UseParallelGC -XX:GCTimeRatio=4 -XX:AdaptiveSizePolicyWeight=90 -Dsun.zip.disableMemoryMapping=true -Xmx10G -Xms256m",
        },
      },
      server = {
        launchMode = "Hybrid",
      },
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
      implementationsCodeLens = {
        enabled = true,
      },
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
          -- profile = vim.fn.stdpath("config") .. "/format-styles/eclipse-java-format.xml",
          profile = root_dir .. "/logistica/eclipseCodeStyle.xml",
        },
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
    extendedClientCapabilities = jdtls.extendedClientCapabilities,
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
  }

  jdtls.start_or_attach({
    cmd = cmd,
    settings = settings,
    on_attach = jdtls_on_attach,
    capabilities = capabilities,
    root_dir = root_dir,
    flags = {
      allow_incremental_sync = true,
    },
    init_options = {
      bundles = path.bundles,
    },
  })
end

jdtls_setup()
