local options = {
  formatters = {
    tofu_fmt = {
      command = "tofu",
      args = { "fmt", "-" },
      stdin = true,
    },
  },

  formatters_by_ft = {
    lua = { "stylua" },
    typescript = { "prettier" },
    terraform = { "tofu_fmt" },
    hcl = { "tofu_fmt" },
    -- css = { "prettier" },
    -- html = { "prettier" },
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
