local floaterm = {
	floaterm_wintype = 'float',
	floaterm_borderchars = '─│─│╭╮╯╰',
	floaterm_opener = 'vsplit',
	floaterm_keymap_new    = '<A-n><F8>',
	floaterm_keymap_kill	 = '<A-x><F8>',
	-- floaterm_keymap_toggle = '<F8>',
}

for k,v in pairs(floaterm) do
	vim.g[k] = v
end

-- " Move floaterm
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

vim.cmd [[
	tnoremap <C-left> <C-\><C-n> :FloatermUpdate --width=0.5 --wintype=vsplit --position=topleft<CR>
	tnoremap <C-up> <C-\><C-n> :FloatermUpdate --height=0.5 --wintype=split --position=leftabove --opener=vsplit<CR>
	tnoremap <C-right> <C-\><C-n> :FloatermUpdate --width=0.5 --wintype=vsplit --position=botright<CR>
	tnoremap <C-down> <C-\><C-n> :FloatermUpdate --height=0.5 --wintype=split --position=rightbelow --opener=vsplit<CR>

	tnoremap <C-t> <C-\><C-n>
	tnoremap <RightMouse> ip
]]
