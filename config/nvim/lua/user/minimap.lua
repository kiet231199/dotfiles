local minimap = {
	minimap_width = 15,
	minimap_base_highlight = 'Normal',
	minimap_highlight_range = 1,
	minimap_highlight_search = 1,
	minimap_git_colors = 1,
	minimap_enable_highlight_colorgroup = 1,
}

for k,v in pairs(minimap) do
	vim.g[k] = v
end

vim.api.nvim_set_keymap("n", "<F4>", ":MinimapToggle<CR>:MinimapRefresh<CR>", { noremap = true, silent = true })
