local status_ok, searchbox = pcall(require, "searchbox")
if not status_ok then
	print("Error: searchbox")
	return
end

searchbox.setup({
	defaults = {
		reverse = false,
		exact = true,
		prompt = '🔍 ',
		modifier = 'disabled',
		confirm = 'yes',
		clear_matches = true,
		show_matches = false,
	},
	popup = {
		relative = 'cursor',
		position = {
			row = 2,
			col = 0,
		},
    	size = 30,		
		border = {
			style = 'rounded',
			text = {
				top = ' Search ',
				top_align = 'left',
			},
		},
		win_options = {
			winhighlight = 'Normal:Normal,FloatBorder:Normal',
		},
	},
})

local opts = { noremap = true, silent = true }

-- Search word
vim.api.nvim_set_keymap("n", "<A-f>", ":SearchBoxIncSearch title=Search<CR>", opts)
vim.api.nvim_set_keymap("v", "<A-f>", ":SearchBoxIncSearch title=Search visual_mode=true<CR>", opts)

-- Search current word undercursor
vim.api.nvim_set_keymap("n", "<A-S-f>", ":SearchBoxIncSearch title=Search -- <C-r>=expand('<cword>')<CR><CR>", opts)
vim.api.nvim_set_keymap("v", "<A-S-f>", ":SearchBoxIncSearch title=Search visual_mode=true -- <C-r>=expand('<cword>')<CR><CR>", opts)

-- Replace word with confirm
vim.api.nvim_set_keymap("n", "<A-r>", ":SearchBoxReplace title=Search confirm=menu<CR>", opts)
vim.api.nvim_set_keymap("v", "<A-r>", ":SearchBoxReplace title=Search confirm=menu visual_mode=true<CR>", opts)

-- Replace current word undercursor with confirm
vim.api.nvim_set_keymap("n", "<A-S-r>", ":SearchBoxReplace title=Search confirm=menu -- <C-r>=expand('<cword>')<CR><CR>", opts)
vim.api.nvim_set_keymap("v", "<A-S-r>", ":SearchBoxReplace title=Search confirm=menu visual_mode=true -- <C-r>=expand('<cword>')<CR><CR>", opts)
