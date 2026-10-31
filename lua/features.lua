---
-- Toggle lsp features. Affects if the lsp + tools for these languages are downloaded and enabled
---
return {
    java = {
        enabled = true,
        springboot = true
    },
    go = {
        enabled = true
    },
    cpp = {
        enabled = true
    },
    -- getting rust-analyzer from Mason is not recommended
    -- run this: rustup component add rust-analyzer rust-src
    rust = {
        enabled = true
    },
    typescript = {
        enabled = true
    },
    python = {
        enabled = true
    },
    markdown = {
        enabled = true
    },
    discord_presence = {
        enabled = true
    }
}
