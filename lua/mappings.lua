require "nvchad.mappings"
local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })

-- file name
map("n", "fn", "<cmd>echo expand('%:p')<CR>")

-- block jumps
map("n", "<leader>j", "}zz")
map("n", "<leader>k", "{zz")
map("n", "}", "}zz")
map("n", "{", "{zz")
map("n", ")", ")zz")
map("n", "(", "(zz")

--foldmode
map(
  "n",
  "<leader>zi",
  ":set foldmethod=indent<CR>",
  { noremap = true, silent = true, desc = "Set flod method to indent" }
)
map(
  "n",
  "<leader>ze",
  ":set foldmethod=manual<CR>|zE",
  { noremap = true, silent = true, desc = "Set flod method to manual" }
)

-- lsp jumps
map(
  "n",
  "<leader>dn",
  "<cmd>lua vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })<CR>",
  { silent = true, desc = "Jump to next error" }
)

-- telescope
local builtin = require "telescope.builtin"
map("n", "<leader>gr", builtin.lsp_references, { desc = "Telescope find lsp_references" })

-- zen
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
