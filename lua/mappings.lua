require "nvchad.mappings"
local vim = vim
local map = vim.keymap.set

-- main
map("i", "jk", "<ESC>", { desc = "ESC" })

-- splits
map("n", "<leader>v", ":vsplit<CR>", { noremap = true, silent = true, desc = "Split vertical" })
-- map("n", "<leader>h", ":split<CR>", { noremap = true, silent = true, desc = "Split horizontal" })

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
map("n", "<leader>l", ":tabnext<CR>", { desc = "Onglet suivant" })

-- git
map("n", "<leader>gg", "<cmd>DiffviewOpen<CR>", { desc = "Ouvrir Diffview" })
map("n", "<leader>gq", "<cmd>DiffviewClose<CR>", { desc = "Fermer Diffview" })
map("n", "<leader>ge", "<cmd>DiffviewToggleFiles<CR>", { desc = "Basculer fichiers" })
map("n", "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", { desc = "Historique du fichier" })

-- Historique des sauts
map("n", "<C-i>", "<C-i>", { noremap = true, desc = "Aller au jump suivant" }) -- obligé de faire ça pour éviter le conflit avec tab
map("n", "<C-p>", "<C-i>", { noremap = true, desc = "Aller au jump suivant" }) -- obligé de faire ça pour éviter le conflit avec tab

-- folds === === === ===
map(
  "n",
  "<leader>zi",
  ":set foldmethod=indent<CR>",
  { noremap = true, silent = true, desc = "Set fold method to indent" }
)

-- lsp === === === ===
map(
  "n",
  "<leader>dn",
  "<cmd>lua vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARNING })<CR>",
  { silent = true, desc = "Jump to next error" }
)
map("n", "<leader>ra", "<cmd>lua vim.lsp.buf.rename()<CR>", { desc = "LSP Rename" })

-- nvim-tree === === === ===
map("n", "+", function()
  require("nvim-tree.api").tree.change_root_to_node()
end, { desc = "Change root to node" })

-- hop === === === ===
local hop = require "hop"
map("n", "<leader>fj", "m`<cmd>HopWord<CR>", { desc = "Find Jump" })

-- Focus sur la fenêtre de code avec Ctrl+Entrée
local function focus_code_window()
  -- Fonction pour vérifier si la fenêtre actuelle est une fenêtre de plugin
  local function is_plugin_window()
    local current_ft = vim.bo.filetype
    local current_bufname = vim.fn.bufname()

    -- Liste exhaustive des types de fenêtres non-code
    local non_code_windows = {
      "NvimTree",
      "neo%-tree",
      "Outline",
      "avante",
      "Trouble",
      "qf",
      "help",
      "terminal",
      "chat",
      "prompt",
      "input",
    }

    -- Vérification des types de fenêtres
    for _, window_type in ipairs(non_code_windows) do
      if
        current_ft:match(window_type)
        or current_bufname:match(window_type)
        or current_bufname:lower():find(window_type)
      then
        return true
      end
    end

    -- Vérifications spécifiques
    if
      current_bufname:find "Avante"
      or current_ft == "avante_chat"
      or current_bufname:lower():find "prompt"
      or current_bufname:lower():find "input"
    then
      return true
    end

    -- Vérification du type de fenêtre
    local win_type = vim.fn.win_gettype()
    if win_type ~= "" and win_type ~= "normal" then
      return true
    end

    return false
  end

  -- Sortir du mode terminal si nécessaire
  if vim.fn.mode() == "t" then
    vim.cmd "stopinsert"
  end

  -- Parcourt toutes les fenêtres pour trouver une fenêtre de code
  local total_windows = vim.fn.winnr "$"

  for winnr = 1, total_windows do
    vim.cmd(winnr .. "wincmd w")
    if not is_plugin_window() then
      return -- On a trouvé une fenêtre de code, on s'arrête
    end
  end

  -- Si on n'a pas trouvé de fenêtre de code, on va à droite
  vim.cmd "wincmd l"
end

map(
  { "n", "v", "t" },
  "<C-CR>",
  focus_code_window,
  { noremap = true, silent = true, desc = "Focus sur la fenêtre de code" }
)

-- clipboard === === === ===
local function copy_file_path()
  local path = vim.fn.expand "%:p" -- Chemin complet
  vim.fn.setreg("+", path) -- Copie dans le presse-papiers
  print("Chemin copié : " .. path)
end
map("n", "<leader>yp", copy_file_path, { desc = "Copier le chemin complet du fichier" })

-- go === === === ===
map("n", "<leader>go", "<cmd>w ! go run .<CR>", { desc = "Go run ." })

-- terminal === === === ===
-- Ouvrir un terminal flottant
map("n", "<leader>tm", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "Terminal flottant" })
-- Echap ferme le terminal sans le tuer
vim.keymap.set("t", "<Esc>", function()
  local keys = vim.api.nvim_replace_termcodes("<C-\\><C-n>:hide<CR>", true, false, true)
  vim.api.nvim_feedkeys(keys, "n", false)
end, { desc = "Cache le terminal sans le tuer" })

-- Diffs
vim.api.nvim_create_user_command("DiffToggle", function()
  if vim.opt.diff:get() then
    vim.cmd "diffoff"
  else
    vim.cmd "diffthis"
  end
end, {
  desc = "Toggle diff mode for current window",
  -- Tu peux ajouter des options ici si tu veux, comme { nargs = 0 }
})
vim.keymap.set("n", "<leader>df", ":DiffToggle<CR>", { desc = "Toggle diff mode" })

-- ANGULAR === === === ===
vim.api.nvim_create_user_command("OrganizeImports", function()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
    title = "",
  }
  vim.lsp.buf.execute_command(params)
end, { desc = "Nettoyer et organiser les imports TypeScript/Angular" })
map("n", "<leader>oi", ":OrganizeImports<CR>", { desc = "Organize Imports" })
