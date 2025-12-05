-- Place un fond jaune si on est dans les node_modules
local normal_hl = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
Base_bg_color = normal_hl and normal_hl.bg or nil

-- Configuration spécifique pour les fichiers Go (tabs de 8 espaces)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.opt_local.expandtab = false -- tabs, pas d'espaces
    vim.opt_local.shiftwidth = 8 -- affichage d'un tab = 8 colonnes
    vim.opt_local.tabstop = 8
    vim.opt_local.softtabstop = 8
  end,
})

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

-- Log pour chronos on save (Version Asynchrone Optimisée)
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*",
  callback = function()
    local file_path = vim.fn.expand "%:p"
    local arg = "NVIM_SAVE:" .. file_path

    local cmd = string.format(
      [[
      log_dir="$HOME/zsh_logs"
      mkdir -p "$log_dir"
      timestamp=$(date "+%%Y-%%m-%%d %%H:%%M:%%S")
      today=$(date "+%%Y-%%m-%%d")
      
      git_root=$(git rev-parse --show-toplevel 2>/dev/null)
      if [ -n "$git_root" ]; then
        project_dir="$git_root"
        git_branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "void")
      else
        project_dir=$(pwd)
        git_branch="void"
      fi
      
      echo "[$timestamp] [$project_dir] [$git_branch] %s" >> "$log_dir/$today.log"
    ]],
      arg
    )
    vim.system({ "zsh", "-c", cmd }, { text = true })
  end,
  desc = "Log save async",
})

-- Hook d'ouverture de neovim
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Efface la jumplist à chaque ouverture de session
    vim.cmd "clearjumps"
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

-- Auto-enable LSP
vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
  pattern = { "*.go", "go" },
  callback = function()
    vim.lsp.enable "gopls"
  end,
})

-- Auto-enable Python
vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
  pattern = { "*.py", "python" },
  callback = function()
    if vim.bo.filetype == "python" then
      vim.lsp.enable "pyright"
    end
  end,
})

vim.api.nvim_create_autocmd({ "FileType", "BufEnter", "BufReadPost", "BufNewFile" }, {
  pattern = { "typescript", "html", "typescriptreact" },
  callback = function()
    if vim.fs.root(0, { "angular.json" }) then
      vim.lsp.enable "angularls"
    end
  end,
})

-- Inlay hints
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })

    -- Keymaps
    local opts = { buffer = args.buf }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  end,
})
