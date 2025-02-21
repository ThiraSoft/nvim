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

-- Ouverture de nvimtree:
-- On veut le focus auto sur le fichier
-- On les numero de lignes relatifs pour faciliter les sauts de lignes
local function open_nvim_tree_and_refocus()
  require("nvim-tree.api").tree.open()

  if vim.fn.argc() ~= 0 then
    -- Vérifie si un buffer normal existe et reprend le focus dessus
    local buffers = vim.api.nvim_list_bufs()
    for _, buf in ipairs(buffers) do
      vim.opt.number = true
      vim.opt.relativenumber = true
      if vim.bo[buf].buftype == "" then
        vim.api.nvim_set_current_buf(buf)
        return
      end
    end
  end
end

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 0 then
      vim.schedule(open_nvim_tree_and_refocus)
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "NvimTree",
  callback = function()
    vim.defer_fn(function()
      vim.wo.relativenumber = true -- Active les numéros relatifs
      -- vim.wo.number = true -- Active les numéros absolus
    end, 100) -- Attend 100ms pour s'assurer que la fenêtre est prête
  end,
})
