return {
  "rest-nvim/rest.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, "http")
    end,
  },
  lazy = false,
  config = function()
    require("rest-nvim").setup()

    -- mappings personnalisés
    vim.keymap.set("n", "<leader>rr", "<cmd>Rest run<cr>", { desc = "REST : Run request" })
    vim.keymap.set("n", "<leader>rl", "<cmd>Rest run last<cr>", { desc = "REST : Run last request" })
    vim.keymap.set("n", "<leader>ro", "<cmd>Rest open<cr>", { desc = "REST : Open last result" })
  end,
}
