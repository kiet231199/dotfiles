local status_ok, indent_blankline = pcall(require, "indent_blankline")
if not status_ok then
	print("Error: indent_blankline")
	return
end

indent_blankline.setup
{
    char  = "│",
	space_char_blankline = " ",
	show_current_context = true,
	show_current_context_start = true,
	char_highlight_list = {
		"IndentBlanklineIndent0",
		"IndentBlanklineIndent1",
		"IndentBlanklineIndent2",
		"IndentBlanklineIndent3",
		"IndentBlanklineIndent4",
		"IndentBlanklineIndent5",
		"IndentBlanklineIndent6",
		"IndentBlanklineIndent7",
		"IndentBlanklineIndent8",
		"IndentBlanklineIndent9",
	},
}

vim.cmd [[
	highlight IndentBlanklineIndent0 guifg=#001EFF gui=nocombine
	highlight IndentBlanklineIndent1 guifg=#0038FF gui=nocombine
	highlight IndentBlanklineIndent2 guifg=#0051FF gui=nocombine
	highlight IndentBlanklineIndent3 guifg=#0067FF gui=nocombine
	highlight IndentBlanklineIndent4 guifg=#007EFF gui=nocombine
	highlight IndentBlanklineIndent5 guifg=#0099FF gui=nocombine
	highlight IndentBlanklineIndent6 guifg=#00AFFF gui=nocombine
	highlight IndentBlanklineIndent7 guifg=#00C9FF gui=nocombine
	highlight IndentBlanklineIndent8 guifg=#00DBFF gui=nocombine
	highlight IndentBlanklineIndent9 guifg=#00FFFF gui=nocombine
]]

vim.api.nvim_set_keymap("n", "<F7>", ":IndentBlanklineToggle<CR>", { noremap = true, silent = true })
