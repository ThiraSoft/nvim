return {
  "yetone/avante.nvim",
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  -- ⚠️ must add this setting! ! !
  build = vim.fn.has "win32" ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
    or "make",
  event = "VeryLazy",
  version = false, -- Never set this value to "*"! Never!
  ---@module 'avante'
  ---@type avante.Config
  opts = {
    -- add any opts here
    -- for example
    provider = "claude",
    providers = {
      claude = {
        endpoint = "https://api.anthropic.com",
        model = "claude-sonnet-4-20250514",
        timeout = 30000, -- Timeout in milliseconds
        extra_request_body = {
          temperature = 0.75,
          max_tokens = 20480,
        },
      },
      moonshot = {
        endpoint = "https://api.moonshot.ai/v1",
        model = "kimi-k2-0711-preview",
        timeout = 30000, -- Timeout in milliseconds
        extra_request_body = {
          temperature = 0.75,
          max_tokens = 32768,
        },
      },
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "echasnovski/mini.pick", -- for file_selector provider mini.pick
    "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    "ibhagwan/fzf-lua", -- for file_selector provider fzf
    "stevearc/dressing.nvim", -- for input provider dressing
    "folke/snacks.nvim", -- for input provider snacks
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua", -- for providers='copilot'
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
-- return {
--   "yetone/avante.nvim",
--   event = "BufRead",
--   version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
--   opts = {
--     -- add any opts here
--     -- for example
--     -- provider = "openai",
--     -- openai = {
--     --   endpoint = "https://api.openai.com/v1",
--     --   model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
--     --   timeout = 30000, -- timeout in milliseconds
--     --   temperature = 0, -- adjust if needed
--     --   max_tokens = 4096,
--     --   -- reasoning_effort = "high" -- only supported for reasoning models (o1, etc.)
--     -- },
--     provider = "openai",
--     -- provider = "claude",
--     copilot = {
--       model = "claude-3-5-haiku-20241022",
--     },
--     -- claude = {
--     --   endpoint = "https://api.anthropic.com",
--     --   model = "claude-3-5-haiku-20241022",
--     --   -- model = "claude-3-7-sonnet-20250219",
--     --   timeout = 30000, -- Timeout in milliseconds
--     --   temperature = 0,
--     --   max_tokens = 8000,
--     --   disable_tools = true,
--     -- },
--     openai = {
--       endpoint = "https://api.openai.com/v1",
--       model = "gpt-4.1",
--       timeout = 30000, -- Timeout in milliseconds
--       temperature = 0,
--       -- max_tokens = 8000,
--       disable_tools = true,
--     },
--
--     mappings = {
--       diff = {
--         ours = "<leader>co",
--         theirs = "<leader>ct",
--         all_theirs = "<leader>cT",
--         both = "<leader>cb",
--         cursor = "<leader>cc",
--         next = "]x",
--         prev = "[x",
--       },
--       suggestion = {
--         accept = "<Tab>",
--         next = "<Down>",
--         prev = "<Up>",
--         dismiss = "<C-]>",
--       },
--     },
--   },
--   -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
--   build = "make",
--   -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
--   dependencies = {
--     "nvim-treesitter/nvim-treesitter",
--     "stevearc/dressing.nvim",
--     "nvim-lua/plenary.nvim",
--     "MunifTanjim/nui.nvim",
--     --- The below dependencies are optional,
--     "echasnovski/mini.pick", -- for file_selector provider mini.pick
--     "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
--     "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
--     "ibhagwan/fzf-lua", -- for file_selector provider fzf
--     "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
--     -- "zbirenbaum/copilot.lua", -- for providers='copilot'
--     {
--       -- support for image pasting
--       "HakonHarnes/img-clip.nvim",
--       event = "VeryLazy",
--       opts = {
--         -- recommended settings
--         default = {
--           embed_image_as_base64 = false,
--           prompt_for_file_name = false,
--           drag_and_drop = {
--             insert_mode = true,
--           },
--           -- required for Windows users
--           use_absolute_path = true,
--         },
--       },
--     },
--     {
--       -- Make sure to set this up properly if you have lazy=true
--       "MeanderingProgrammer/render-markdown.nvim",
--       opts = {
--         file_types = { "markdown", "Avante" },
--       },
--       ft = { "markdown", "Avante" },
--     },
--   },
-- }
