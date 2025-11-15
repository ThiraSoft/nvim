return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup {
      ensure_installed = { "gopls", "angularls", "ts_ls", "pyright" },
    }

    -- GOPLS
    vim.lsp.config.gopls = {
      cmd = { "gopls" },
      root_dir = vim.fs.root(0, { "go.mod", ".git" }),
      settings = {
        gopls = {
          analyses = {
            unusedparams = true,
            shadow = true,
          },
          staticcheck = true,
          gofumpt = true,
          completeUnimported = true,
          usePlaceholders = true,
          hints = {
            -- assignVariableTypes = true,
            -- compositeLiteralFields = true,
            -- compositeLiteralTypes = true,
            -- constantValues = true,
            -- functionTypeParameters = true,
            parameterNames = true,
            -- rangeVariableTypes = true,
          },
        },
      },
    }

    -- Pyright
    vim.lsp.config.pyright = {
      cmd = { "pyright-langserver", "--stdio" },
      root_dir = vim.fs.root(0, { "pyproject.toml", "setup.py", "requirements.txt" }),
      settings = {
        python = {
          analysis = {
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            diagnosticMode = "workspace",
          },
        },
      },
    }

    -- TypeScript LS
    vim.lsp.config.ts_ls = {
      root_dir = vim.fs.root(0, { "package.json", "tsconfig.json" }),
      single_file_support = false,
    }

    -- Angular LS
    vim.lsp.config.angularls = {
      cmd = { "ngserver", "--stdio" },
      root_dir = vim.fs.root(0, { "angular.json" }),
      filetypes = { "typescript", "html", "typescriptreact" },
    }
  end,
}
