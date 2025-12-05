local M = {}

local palette = {
  white = "#E0E0F0",
  background = "#0c0c0c",
  darker_grey = "#1c1c1c",
  dark_grey = "#454555",
  light_grey = "#757595",
  lighter_grey = "#B0B0C0",
  metallic_blue = "#8abae1",
  primary = "#FFC552",
  secondary = "#A050B0",
  primary_dark = "#FFC552",
  secondary_dark = "#0099AA",
  red = "#ff0000",
}

local function rgb(r, g, b)
  return string.format("#%02x%02x%02x", r, g, b)
end

-- palete de couleurs
local noir1 = rgb(12, 12, 12)
local noir2 = rgb(18, 18, 18)

local dark_gris1 = rgb(48, 48, 68)
local dark_gris2 = rgb(68, 68, 88)
local dark_gris3 = rgb(88, 88, 108)

local gris1 = rgb(108, 108, 128)
local gris2 = rgb(140, 140, 160)
local gris3 = rgb(172, 172, 192)

local light_gris1 = rgb(200, 200, 220)
local light_gris2 = rgb(220, 220, 240)
local light_gris3 = rgb(235, 235, 255)

local primary = "#E06060"
local secondary = "#00B0A0"
local secondary2 = "#101c20"

local rouille2 = "#E09090"
local moutarde1 = "#C09040"
local moutarde2 = "#E0A060"
local moutarde3 = "#F0C0A0"
local bleu = "#5080B0"
local violet = "#9040B0"

local calls = light_gris2
local selection = secondary2

-- UI
M.base_30 = {
  white = light_gris3, -- file name in active tabs
  darker_black = noir2, -- background nvim tree et fenetres flottantes
  black = selection, -- background en haut des tabs et selection dans nvim tree
  black2 = selection, -- cursor line
  one_bg = "#242424",
  one_bg2 = "#2e2e2e",
  one_bg3 = "#303040", -- theme switch
  grey = dark_gris1, -- line numbers
  grey_fg = dark_gris3, --"#505050", -- commentaires lua
  grey_fg2 = dark_gris2,
  light_grey = dark_gris3, -- nom dans les tabs inactifs
  red = palette.red,
  baby_pink = "#eca8a8",
  pink = "#da838b",
  line = dark_gris1, -- for lines (vertsplit et scope)
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
  statusline_bg = "#0e0e0f", -- status line
  lightbg = "#202030", --status line 2nd bloc
  pmenu_bg = "#859ba2",
  folder_bg = "#7797b7",
}

M.base_16 = {
  base00 = noir1,
  base01 = "#2b2827",
  base02 = "#2f2c2b",
  base03 = "#393635",
  base04 = "#43403f",
  base05 = palette.lighter_grey,
  base06 = palette.lighter_grey,
  base07 = palette.lighter_grey,
  base08 = palette.light_grey, -- properties
  base09 = gris3, --constants, numbers, true/false
  base0A = light_gris1, -- types / search result
  base0B = palette.light_grey, -- strings
  base0C = palette.light_grey, -- () lua
  base0D = "#7d92a2",
  base0E = primary, -- keywords 'async, await, func, if, return'
  base0F = palette.light_grey, -- () {}
}

M.polish_hl = {
  syntax = {
    -- Operator = { fg = "#f09090" },
    -- goString = { fg = moutarde1 },
  },

  treesitter = {
    ["@keyword.repeat"] = { fg = primary },
    ["@operator"] = { fg = dark_gris3 },
    ["@keyword"] = { fg = primary },
    ["@type"] = { fg = secondary },
    ["@type.builtin"] = { fg = secondary },
    ["@module.go"] = { fg = secondary },
    ["Include"] = { fg = primary },
    ["@field"] = { fg = light_gris1 },

    ["@Constructor"] = { fg = secondary },
    ["@Constructor.lua"] = { fg = gris1 },
    ["@Constructor.pyhon"] = { fg = secondary },
    ["@function"] = { fg = calls },
    ["@function.go"] = { fg = calls },
    ["@function.method"] = { fg = calls },
    ["@function.method.go"] = { fg = calls },
    ["@function.call"] = { fg = calls },
    ["@function.call.go"] = { fg = calls },
    ["@function.call.python"] = { fg = calls },
    ["@function.method.call"] = { fg = calls },
    ["@function.method.call.go"] = { fg = calls },
    ["@function.method.call.python"] = { fg = calls },
    ["@function.builtin.go"] = { fg = calls },
    ["@function.builtin.python"] = { fg = calls },

    ["@string"] = { fg = gris1, italic = false },
    ["@string.go"] = { fg = gris1, italic = false },
    ["@variable.member"] = { fg = gris1 },
    ["@variable.member.go"] = { fg = gris1 },
    ["@constant"] = { fg = gris3 },
    ["@constant.go"] = { fg = gris3 },
    ["@variable"] = { fg = gris3 },
    ["@variable.go"] = { fg = gris3 },
    ["@property"] = { fg = gris2 },
    ["@property.go"] = { fg = gris2 },
    ["@number"] = { fg = secondary },
    ["@number.float"] = { fg = secondary },

    -- ["@variable"] = { fg = M.base_16.base06 },
    --   ["@attribute"] = { fg = M.base_30.cyan },
    --   ["@punctuation.bracket"] = { fg = M.base_16.base06 },
    --   ["@parenthesis"] = { link = "@punctuation.bracket" },
    --   ["@variable.parameter"] = { fg = M.base_30.green },
    --   ["@function.builtin"] = { fg = M.base_30.yellow },
    -- ["@comment"] = { fg = dark_gris1, italic = false },
    -- ["@comment.go"] = { fg = moutarde1, italic = false },
    -- ["@spell"] = { fg = gris1, italic = false },
    -- ["@spell.go"] = { fg = gris1, italic = false },
  },
}

M.type = "dark"

M = require("base46").override_theme(M, "chocolate")

return M
