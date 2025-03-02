local plugin_files = {
  "copilot",
  "diffview",
  "conform",
  "nvim-lspconfig",
  "zen-mode",
  "mini-surround",
  -- "minuet",
}

local plugins = {}
for _, file in ipairs(plugin_files) do
  local ok, plugin = pcall(require, "plugins." .. file)
  if ok then
    table.insert(plugins, plugin)
  else
    vim.notify("Erreur lors du chargement de " .. file, vim.log.levels.ERROR)
  end
end

return plugins
