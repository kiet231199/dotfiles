vim.cmd [[packadd packer.nvim]]
-- Highlight yank
vim.api.nvim_create_autocmd("TextYankPost", {
	command = "silent! lua vim.highlight.on_yank({ timeout = 500 })",
	group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
})

-- Enter bash when open terminal (only use with linux has bash terminal)
-- vim.api.nvim_create_autocmd("TermEnter", { command = ":terminal bash"})

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
		'romgrk/barbar.nvim',
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
		{
			'nvim-telescope/telescope-fzf-native.nvim',			-- Quick search
			run = 'make',
		},
		'nvim-telescope/telescope-project.nvim',				-- Project
		'nvim-telescope/telescope-ui-select.nvim',				-- UI for telescope
		'keyvchan/telescope-find-pickers.nvim',					-- Builtin/extension picker for telescope
		'octarect/telescope-menu.nvim',							-- Menu for select prebuild command
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
	use 'Vonr/align.nvim'										-- Quick align
	use 'fedepujol/move.nvim'                   				-- Quick move
    use 'mg979/vim-visual-multi'						    	-- Multi cursor
	use 'kqito/vim-easy-replace'								-- Quick replace

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
			'ziontee113/icon-picker.nvim',						-- Icon quick search
	}

	-- Some stuff
	use {
		'voldikss/vim-floaterm',								-- Float terminal
	}
	use 'itchyny/vim-cursorword'								-- Underline word undercursor
	use 'lukas-reineke/indent-blankline.nvim'					-- Indentline
	use 'anuvyklack/pretty-fold.nvim'							-- Fold text
	use 'tversteeg/registers.nvim'								-- Registers

	use {
		'Shatur/neovim-session-manager',
		'sindrets/diffview.nvim',
	}
	use 'cbochs/portal.nvim'									-- 
	use 'https://git.sr.ht/~whynothugo/lsp_lines.nvim'			-- Show LSP diagnostics better
	use 'Civitasv/cmake-tools.nvim'								-- Cmake tools
	use 'mfussenegger/nvim-dap'									-- Debug Adapter
	use 'akinsho/git-conflict.nvim'								-- Solve conflict faster
	use 'kevinhwang91/nvim-bqf'									-- Make quickfix window better

	-- Icon source
    use 'ryanoasis/vim-devicons'
	use 'kyazdani42/nvim-web-devicons'
end)

-- ERROR: Lua takes to much time to load (noice)
-- ERROR: Clangd cannot format with 4 space tab_width (lspconfig)
-- TODO: Add LSP Line, Portal, cmake-tools, git-conflict, bqf, prettier with null-ls
-- Lualine in: tokyonight.nvim/lua/lualine/themes/tokyonight.lua
-- TODO: Config color for indentline
-- TODO: Config color for telescope
-- TODO: Config color for dressing
-- TODO: Replace Tabline with Barbar (barbar need update seperator icon color)
