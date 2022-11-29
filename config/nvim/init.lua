vim.cmd [[
	let g:python3_host_prog = '/data4/kietpham/00_dot/tools/python-3.10.7/bin/python3'
	let g:node_host_prog = '/data4/kietpham/00_dot/tools/node-v16.17.1/lib/node_modules/neovim/bin/cli.js'
	if has('nvim') && executable('nvr')
		let $GIT_EDITOR = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
	endif
]]

-- Disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- User-defined function
local option = vim.o
function IsView()
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

function SetGlobalStatusLine()
	if option.laststatus == 3 then
		option.laststatus = 2
	else
		option.laststatus = 3
	end
end

require("options")		 	-- Store all neovim configuration
require("keymaps")		 	-- Store all neovim remap
require("user")          	-- Call all plugins configuration

require("notify")("Welcome back: Kiet Pham ﱃ ", "info",{title = "RZ Feature Package"})
