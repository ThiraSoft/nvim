require("nvchad.mappings")
local map = vim.keymap.set

-- main
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>", { desc = "ESC" })

-- splits
map("n", "<leader>v", ":vsplit<CR>", { noremap = true, silent = true, desc = "Split vertical" })
map("n", "<leader>h", ":split<CR>", { noremap = true, silent = true, desc = "Split horizontal" })

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

-- jumps === === === ===
map({ "n", "v" }, "<leader>j", "}zz")
map({ "n", "v" }, "<leader>k", "{zz")
map({ "n", "v" }, "}", "}zz")
map({ "n", "v" }, "{", "{zz")
map({ "n", "v" }, ")", ")zz")
map({ "n", "v" }, "(", "(zz")

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
map(
	"n",
	"<leader>ze",
	":set foldmethod=manual<CR>|zE",
	{ noremap = true, silent = true, desc = "Set fold method to manual" }
)

-- lsp === === === ===
map(
	"n",
	"<leader>dn",
	"<cmd>lua vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARNING })<CR>",
	{ silent = true, desc = "Jump to next error" }
)

-- nvim-tree === === === ===
-- Toggle l'affichage des fichiers gitignore dans NvimTree
vim.keymap.set("n", "<leader>ti", function()
	require("nvim-tree.api").git.toggle_ignored()
end, { desc = "Toggle gitignore files in NvimTree" })

-- zen === === === ===
local zen = require("zen-mode")
local function toggleZen()
	zen.toggle({
		window = {
			width = 0.5, -- width will be 85% of the editor width
		},
		on_open = function()
			-- Fermer NvimTree si ouvert
			if vim.fn.exists("g:loaded_nvim_tree") == 1 then
				vim.cmd("NvimTreeClose")
			end
		end,
		on_close = function()
			-- Rouvrir NvimTree à la fermeture de ZenMode
			if vim.fn.exists("g:loaded_nvim_tree") == 1 then
				vim.cmd("NvimTreeOpen")
			end
		end,
	})
end
map("n", "<leader>zn", toggleZen, { desc = "Toogle zen mode" })

-- hop === === === ===
local hop = require("hop")
local directions = require("hop.hint").HintDirection
vim.keymap.set("", "f", function()
	hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
end, { remap = true })
vim.keymap.set("", "F", function()
	hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
end, { remap = true })
vim.keymap.set("", "t", function()
	hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
end, { remap = true })
vim.keymap.set("", "T", function()
	hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
end, { remap = true })
map("n", "<leader>fj", "m`<cmd>HopWord<CR>", { desc = "Find Jump" })
map("n", "fj", "m`<cmd>HopWord<CR>", { nowait = true, desc = "Find Jump" })

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
			current_bufname:find("Avante")
			or current_ft == "avante_chat"
			or current_bufname:lower():find("prompt")
			or current_bufname:lower():find("input")
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
		vim.cmd("stopinsert")
	end

	-- Parcourt toutes les fenêtres pour trouver une fenêtre de code
	local total_windows = vim.fn.winnr("$")

	for winnr = 1, total_windows do
		vim.cmd(winnr .. "wincmd w")
		if not is_plugin_window() then
			return -- On a trouvé une fenêtre de code, on s'arrête
		end
	end

	-- Si on n'a pas trouvé de fenêtre de code, on va à droite
	vim.cmd("wincmd l")
end

map(
	{ "n", "v", "t" },
	"<C-CR>",
	focus_code_window,
	{ noremap = true, silent = true, desc = "Focus sur la fenêtre de code" }
)

-- clipboard === === === ===
local function copy_file_path()
	local path = vim.fn.expand("%:p") -- Chemin complet
	vim.fn.setreg("+", path) -- Copie dans le presse-papiers
	print("Chemin copié : " .. path)
end
map("n", "<leader>yp", copy_file_path, { desc = "Copier le chemin complet du fichier" })
