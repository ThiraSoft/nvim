vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v1.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- Configuration pour NvimTree
function NvimTreeWidth()
  local winwidth = vim.go.columns
  if winwidth <= 100 then
    return 30
  elseif winwidth <= 200 then
    return 40
  else
    return 50
  end
end
require("nvim-tree").setup {
  renderer = {
    -- Autres options de rendu...
  },
  view = {
    width = NvimTreeWidth(), -- Définit la largeur de NvimTree à 25% de la largeur de l'écran
    side = "left", -- Positionne NvimTree à gauche (tu peux aussi mettre "right")
  },
  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
}

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

-- load mappings
vim.schedule(function()
  require "mappings"
end)

-- -- Autocmds
-- vim.api.nvim_create_autocmd("BufEnter", {
--   callback = function()
--     -- Ouvre tous les folds
--     vim.cmd "normal! zR"
--   end,
-- })

-- autocompletion par ia
-- require("cmp").setup {
--   sources = {
--     {
--       -- Include minuet as a source to enable autocompletion
--       { name = "minuet" },
--       -- and your other sources
--     },
--   },
--   performance = {
--     -- It is recommended to increase the timeout duration due to
--     -- the typically slower response speed of LLMs compared to
--     -- other completion sources. This is not needed when you only
--     -- need manual completion.
--     -- fetching_timeout = 2000,
--   },
--   mapping = {
--     ["<C-b>"] = require("minuet").make_cmp_map(),
--     -- and your other keymappings
--   },
-- }
--
