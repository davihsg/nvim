-- Load NvChad defaults (sets global capabilities, on_init, LspAttach for on_attach)
require("nvchad.configs.lspconfig").defaults()

local python_root_markers = {
  "ty.toml",
  "pyrightconfig.json",
  "pants.toml",
  "pyproject.toml",
  ".git",
}

local function env_for_root(root_dir)
  if not root_dir or root_dir == "" then
    return nil
  end

  local matches = vim.fn.glob(root_dir .. "/dist/export/python/virtualenvs/python-default/*", false, true)
  if #matches == 0 then
    return nil
  end

  local venv = matches[1]
  local bin_path = venv .. "/bin"
  return {
    VIRTUAL_ENV = venv,
    PATH = bin_path .. ":" .. vim.env.PATH,
  }
end

vim.lsp.config("ty", {
  root_markers = python_root_markers,
  on_new_config = function(new_config, root_dir)
    new_config.cmd_env = env_for_root(root_dir)
  end,
})

local servers = {
  "terraformls",
  "ty",
  "ts_ls",
  "gopls",
}

for _, server in ipairs(servers) do
  vim.lsp.enable(server)
end
