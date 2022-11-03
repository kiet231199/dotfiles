local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	print("Error: telescope")
	return
end

-- local layout_strategies = require("telescope.pickers.layout_strategies")
local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")
local myconfig = {
	height = 0.9,
	prompt_position = "top",
	preview_width = 0.5,
	width = 0.9,
}

telescope.setup({
	defaults = {
		-- Default configuration for telescope goes here:
		-- config_key = value,
		-- other layout configuration here
		prompt_prefix = '🔍: ',
	},
	mappings = {
		-- i = { ["<C-t>"] = trouble.open_with_trouble },
		-- n = { ["<C-t>"] = trouble.open_with_trouble },
	},
	pickers = {
		-- Default configuration for builtin pickers goes here:
		-- picker_name = {
		--   picker_config_key = value,
		--   ...
		-- }
		-- Now thtelescope.nvim@ene picker_config_key will be applied every time you call this
		-- builtin picker
		find_files = { layout_config = myconfig },
		live_grep = { layout_config = myconfig },
		buffers = { layout_config = myconfig },
		help_tags = { layout_config = myconfig },
		oldfiles = { layout_config = myconfig },
		keymaps = { layout_config = myconfig },
		diagnostics = { layout_config = myconfig },
		git_commits = { layout_config = myconfig },
	},
	extensions = {
		-- Your extension configuration goes here:
		fzy_native = {
			override_generic_sorter = false,
			override_file_sorter = true,
		},
		file_browser = {
			prompt_position = 'top',
			preview_width = 0.5,
			-- theme = "ivy",
			-- disables netrw and use telescope-file-browser in its place
		},
		project = {
			layout_config = center,
			base_dirs = {
				{ path = '~', max_depth = 4 },
			},
			hidden_files = true, -- default: false
			-- theme = "dropdown",
			order_by = "asc",
			sync_with_nvim_tree = true, -- default false

		},
		["ui-select"] = {
			require("telescope.themes").get_dropdown()
		}
	},
})

telescope.load_extension('file_browser')
telescope.load_extension('fzy_native')
telescope.load_extension('project')
telescope.load_extension('ui-select')
telescope.load_extension('find_pickers')
telescope.load_extension('neoclip')
telescope.load_extension('noice')

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("", "<leader>ff", ":Telescope find_files promt_prefix=🔍<CR>", opts)
keymap("", "<leader>fg", ":Telescope live_grep promt_prefix=🔍<CR>", opts)
keymap("", "<leader>f<TAB>", ":Telescope buffers promt_prefix=🔍<CR>", opts)
keymap("", "<leader>fb", ":Telescope file_browser promt_prefix=🔍<CR>", opts)
keymap("", "<leader>fh", ":Telescope help_tags promt_prefix=🔍<CR>", opts)
keymap("", "<leader>of", ":Telescope oldfiles promt_prefix=🔍<CR>", opts)
keymap("", "<leader>fk", ":Telescope keymaps promt_prefix=🔍<CR>", opts)
keymap("", "<leader>fp", ":Telescope project promt_prefix=🔍<CR>", opts)
keymap("", "<leader>fc", ":Telescope neoclip unnamed extra=star,plus,a,b promt_prefix=🔍<CR>", opts)
keymap("", "<leader>fn", ":Telescope noice promt_prefix=🔍<CR>", opts)
keymap("", "<leader>ft", ":lua require'telescope.builtin'.diagnostics{}<CR>", opts)
keymap("", "<leader>fr", ":lua require'telescope.builtin'.registers{}<CR>", opts)
keymap("", "<leader>fl", ":lua require'telescope.builtin'.git_commits{}<CR>", opts)
keymap("", "<leader>fe", ":lua require'telescope'.extensions.find_pickers.find_pickers()<CR>", opts)
keymap("", "<leader>td", ":TodoTelescope keyword=TODO,FIX,ERROR,HACK,NOTE,WARNING,PERF promt_prefix=🔍<CR>", opts)

-- <C-n>/<Down			Next item
-- <C-p>/<Up			Previous item
-- j/k					Next/previous (in normal mode)
-- H/M/L				Select High/Middle/Low (in normal mode)
-- gg/G				Select the first/last item (in normal mode)
-- <CR>				Confirm selection
-- <C-x				Go to file selection as a split
-- <C-v				Go to file selection as a vsplit
-- <C-t				Go to a file in a new tab
-- <C-u				Scroll up in preview window
-- <C-d				Scroll down in preview window
-- <C-/				Show mappings for picker actions (insert mode)
-- ?					Show mappings for picker actions (normal mode)
-- <C-c				Close telescope
-- <Esc				Close telescope (in normal mode)
-- <Tab				Toggle selection and move to next selection
-- <S-Tab				Toggle selection and move to prev selection
-- <C-q				Send all items not filtered to quickfixlist (qflist)
-- <M-q				Send all selected items to qflist
