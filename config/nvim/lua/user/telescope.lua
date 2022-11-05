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
	width = 0.95,
	preview_width = 0.6,
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
		find_files = {
			layout_config = myconfig,
			prompt_title = 'File Search',
		},
		live_grep = {
			layout_config = myconfig,
			prompt_title = 'String Search',
		},
		buffers = {
			layout_config = myconfig,
			prompt_title = 'Buffer Search',
		},
		help_tags = {
			layout_config = myconfig,
			prompt_title = 'Documents Search',
		},
		keymaps = {
			layout_config = myconfig,
			prompt_title = 'Keymap Search',
		},
		diagnostics = {
			layout_config = myconfig,
			prompt_title = 'LSP Diagnostics Search',
		},
		registers = {
			layout_config = myconfig,
			prompt_title = 'Registers Search',
		},
		git_commits = {
			layout_config = myconfig,
			prompt_title = 'Git Search',
		},
		-- Default configuration for builtin pickers goes here:
		-- picker_name = {
		--   picker_config_key = value,
		--   ...
		-- }
		-- Now telescope.nvim@ene picker_config_key will be applied every time you call this
	},
	extensions = {
		-- Your extension configuration goes here:
		fzf = {
			fuzzy = true,                    -- false will only do exact matching
			override_generic_sorter = true,  -- override the generic sorter
			override_file_sorter = true,     -- override the file sorter
			case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
		file_browser = {
			layout_config = myconfig,
			prompt_title = 'File Browser',
			-- theme = "ivy",
			-- disables netrw and use telescope-file-browser in its place
		},
		project = {
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
		},
		menu = {
			default = {
				items = {
					-- You can add an item of menu in the form of { "<display>", "<command>" }
					{ "Toggle Auto Width", "WindowsToggleAutowidth" },
					{ "Pick Color", "PickColor" },
					{ "Pick Icon", "IconPickerInsert" },
					{ "Toggle LSP", "ToggleLSP" },
					{ "Null LS", "ToggleNullLSP" },
				},
			},
		},
	}
})

telescope.load_extension('file_browser')
telescope.load_extension('fzf')
telescope.load_extension('project')
telescope.load_extension('ui-select')
telescope.load_extension('find_pickers')
telescope.load_extension('neoclip')
telescope.load_extension('menu')
telescope.load_extension('noice')

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("", "<leader>fg", ":Telescope live_grep<CR>", opts)
keymap("", "<leader>f<TAB>", ":Telescope buffers<CR>", opts)
keymap("", "<leader>fh", ":Telescope help_tags<CR>", opts)
-- keymap("", "<leader>of", ":Telescope oldfiles<CR>", opts)
keymap("", "<leader>fk", ":Telescope keymaps<CR>", opts)
keymap("", "<leader>ft", ":Telescope diagnostics<CR>", opts)
keymap("", "<leader>fr", ":Telescope registers<CR>", opts)
keymap("", "<leader>fl", ":Telescope git_commits<CR>", opts)

keymap("", "<leader>fb", ":Telescope file_browser<CR>", opts)
keymap("", "<leader>fp", ":Telescope project<CR>", opts)
keymap("", "<leader>fe", ":Telescope find_pickers<CR>", opts)
keymap("", "<leader>fc", ":Telescope neoclip unnamed extra=star,plus,a,b<CR>", opts)
keymap("", "<leader>fm", ":Telescope menu<CR>", opts)
keymap("", "<leader>fn", ":Telescope noice<CR>", opts)
keymap("", "<leader>td", ":TodoTelescope keyword=TODO,FIX,ERROR,HACK,NOTE,WARNING,PERF<CR>", opts)

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
