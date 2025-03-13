return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "neovim/nvim-lspconfig", -- Add nvim-lspconfig for LSP setup
    "nvim-treesitter/nvim-treesitter", -- Add treesitter for syntax highlighting
  },
  config = function()
    -- Import required modules
    local mason = require "mason"
    local mason_lspconfig = require "mason-lspconfig"
    local mason_tool_installer = require "mason-tool-installer"
    local lspconfig = require "lspconfig"
    local treesitter = require "nvim-treesitter.configs"

    -- Enable mason and configure icons
    mason.setup {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    }

    -- Configure mason-lspconfig
    mason_lspconfig.setup {
      -- List of servers for mason to install
      ensure_installed = {
        "ts_ls",
        "csharp_ls", -- Use csharp_ls for C# support
        "html", -- HTML LSP for Razor files
        "cssls",
        "tailwindcss",
        "svelte",
        "lua_ls",
        "graphql",
        "emmet_ls",
        "prismals",
        "pyright",
        ":",
      },
    }

    -- Configure mason-tool-installer
    mason_tool_installer.setup {
      ensure_installed = {
        "prettier", -- Prettier formatter
        "stylua", -- Lua formatter
        "isort", -- Python formatter
        "black", -- Python formatter
        "pylint",
        "eslint_d",
      },
    }

    -- Set filetype for Razor files
    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
      pattern = { "*.cshtml", "*.razor" },
      callback = function()
        vim.bo.filetype = "razor"
        print("Filetype set to Razor for file: " .. vim.fn.expand "%")
      end,
    })

    -- Configure LSP servers for Razor filetype
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "razor",
      callback = function()
        -- Manually configure rzls
        lspconfig.rzls.setup {
          cmd = { "rzls" }, -- Ensure rzls is in your PATH
          on_attach = function(client, bufnr)
            print("Razor LSP attached for buffer: " .. vim.fn.expand "%")
          end,
        }

        -- Attach HTML LSP (optional, if you want HTML support within Razor files)
        lspconfig.html.setup {
          on_attach = function(client, bufnr)
            print("HTML LSP attached for buffer: " .. vim.fn.expand "%")
          end,
        }

        -- Attach C# LSP (optional, if you want C# support within Razor files)
        lspconfig.csharp_ls.setup {
          on_attach = function(client, bufnr)
            print("C# LSP attached for buffer: " .. vim.fn.expand "%")
          end,
        }
      end,
    })

    -- Configure Treesitter for syntax highlighting
    treesitter.setup {
      ensure_installed = { "html", "c_sharp" }, -- Add HTML and C# parsers
      highlight = {
        enable = true,
      },
    }
  end,
}
