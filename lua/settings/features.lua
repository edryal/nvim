local features = {
  inlay_hint = false,
  navic = {
    enabled = false,
    limit = 5,
  },
  web = {
    enabled = false,
  },
  go = {
    enabled = false,
    debugger = false,
  },
  java = {
    enabled = true,
    codelens = true,
    debugger = true,
    springboot = false,
    web = true,
  },
}

return features
