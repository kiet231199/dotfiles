local status_ok, gitconflict = pcall(require, "git-conflict")
if not status_ok then
	print("Error: git-conflict")
	return
end

gitconflict.setup({
	default_mappings = true, -- disable buffer local mapping created by this plugin
	disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
	highlights = { -- They must have background color, otherwise the default color will be used
		incoming = 'DiffText',
		current = 'DiffAdd',
	}
})

vim.keymap.set('n', '<leader>co', 'GitConflictChooseOurs')
vim.keymap.set('n', '<leader>ct', 'GitConflictChooseTheirs')
vim.keymap.set('n', '<leader>cb', 'GitConflictChooseBoth')
vim.keymap.set('n', '<leader>c0', 'GitConflictChooseNone')
vim.keymap.set('n', '<leader>cp', 'GitConflictPrevConflict')
vim.keymap.set('n', '<leader>cn', 'GitConflictNextConflict')
vim.keymap.set('n', '<leader>cl', 'GitConflictListQf')
