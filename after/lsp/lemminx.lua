local capabilities = require("utils.lsp-setup").setup_capabilities()

return {
    cmd = { "lemminx" },
    filetypes = { "xml", "xsd", "xsl", "xslt", "svg" },
    root_markers = { ".git", "pom.xml", "build.gradle", "settings.gradle" },
    capabilities = capabilities,
    single_file_support = true,
    settings = {
        xml = {
            format = {
                enabled = true,
                splitAttributes = false,
                joinCDATALines = false,
                spaceBeforeEmptyCloseTag = true,
                preserveAttributeLineBreaks = true,
            },
            completion = { autoCloseTags = true },
            validation = {
                enabled = true,
                schema = { enabled = "always" },
                noGrammar = "hint",
                resolveExternalEntities = true,
            },
            symbols = { maxItemsComputed = 5000 },
            codeLens = { enabled = true },
            references = { enabled = true },
            catalogs = {},
            fileAssociations = {
                -- bind schemas to patterns lemminx can't auto-detect,
                -- e.g.: { pattern = "**/*.myext", systemId = "path/or/url/to.xsd" },
            },
        },
    },
}
