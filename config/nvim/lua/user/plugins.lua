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
		'kdheepak/lazygit.nvim',   	 						-- Lazygit
	}

	-- Fuzzy finder
	use {
		'nvim-telescope/telescope.nvim',      					-- Telescope
		'nvim-lua/plenary.nvim',								-- Prevent duplicate function
		'nvim-telescope/telescope-file-browser.nvim',			-- File browser
		'nvim-telescope/telescope-fzy-native.nvim',				-- Quick search
		'nvim-telescope/telescope-project.nvim',				-- Project
		'nvim-telescope/telescope-ui-select.nvim',				-- UI for telescope
		'keyvchan/telescope-find-pickers.nvim',					-- Builtin/extension picker for telescope
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
		'jose-elias-alvarez/null-ls.nvim',						-- Language server for unknown language
		'glepnir/lspsaga.nvim',				  					-- LSP UI
		'simrat39/symbols-outline.nvim',			 			-- LSP UI
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
		'SirVer/ultisnips',
		'dcampos/nvim-snippy',
	}

	-- Highlighter
	use {
		'nvim-treesitter/nvim-treesitter',						-- Code highlight
		'p00f/nvim-ts-rainbow',									-- Bracket color
	}

	-- Bracket -- Waiting for treesitter
	use {
		'windwp/nvim-autopairs',               					-- Auto pair
		'kylechui/nvim-surround',           					-- Smart pair
	}

	-- Notice
	use 'rcarriga/nvim-notify'            		      			-- Notice popup

	-- Commenter
	use 'numToStr/Comment.nvim'									-- Quick comment
    use 'folke/todo-comments.nvim'								-- Todo comment

	-- Easy editing
	use 'Vonr/align.nvim'
	use 'fedepujol/move.nvim'                   				-- Quick move
    use 'mg979/vim-visual-multi'						    	-- Multi cursor

	-- Search
    use {
		'VonHeikemen/searchbox.nvim', 	         				-- Search box
		'MunifTanjim/nui.nvim',
		'kevinhwang91/nvim-hlslens',							-- Highlight search
	}

	-- Scroll
    use 'karb94/neoscroll.nvim'             					-- Smooth scrolling
	use 'dstein64/nvim-scrollview'								-- Scrollbar
	use 'gen740/SmoothCursor.nvim'								-- Cursor pointer

	-- Better UI
	use 'stevearc/dressing.nvim'								-- Make popup better
	use {
		'folke/noice.nvim', 									-- Make popup better 
		keys = { "", "<F2>" },
		config = 'require("user.noice")',
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
			'ziontee113/color-picker.nvim',						-- Color quick search
			'ziontee113/icon-picker.nvim',							-- Icon quick search
	}

	-- Some stuff
	use {
		'voldikss/vim-floaterm',									-- Float terminal
	}
	use {
		'folke/twilight.nvim',									-- Focus on function / paragraph
		requires = {
			'folke/zen-mode.nvim',
			after = 'twilight.nvim',
		},
		cmd = 'Twilight',
	}
	use 'itchyny/vim-cursorword'								-- Underline word undercursor
	use 'lukas-reineke/indent-blankline.nvim'					-- Indentline
	use 'kvngvikram/rightclick-macros'							-- Rightclick menu
	use 'anuvyklack/pretty-fold.nvim'							-- Fold text
	use 'tversteeg/registers.nvim'

	use {
		'akinsho/bufferline.nvim',
		'Shatur/neovim-session-manager',
		'sindrets/diffview.nvim',
	}

	-- Icon source
    use 'ryanoasis/vim-devicons'
	use 'kyazdani42/nvim-web-devicons'
end)

-- ERROR: Pretty fold cannot config with -|
-- WARN: Cannot use lazygit - workaround: checkout branch 0.4.3
-- TODO: Add TS Library to linux
-- TODO: Replace Tabline with Bufferline
-- TODO: Config color for indentline
-- TODO: Config color for telescope
-- TODO: Config color for dressing

