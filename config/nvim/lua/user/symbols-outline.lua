local status_ok, symbolsoutline = pcall(require, "symbols-outline")
if not status_ok then
	print("Error: symbols-outline")
	return
end

symbolsoutline.setup({
	highlight_hovered_item = true,
	show_guides = true,
	auto_preview = false,
	position = 'right',
	relative_width = false,
	width = 40,
	auto_close = false,
	show_numbers = false,
	show_relative_numbers = true,
	show_symbol_details = true,
	preview_bg_highlight = 'Normal',
	winblend = 25,
	autofold_depth = nil,
	auto_unfold_hover = true,
	fold_markers = { '', '' },
	wrap = false,
	keymaps = { -- These keymaps can be a string or a table for multiple keys
		close = {"<Esc>", "q"},
		goto_location = "<Cr>",
		focus_location = "o",
		hover_symbol = "<C-space>",
		toggle_preview = "K",
		rename_symbol = "r",
		code_actions = "a",
		fold = "h",
		unfold = "l",
		fold_all = "W",
		unfold_all = "E",
		fold_reset = "R",
	},
	lsp_blacklist = {},
	symbol_blacklist = {},
	symbols = {
		File = {icon = "", hl = "TSURI"},
		Module = {icon = " ", hl = "TSNamespace"},
		Namespace = {icon = "", hl = "TSNamespace"},
		Package = {icon = " ", hl = "TSNamespace"},
		Class = {icon = " ", hl = "TSType"},
		Method = {icon = " ", hl = "TSMethod"},
		Property = {icon = "", hl = "TSMethod"},
		Field = {icon = " ", hl = "TSField"},
		Constructor = {icon = " ", hl = "TSConstructor"},
		Enum = {icon = " ", hl = "TSType"},
		Interface = {icon = " ", hl = "TSType"},
		Function = {icon = "", hl = "TSFunction"},
		Variable = {icon = "", hl = "TSConstant"},
		Constant = {icon = " ", hl = "TSConstant"},
		String = {icon = " ", hl = "TSString"},
		Number = {icon = " ", hl = "TSNumber"},
		Boolean = {icon = " ", hl = "TSBoolean"},
		Array = {icon = "", hl = "TSConstant"},
		Object = {icon = "{}", hl = "TSType"},
		Key = {icon = "🔐", hl = "TSType"},
		Null = {icon = "NULL", hl = "TSType"},
		EnumMember = {icon = "", hl = "TSField"},
		Struct = {icon = " ", hl = "TSType"},
		Event = {icon = "", hl = "TSType"},
		Operator = {icon = " ", hl = "TSOperator"},
		TypeParameter = {icon = "", hl = "TSParameter"},
	}
})

vim.api.nvim_set_keymap("", "<F6>", ":WindowsToggleAutowidth<CR>:SymbolsOutline<CR>", { noremap = true, silent = true })

vim.cmd [[ 
	highlight SymbolsOutlineConnector guifg=#A9B1D6
]]
