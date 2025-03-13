local M = {}

local palette = {
  white = "#E0E0F0",
  background = "#0b000b",
  dark_grey = "#454055",
  light_grey = "#757595",
  lighter_grey = "#B0B0C0",
  metallic_blue = "#8abae1",
  primary = "#FFC552",
  secondary = "#A050B0",
  primary_dark = "#FFC552",
  secondary_dark = "#0099AA",
  red = "#ff0000",
}

-- UI
M.base_30 = {
  white = "#D0D0D0",
  darker_black = "#0e000e", -- background nvim tree et fenetres flottantes
  black = "#300030", -- background en haut des tabs
  black2 = "#170017", -- cursor line
  one_bg = "#242424",
  one_bg2 = "#2e2e2e",
  one_bg3 = "#0f000f", -- theme switch
  grey = palette.dark_grey, -- line numbers
  grey_fg = palette.dark_grey, --"#505050", -- commentaires lua
  grey_fg2 = "#606060",
  light_grey = palette.dark_grey, -- nom dans les tabs inactifs
  red = "#ff0000",
  baby_pink = "#eca8a8",
  pink = "#da838b",
  line = "#300040", -- for lines (vertsplit et scope)
  green = "#00EE00",
  vibrant_green = "#eff6ab",
  blue = palette.white,
  nord_blue = palette.white, -- Normal mode tag statusline
  yellow = "#FFC552",
  sun = "#eff6ab",
  purple = palette.dark_grey, --"#e1bee9", -- lsp conseils
  dark_purple = palette.primary, --"#db9fe9", -- Insert mode tag statusline
  teal = "#6484a4",
  orange = "#efb6a0",
  cyan = "#9aafe6",
  statusline_bg = "#1f001f", -- status line
  lightbg = "#300030", --status line 2nd bloc
  pmenu_bg = "#859ba2",
  folder_bg = "#8787c7",
}

M.base_16 = {
  base00 = palette.background,
  base01 = "#2b2827",
  base02 = "#2f2c2b",
  base03 = "#393635",
  base04 = "#43403f",
  base05 = palette.lighter_grey,
  base06 = palette.lighter_grey,
  base07 = palette.lighter_grey,
  base08 = "#E06060",
  base09 = "#E0Ab75",
  base0A = "#E0Ab75",
  base0B = palette.lighter_grey,
  base0C = palette.light_grey,
  base0D = "#7d92a2",
  base0E = "#E06060",
  base0F = "#ab9382",
}

M.polish_hl = {
  syntax = {
    Operator = { fg = M.base_30.blue },
  },

  treesitter = {
    ["@keyword"] = { fg = palette.red },
    ["@variable.member"] = { fg = M.base_30.purple },
    ["@variable"] = { fg = M.base_16.base06 },
    ["@module"] = { fg = M.base_30.beige },
    ["@attribute"] = { fg = M.base_30.cyan },
    ["@punctuation.bracket"] = { fg = M.base_16.base06 },
    ["@parenthesis"] = { link = "@punctuation.bracket" },
    ["@variable.parameter"] = { fg = M.base_30.green },
    ["@function.builtin"] = { fg = M.base_30.yellow },
  },
}

M.type = "dark"

M = require("base46").override_theme(M, "chocolate")

return M
