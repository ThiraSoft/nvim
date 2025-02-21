require "nvchad.mappings"
local map = vim.keymap.set

-- main
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- splits
map("n", "<leader>v", ":vsplit<CR>", { noremap = true, silent = true, desc = "Split vertical" })
map("n", "<leader>h", ":split<CR>", { noremap = true, silent = true, desc = "Split horizontal" })

-- telescope
map(
  "n",
  "gd",
  "<cmd>Telescope lsp_definitions<cr>",
  { noremap = true, silent = true, desc = "Telescope find lsp_definitions" }
)
map(
  "n",
  "<leader>gr",
  "<cmd>Telescope lsp_references<cr>",
  { noremap = true, silent = true, desc = "Telescope find lsp_references" }
)

-- navigation === === === ===
map("n", "fn", "<cmd>echo expand('%:p')<CR>")
map("n", "<leader>l", ":tabnext<CR>", { desc = "Onglet suivant" })

-- git
map("n", "<leader>gg", "<cmd>DiffviewOpen<CR>", { desc = "Ouvrir Diffview" })
map("n", "<leader>gq", "<cmd>DiffviewClose<CR>", { desc = "Fermer Diffview" })
map("n", "<leader>ge", "<cmd>DiffviewToggleFiles<CR>", { desc = "Basculer fichiers" })
map("n", "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", { desc = "Historique du fichier" })

-- block jumps === === === ===
map("n", "<leader>j", "}zz")
map("n", "<leader>k", "{zz")
map("n", "}", "}zz")
map("n", "{", "{zz")
map("n", ")", ")zz")
map("n", "(", "(zz")

--foldmode === === === ===
map(
  "n",
  "<leader>zi",
  ":set foldmethod=indent<CR>",
  { noremap = true, silent = true, desc = "Set fold method to indent" }
)
map(
  "n",
  "<leader>ze",
  ":set foldmethod=manual<CR>|zE",
  { noremap = true, silent = true, desc = "Set fold method to manual" }
)

-- lsp === === === ===
map(
  "n",
  "<leader>dn",
  "<cmd>lua vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })<CR>",
  { silent = true, desc = "Jump to next error" }
)

-- zen === === === ===
local zen = require "zen-mode"
local function toggleZen()
  zen.toggle {
    window = {
      width = 0.5, -- width will be 85% of the editor width
    },
    on_open = function()
      -- Fermer NvimTree si ouvert
      if vim.fn.exists "g:loaded_nvim_tree" == 1 then
        vim.cmd "NvimTreeClose"
      end
    end,
    on_close = function()
      -- Rouvrir NvimTree à la fermeture de ZenMode
      if vim.fn.exists "g:loaded_nvim_tree" == 1 then
        vim.cmd "NvimTreeOpen"
      end
    end,
  }
end
map("n", "<leader>zn", toggleZen, { desc = "Toogle zen mode" })
