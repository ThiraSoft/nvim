-- Place un fond jaune si on est dans les node_modules
local normal_hl = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
Base_bg_color = normal_hl and normal_hl.bg or nil

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    local filepath = vim.fn.expand "%:p" -- Récupère le chemin complet du fichier
    if filepath:match "node_modules" then
      vim.cmd "hi Normal guibg=#202000" -- Fond jaune
      vim.bo.modifiable = false -- Rend le buffer non modifiable
      vim.bo.readonly = true -- Rend le fichier en lecture seule
    else
      vim.api.nvim_set_hl(0, "Normal", { bg = Base_bg_color })
      vim.bo.modifiable = true -- Réactive la modification pour les autres fichiers
      vim.bo.readonly = false
    end
  end,
})

-- Crée un groupe d'autocommandes pour une gestion propre
local group = vim.api.nvim_create_augroup("AutoSaveOnFocusLost", { clear = true })

-- Ajoute une autocommande qui s'exécute lors de la perte de focus
-- vim.api.nvim_create_autocmd("FocusLost", {
--   group = group,
--   pattern = "*",
--   command = "silent! wa",
-- })
-- Ajoute une autocommande qui s'exécute lors de la perte de focus
-- vim.api.nvim_create_autocmd("BufLeave", {
--   group = group,
--   pattern = "*",
--   command = "silent! w",
-- })

-- Auto save (uniquement si hors node_modules)
vim.api.nvim_create_autocmd("BufLeave", {
  group = group,
  pattern = "*",
  callback = function()
    local bufname = vim.api.nvim_buf_get_name(0)
    if not string.match(bufname, "node_modules") then
      vim.cmd "silent! w"
    end
  end,
})

-- Hook d'ouverture de neovim
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Efface la jumplist à chaque ouverture de session
    vim.cmd "clearjumps"
  end,
})

-- Numeros de lignes dans nvimtree
vim.api.nvim_create_autocmd("FileType", {
  pattern = "NvimTree",
  callback = function()
    vim.defer_fn(function()
      vim.wo.relativenumber = true -- Active les numéros relatifs
    end, 100) -- Attend 100ms pour s'assurer que la fenêtre est prête
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Un petit délai pour laisser NvChad finir de charger tous ses highlights
    vim.defer_fn(function()
      local colors = {
        diff_add = "#50FA7B",
        diff_change = "#F1FA8C",
        diff_delete = "#FF5555",
        diff_text = "#BD93F9",
        diff_blend = 0, -- Assure que le fond est plein
      }
      vim.api.nvim_set_hl(0, "DiffAdd", { fg = "NONE", bg = colors.diff_add, ctermbg = 155, blend = colors.diff_blend })
      vim.api.nvim_set_hl(
        0,
        "DiffChange",
        { fg = "NONE", bg = colors.diff_change, ctermbg = 227, blend = colors.diff_blend }
      )
      vim.api.nvim_set_hl(
        0,
        "DiffDelete",
        { fg = "NONE", bg = colors.diff_delete, ctermbg = 196, blend = colors.diff_blend }
      )
      vim.api.nvim_set_hl(
        0,
        "DiffText",
        { fg = "NONE", bg = colors.diff_text, ctermbg = 165, blend = colors.diff_blend }
      )
    end, 100) -- Délai de 100ms
  end,
})
