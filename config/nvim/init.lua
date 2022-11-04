vim.cmd [[
	let g:python3_host_prog = '/data4/kietpham/00_nvim/tools/python-3.10.7/bin/python3'
	let g:node_host_prog = '/data4/kietpham/00_nvim/tools/node-v16.17.1/lib/node_modules/neovim/bin/cli.js'
	if has('nvim') && executable('nvr')
		let $GIT_EDITOR = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
	endif
]]

local option = vim.o
function isView()
	if option.number == true then
		option.signcolumn = "no"
		option.number = false
		option.relativenumber = false
		option.mouse = ""
		vim.cmd("IndentBlanklineToggle")
		vim.cmd("ScrollViewDisable")
	else
		option.signcolumn = "yes"
		option.number = true
		option.relativenumber = true
		option.mouse = "a"
		vim.cmd("IndentBlanklineToggle")
		vim.cmd("ScrollViewEnable")
	end
end

require("options")		 	-- Store all neovim configuration
require("keymaps")		 	-- Store all neovim remap
require("user")          	-- Call all plugins configuration

require("notify")("Welcome Kiet Pham", "info", {title="RZ Feature Package"})
