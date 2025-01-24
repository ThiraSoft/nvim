-- credit to original theme for existing : https://github.com/kdheepak/monochrome.nvim
-- NOTE: This is a modified version of it

local M = {}

M.base_30 = {
  white = "#D0D0D0",
  darker_black = "#1a1a1a",
  black = "#101010", --  nvim bg
  black2 = "#202020",
  one_bg = "#242424",
  one_bg2 = "#2e2e2e",
  one_bg3 = "#383838",
  grey = "#424242",
  grey_fg = "#ff0000",
  grey_fg2 = "#606060",
  light_grey = "#677777",
  red = "#ec8989",
  baby_pink = "#eca8a8",
  pink = "#da838b",
  line = "#2e2e2e", -- for lines like vertsplit
  green = "#c9d36a",
  vibrant_green = "#eff6ab",
  blue = "#8abae1",
  nord_blue = "#a5c6e1",
  yellow = "#ffe6b5",
  sun = "#eff6ab",
  purple = "#e1bee9",
  dark_purple = "#db9fe9",
  teal = "#6484a4",
  orange = "#efb6a0",
  cyan = "#9aafe6",
  statusline_bg = "#1e1e1e",
  lightbg = "#2e2e2e",
  pmenu_bg = "#859ba2",
  folder_bg = "#7797b7",
}

-- hello
M.base_16 = {
  base00 = "#101010",
  base01 = "#1f1f1f",
  base02 = "#2e2e2e",
  base03 = "#383838",
  base04 = "#424242",
  base05 = "#D0D0D0", --text
  base06 = "#D0D0D0",
  base07 = "#D0D0D0",
  base08 = "#D0D0D0",
  base09 = "#A0A020", -- numbers, true/false
  base0A = "#909090", --variables definitions
  base0B = "#808080", -- strings
  base0C = "#A0A020", -- mots clés private public throw import export
  base0D = "#D0D0D0", -- functions, {}
  base0E = "#555555", -- async, this, await
  base0F = "#D0D0D0",
}

M.polish_hl = {
  treesitter = {
    ["@punctuation.bracket"] = { fg = M.base_30.red },
  },
}

M.type = "dark"

M = require("base46").override_theme(M, "monochrome")

return M
