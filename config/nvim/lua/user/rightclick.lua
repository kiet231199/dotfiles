local rightclick = {
	rightclick_normal_items = {
		'Function       ',
	  	'---------------',
	  	'Autowidth      ',
	  	'Color Pick     ',
	  	'Icon Pick      ',
	  	'LSP            ',
	  	'Null LS        ',
	  	'Twilight       ',
	},
	rightclick_normal_macros = {
		':',
	  	':',
		':WindowsToggleAutowidth',
	  	':PickColor',
	  	':IconPickerInsert',
	  	':ToggleLSP',
	  	':ToggleNullLSP',
	  	':Twilight',
	},
	rightclick_nvim_boarder_nw = "╭",
	rightclick_nvim_boarder_ne = "╮",
	rightclick_nvim_boarder_sw = "╰",
	rightclick_nvim_boarder_se = "╯",
	rightclick_nvim_boarder_h  = "─",
	rightclick_nvim_boarder_v  = "│",
	rightclick_default_config = 0,
	rightclick_default_mappings = 0,
}

for k,v in pairs(rightclick) do
	vim.g[k] = v
end

vim.api.nvim_set_keymap("", "<A-m>", ":call Rightclick_normal()<CR>", { noremap = true, silent = true })
