return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "folke/zen-mode.nvim",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
  -- {
  --   "milanglacier/minuet-ai.nvim",
  --   config = function()
  --     require("minuet").setup {
  --       provider = "claude",
  --       -- provider = "openai_fim_compatible",
  --       provider_options = {
  --         openai_fim_compatible = {
  --           api_key = "TERM",
  --           name = "Ollama",
  --           end_point = "http://localhost:11434/v1/completions",
  --           model = "qwen2.5-coder:14b",
  --           stream = true,
  --           optional = {
  --             max_tokens = 128,
  --             -- top_p = 0.9,
  --           },
  --         },
  --         claude = {
  --           max_tokens = 256,
  --           model = "claude-3-5-sonnet-latest",
  --           stream = false,
  --           optional = {
  --             stop_sequences = nil,
  --           },
  --         },
  --       },
  --     }
  --   end,
  -- },
  -- { "nvim-lua/plenary.nvim" },
  -- { "hrsh7th/nvim-cmp" },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
