local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	print("Error: cmp")
	return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
	print("Error: luasnip")
	return
end

--   פּ ﯟ   some other good icons
local kind_icons = {
	Text          = "",
	Method        = "m",
	Function      = "",
	Constructor   = "",
	Field         = "",
	Variable      = "",
	Class         = "",
	Interface     = "",
	Module        = "",
	Property      = "",
	Unit          = "",
	Value         = "",
	Enum          = "",
	Keyword       = "",
	Snippet       = "",
	Color         = "",
	File          = "",
	Reference     = "",
	Folder        = "",
	EnumMember    = "",
	Constant      = "",
	Struct        = "",
	Event         = "",
	Operator      = "",
	TypeParameter = "",
}

require("cmp").setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = {
		["<C-j>"] = require("cmp").mapping(function(fallback)
			if luasnip.expandable() then
				luasnip.expand()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { 'i', 's' }),
		["<C-k>"] = require("cmp").mapping(function(fallback)
			if luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { 'i', 's' }),
		["<C-Space>"] = require("cmp").mapping(require("cmp").mapping.complete(), { "i", "c" }),
		-- Accept currently selected item. If none selected, `select` first item.
		-- Set `select` to `false` to only confirm explicitly selected items.
		["<CR>"] = require("cmp").mapping.confirm({ select = true }),
		["<Tab>"] = require("cmp").mapping(function(fallback)
			if require("cmp").visible() then
				require("cmp").select_next_item()
			elseif require("luasnip").expand_or_jumpable() then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = require("cmp").mapping(function(fallback)
			if require("cmp").visible() then
				require("cmp").select_prev_item()
			elseif require("luasnip").jumpable(-1) then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
			else
				fallback()
			end
		end, { "i", "s" }),
	},
	formatting = {
		-- fields = { "abbr" ,"kind", "menu" },
		fields = { "abbr" ,"kind"},
		format = function(entry, vim_item)
			-- Kind icons
			vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
			vim_item.menu = ({
				nvim_lsp = "[LSP]",
				luasnip = "[Snippet]",
				buffer = "[Buffer]",
				path = "[Path]",
			})[entry.source.name]
			return vim_item
		end,
	},
	sources = require("cmp").config.sources({
		{ name = "nvim_lsp" },
		{ name = "nvim_lsp_signature_help" },
		{ name = "luasnip", option = { show_autosnippets = true } },
		{ name = "path" },
	}, {
		{ name = "buffer" },
	}),
	confirm_opts = {
		behavior = require("cmp").ConfirmBehavior.Replace,
		select = false,
	},
	window = {
		documentation = {
			border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
		},
		completion = {
			border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
		},
	},
	experimental = {
		ghost_text = false,
		native_menu = false,
	},
	sorting = {
        comparators = {
            require("cmp").config.compare.offset,
            require("cmp").config.compare.exact,
            require("cmp").config.compare.score,
            require "cmp-under-comparator".under,
            require("cmp").config.compare.kind,
            require("cmp").config.compare.sort_text,
            require("cmp").config.compare.length,
            require("cmp").config.compare.order,
        },
    },
})

-- Set configuration for specific filetype.
require("cmp").setup.filetype('gitcommit', {
	sources = require("cmp").config.sources({
		{ name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
	}, {
		{ name = 'buffer' },
	})
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
require("cmp").setup.cmdline({ '/', '?' }, {
	mapping = require("cmp").mapping.preset.cmdline(),
	sources = require("cmp").config.sources({
		{ name = 'nvim_lsp_document_symbols' }
	},{
		{
			name = 'buffer',
			option = { keyword_pattern = [[\k\+]] }
		},
		{
			name = 'buffer-lines',
			option = {
				words = true,
				comments = true,
			}
		}
	})
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
require("cmp").setup.cmdline(':', {
	mapping = require("cmp").mapping.preset.cmdline(),
	sources = require("cmp").config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	}, {
		{ name = 'cmdline_history' }
	})
})

vim.api.nvim_set_keymap("v", "fr", ":lua require'lsp-range-format'.format()<CR>", { noremap = true, silent = true })
