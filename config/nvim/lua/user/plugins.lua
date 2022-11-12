vim.cmd [[packadd packer.nvim]]
-- Highlight yank
vim.api.nvim_create_autocmd("TextYankPost", {
	command = "silent! lua vim.highlight.on_yank({ timeout = 500 })",
	group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
})

-- Packer Autocompile
vim.api.nvim_create_autocmd("VimEnter", { command = ":PackerCompile", })

-- Install your plugins here
return require("packer").startup(function(use)
	-- All the plugins (also packer) are downloaded into "~/.config/nvim/pack/packer/start/"
	use 'wbthomason/packer.nvim'                                -- Plugin manager

	-- Startup
	use 'goolord/alpha-nvim'    	               	   			-- Start up screen
	use 'lewis6991/impatient.nvim'								-- Boost startup time

	-- Colorscheme
    use 'folke/tokyonight.nvim'									-- Colorscheme

	-- File explorer
	use 'nvim-tree/nvim-tree.lua'								-- Explorer

	-- Tabline and statusline
	use {
		'nvim-lualine/lualine.nvim',							-- Statusline
		'kdheepak/tabline.nvim',								-- Tabline
	}

	-- Git
	use {
		'lewis6991/gitsigns.nvim',					    		-- Git icon
		'rhysd/git-messenger.vim', 	            				-- Git messenger
		'kdheepak/lazygit.nvim',   		 						-- Lazygit
		'sindrets/diffview.nvim',								-- Git diff
		'akinsho/git-conflict.nvim',							-- Solve conflict faster
	}

	-- Fuzzy finder
	use {
		'nvim-telescope/telescope.nvim',      					-- Telescope
		'nvim-lua/plenary.nvim',								-- Prevent duplicate function
		'nvim-telescope/telescope-file-browser.nvim',			-- File browser
		{
			'nvim-telescope/telescope-fzf-native.nvim',			-- Quick search
			run = 'make',
		},
		'nvim-telescope/telescope-project.nvim',				-- Project
		'nvim-telescope/telescope-ui-select.nvim',				-- UI for telescope
		'keyvchan/telescope-find-pickers.nvim',					-- Builtin/extension picker for telescope
		'LinArcX/telescope-command-palette.nvim',				-- Menu command
		'AckslD/nvim-neoclip.lua',               				-- Preview clipboard
	}

	-- LSP
	use {
		'neovim/nvim-lspconfig',				                -- LSP config manager
		'williamboman/mason.nvim',								-- LSP installer
		'folke/neodev.nvim',									-- LSP autoconfig
		'lukas-reineke/lsp-format.nvim',						-- LSP formatter
		'adoyle-h/lsp-toggle.nvim',								-- Enable/disable LSP
		'folke/trouble.nvim',                    				-- Show LSP diagnostics
		{
			'jose-elias-alvarez/null-ls.nvim',					-- Language server for builtin language
			'MunifTanjim/prettier.nvim',						-- Prettier for buitin language
		},
		'glepnir/lspsaga.nvim',				  					-- LSP UI
		'simrat39/symbols-outline.nvim',			 			-- LSP UI for Outline
		'Djancyp/lsp-range-format',
	}

	-- LSP completion
	use {
		'hrsh7th/nvim-cmp',										-- Completion manager
		'hrsh7th/cmp-nvim-lsp',									-- Completion for LSP
		'hrsh7th/cmp-buffer',									-- Completion for buffer
		'hrsh7th/cmp-path',										-- Completion for directory/file path
		'hrsh7th/cmp-cmdline',									-- Completion for commandline
		'saadparwaiz1/cmp_luasnip',								-- Completion for luasnip
		'quangnguyen30192/cmp-nvim-ultisnips',					-- Completion for ultisnips
		'dcampos/cmp-snippy',									-- Completion for snippy
		'petertriho/cmp-git',									-- Completion for snippy
		'lukas-reineke/cmp-under-comparator',					-- Completion sort	
	}

	-- Snippet
	use {
		'L3MON4D3/LuaSnip',
		'dcampos/nvim-snippy',
	}

	-- Highlighter
	use {
		'nvim-treesitter/nvim-treesitter',						-- Code highlight
		'p00f/nvim-ts-rainbow',									-- Bracket color
	}

	-- Bracket
	use {
		'windwp/nvim-autopairs',               					-- Auto pair
		'kylechui/nvim-surround',           					-- Smart pair
	}

	-- Notice
	use 'rcarriga/nvim-notify'            		      			-- Notice popup

	-- Commenter
	use {
		'numToStr/Comment.nvim',								-- Quick comment
		'folke/todo-comments.nvim',								-- Todo comment
	}

	-- Easy editing
	use {
		'Vonr/align.nvim',										-- Quick align
		'fedepujol/move.nvim',                   				-- Quick move
		'mg979/vim-visual-multi',						    	-- Multi cursor
		'kqito/vim-easy-replace',								-- Quick replace
		'nguyenvukhang/nvim-toggler',							-- Toggle word (true/false)
	}
	-- Search
    use {
		'VonHeikemen/searchbox.nvim', 	         				-- Search box
		'MunifTanjim/nui.nvim',
		'kevinhwang91/nvim-hlslens',							-- Highlight search
	}

	-- Scroll
    use {
		'karb94/neoscroll.nvim',             					-- Smooth scrolling
		'dstein64/nvim-scrollview',								-- Scrollbar
		'gen740/SmoothCursor.nvim',								-- Cursor pointer
	}

	-- Better UI
	use {
		'stevearc/dressing.nvim',								-- Make popup better
		{
			'folke/noice.nvim', 								-- Show message popup, LSP progress, popup commandline
			keys = { "", "<F2>" },
			config = 'require("user.noice")',
		},
		{
			'kevinhwang91/nvim-bqf',							-- Make quickfix window better
			ft = 'qf',
			{
				'junegunn/fzf', run = function()
					vim.fn['fzf#install']()
				end
			}
		}
	}

	-- Smooth window swapping
	use {
		'anuvyklack/windows.nvim',
		requires = {
			"anuvyklack/middleclass",
			"anuvyklack/animation.nvim",
		},
	}

	-- Picker
	use {
		'ziontee113/color-picker.nvim',							-- Color quick search
		'ziontee113/icon-picker.nvim',							-- Icon quick search
	}

	-- Float terminal
	use {
		'voldikss/vim-floaterm',								-- Float terminal
	}

	-- Colorful
	use {
		'itchyny/vim-cursorword',								-- Underline word undercursor
		'lukas-reineke/indent-blankline.nvim',					-- Indentline
		'anuvyklack/pretty-fold.nvim',							-- Fold text
	}

	-- Register, session 
	use 'tversteeg/registers.nvim'								-- Registers
	use 'Shatur/neovim-session-manager'							-- Session

	-- Minmap
	use 'gorbit99/codewindow.nvim'								-- Minimap window

	-- In testing
	use 'tanvirtin/vgit.nvim'
	use 'nvim-zh/colorful-winsep.nvim'

	-- Icon source (need to be placed at the end)
    use 'ryanoasis/vim-devicons'
	use 'kyazdani42/nvim-web-devicons'
end)

-- ERROR: Clangd cannot format with 4 space tab_width (lspconfig)
-- ERROR: Ultisnips not silent
-- TODO: Add function in telescope command palette
-- TODO: Config color for lualine
-- Lualine in: tokyonight.nvim/lua/lualine/themes/tokyonight.lua
-- TODO: Config color for indentline
-- TODO: Config color for telescope
-- TODO: Config color for dressing

-- INFO: Future plugins (consider later)
-- Barbar
-- Nvim Scrollbar 
