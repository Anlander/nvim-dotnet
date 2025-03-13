-- Load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- List of LSP servers to configure
local servers = { "html", "cssls", "tailwindcss", "csharp_ls", "ts_ls", "lua_ls" } -- or "omnisharp" instead of "csharp_ls"

local nvlsp = require "nvchad.configs.lspconfig"

-- Configure LSP servers with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.omnisharp.setup {
  cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) }, -- Ensure omnisharp is in your PATH
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  filetypes = { "cs", "razor", "cshtml" }, -- Add Razor and CSHTML file types
  root_dir = lspconfig.util.root_pattern("*.csproj", "*.sln", "*.cs"), -- Detect project root
  settings = {
    FormattingOptions = {
      OrganizeImports = true, -- Automatically organize imports
      EnableImportCompletion = true, -- Enable auto-import suggestions
      EnableEditorConfigSupport = true, -- Support for .editorconfig
    },
    MsBuild = {
      LoadProjectsOnDemand = true, -- Load projects on demand
    },
    RoslynExtensions = {
      EnableAnalyzersSupport = true, -- Enable Roslyn analyzers
      EnableDecompilationSupport = true, -- Enable decompilation support
    },
  },
}

-- Example: Configuring a single server (e.g., typescript)
lspconfig.ts_ls.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
}

-- Example: Configuring HTML server (if you need custom settings)
lspconfig.html.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  filetypes = { "html", "ts_ls" },
}

-- Example: Configuring Tailwind CSS server (if you need custom settings)
lspconfig.tailwindcss.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
}

-- -- Example: Configuring C# server (if you need custom settings)
-- lspconfig.csharp_ls.setup { -- or "omnisharp" instead of "csharp_ls"
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }
