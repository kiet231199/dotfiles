-- This order base on plugins.lua
require("user.packer")									-- Config for packer first
require("user.plugins")									-- Then install plugins
--
require("user.alpha")
require("user.impatient")
--
require("user.tokyonight")
--
require("user.nvim-tree")
require("user.jabs")
--
require("user.lualine")
require("user.tabline")
--
require("user.gitsigns")
require("user.gitmessenger")
require("user.lazygit")
require("user.diffview")
require("user.git-conflict")
--require("vgit").setup()
--
require("user.telescope")
--
require("user.lspconfig")
require("user.mason")
require("user.trouble")
require("user.null-ls")
require("user.prettier")
require("user.lspsaga")
require("user.cmp")
--
require("user.treesitter")
require("user.neoclip")
--
require("user.nvim-autopairs")
require("nvim-surround").setup()						-- Leave empty for default config
--
require("user.comment")
require("user.todo")
--
require("user.align")
require("user.move")
require("nvim-toggler").setup()
--
require("user.searchbox")
require("user.hlslens")
--
require("user.neoscroll")
require("user.scrollview")
require("user.smoothcursor")
--
require("user.notify")
-- require("user.noice") -- Lazyloaded
require("bqf").setup()
require("user.whichkey")
--
require("user.windows")
--
require("user.colorpicker")
require("user.iconpicker")
--
require("user.floaterm")
--
require("user.indent_blankline")
require("user.pretty-fold")
require("user.winsep")
require("user.zenmode")
require("user.twilight")
--
require("user.registers")
require("user.sessions")
--
require("user.codewindow")
--
require("user.tabout")
--
require("user.ssr")
--
require("user.highlight")
