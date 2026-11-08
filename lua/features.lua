---
-- Toggle lsp features. Affects if the lsp + tools for these languages are downloaded and enabled
---
return {
    java = {
        enabled = true,
        springboot = false,

        -- "jdtls" | "intellij"
        lsp = "intellij"
    },
    go = {
        enabled = true
    },
    cpp = {
        enabled = true
    },
    rust = {
        enabled = true
    },
    web = {
        enabled = true
    },
    python = {
        enabled = true
    },
    markdown = {
        enabled = true
    },
    devops = {
        enabled = true
    },
    database = {
        enabled = true
    },
    discord_presence = {
        enabled = true
    }
}
