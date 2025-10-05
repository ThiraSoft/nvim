local plugin_files = {
  "avante",
  "copilot",
  "vim-godot",
  "diffview",
  "conform",
  "nvim-lspconfig",
  "zen-mode",
  "mini-surround",
  "hop",
  "nvim-rest",
  "codewindow",
  -- "minuet",
}

local plugins = {}
for _, file in ipairs(plugin_files) do
  local ok, plugin = pcall(require, "plugins." .. file)
  -- local ok, plugin = pcall(require, file)
  if ok then
    table.insert(plugins, plugin)
  else
    vim.notify("Erreur lors du chargement de " .. file, vim.log.levels.ERROR)
  end
end

return plugins
