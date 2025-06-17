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
    branch = "v2.5",
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
    return 45
  else
    return 55
  end
end
require("nvim-tree").setup {
  renderer = {
    -- Autres options de rendu...
  },
  view = {
    width = NvimTreeWidth(),
    side = "left",
    signcolumn = "no",
  },
  actions = {
    open_file = {
      quit_on_open = false,
    },
  },
  update_focused_file = {
    enable = true,
    update_cwd = false,
    ignore_list = {},
  },
}

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"
require "autocmds"

-- load mappings
vim.schedule(function()
  require "mappings"
end)

require("nvim-treesitter.configs").setup {
  highlight = {
    enable = true,
    -- Permet de surligner les balises personnalisées Angular
    additional_vim_regex_highlighting = true,
  },
}

-- cmp
local cmp = require "cmp"
cmp.setup {
  completion = {
    autocomplete = { require("cmp.types").cmp.TriggerEvent.TextChanged },
  },
  mapping = cmp.mapping.preset.insert {
    -- ["<leader>p"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm { select = true },
    ["<Tab>"] = cmp.mapping(function(fallback)
      local copilot_suggestion = require "copilot.suggestion"
      local avante = require "avante"

      -- Vérifier d'abord si Copilot a une suggestion
      if copilot_suggestion.is_visible() then
        print "Suggestion acceptée : Copilot"
        copilot_suggestion.accept()
      -- Ensuite vérifier si Avante a une suggestion
      elseif avante.has_suggestion and avante.has_suggestion() then
        print "Suggestion acceptée : Claude/Avante"
        avante.accept_suggestion()
      -- Sinon, comportement par défaut
      else
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, true, true), "n", true)
      end
    end, { "i", "s" }),
  },
  sources = cmp.config.sources {
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
  },
}

-- surround
require("mini.surround").setup()

-- Ajout de couleurs a diffview
vim.opt.fillchars:append { diff = "/" }
vim.api.nvim_set_hl(0, "DiffviewDiffAdd", { bg = "#003025" })
vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#003025" })
vim.api.nvim_set_hl(0, "DiffviewDiffAddAsDelete", { bg = "#400000" })
vim.api.nvim_set_hl(0, "DiffAddAsDelete", { bg = "#400000" })
vim.api.nvim_set_hl(0, "DiffviewDiffDelete", { bg = "#400000" }) --, fg = "#200000" })
vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#400000" }) --, fg = "#200000" })
vim.api.nvim_set_hl(0, "DiffviewDiffChange", { bg = "#002030" })
vim.api.nvim_set_hl(0, "DiffChange", { bg = "#002030" })
vim.api.nvim_set_hl(0, "DiffviewDiffText", { bg = "#203959" })
vim.api.nvim_set_hl(0, "DiffText", { bg = "#203959" })
