return {
  {
    "zbirenbaum/copilot.lua",
    lazy = false,
    event = "InsertEnter",
    config = function()
      require("copilot").setup {
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept = "<Tab>", -- Accepter avec Tab
            accept_word = "<C-w>", -- Accepter le mot suivant
            accept_line = "<C-l>", -- Accepter toute la ligne
            next = "<C-j>", -- Suggestion suivante
            prev = "<C-k>", -- Suggestion précédente
            dismiss = "<C-e>", -- Rejeter la suggestion
          },
        },
        panel = { enabled = true },
      }
    end,
  },
}
