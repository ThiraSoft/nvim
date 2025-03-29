-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "custom",
	theme_toggle = { "custom", "github_light" },
	transparency = false,

	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },
}

vim.cmd("highlight St_relativepath guifg=#626a83 guibg=#2a2b36")

local stbufnr = function()
	return vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)
end

M.ui = {

	telescope = { style = "borderless" }, -- borderless / bordered
	statusline = {
		theme = "default",
		order = { "mode", "relativepath", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "cwd" },
		-- order = { "mode", "relativepath", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "cwd", "cursor" },
		modules = {
			relativepath = function()
				local path = vim.api.nvim_buf_get_name(stbufnr())

				if path == "" then
					return ""
				end

				return "%#St_relativepath#  " .. vim.fn.expand("%:.:h") .. " /"
			end,
		},
	},
}

M.nvdash = {
	load_on_startup = true,
	-- header = {
	-- 	"                           ",
	-- 	"                           ",
	-- 	"                           ",
	-- 	"           eovim          ",
	-- 	"                           ",
	-- 	"                           ",
	-- 	"                           ",
	-- },

	header = {

		"                                                                   ",
		"                                                                   ",
		"                                                                   ",
		"    .                                                         .    ",
		"     .                                                       .     ",
		"      .                                                     .      ",
		"       ...                                               ...       ",
		"         ....                                         ....         ",
		"     .     . ...                                   ... .     .     ",
		"      ..        ..                               ..        ..      ",
		"      .....        ..                         ..        .....      ",
		"       ........      ..                      .      ........       ",
		"         ..........    .                   .    ..........         ",
		"             .........   .               .   .........             ",
		"        ................. .             . .................        ",
		"            ...............             ...............            ",
		"              ..............           ..............              ",
		"             .   ...  ...  o   eovim  o  ...  ...   .             ",
		"                 .  .      .           .      .  .                 ",
		"                   .    ...             ...    .                   ",
		"                      ....               ....                      ",
		"                    .....                 .....                    ",
		"                  ......                   ......                  ",
		"                 ......                     ......                 ",
		"                .......                     .......                ",
		"                ..... .                     . .....                ",
		"               . ....  .                      .... .               ",
		"               ..  ..                         ..  ..               ",
		"                    .                         .                    ",
		"              .                                     .              ",
		"              .                                     .              ",
		"                                                                   ",
	},

	buttons = {
		{ txt = "", cmd = "Telescope oldfiles" },
		-- { txt = "  Recent Files", cmd = "Telescope oldfiles" },
		-- { txt = "  Find File", keys = "ff", cmd = "Telescope find_files" },
		-- { txt = "󰈭  Find Word", keys = "fw", cmd = "Telescope live_grep" },

		-- { txt = "─", hl = "NvDashFooter", no_gap = false, rep = true },
		--
		-- {
		-- 	txt = function()
		-- 		local stats = require("lazy").stats()
		-- 		local ms = math.floor(stats.startuptime) .. " ms"
		-- 		return "  Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms
		-- 	end,
		-- 	hl = "NvDashFooter",
		-- 	no_gap = true,
		-- },
		--
		-- { txt = "─", hl = "NvDashFooter", no_gap = false, rep = true },
	},
}
return M
