return {
  "gorbit99/codewindow.nvim",
  lazy = false,
  config = function()
    local codewindow = require "codewindow"

    -- Configuration du plugin
    codewindow.setup {
      auto_enable = true, -- Active la minimap automatiquement
      width_multiplier = 4, -- How many characters one dot represents
      width = 12,
      symbols = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" },
      show_cursor = true,
      autoupdate = true,
      screen_bounds = "background", -- How the visible area is displayed, "lines": lines above and below, "background": background color
      window_border = "none", -- The border style of the floating window (accepts all usual options)
      relative = "win", -- What will be the minimap be placed relative to, "win": the current window, "editor": the entire editor
      events = { "TextChanged", "InsertLeave", "DiagnosticChanged", "FileWritePost" }, -- Events that update the code window
      window_opts = {
        winblend = 90, -- 0 = opaque, 100 = invisible
      },
    }

    -- Application des raccourcis clavier par défaut
    codewindow.apply_default_keybinds()
  end,
}
