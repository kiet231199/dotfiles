local status_ok, tokyonight = pcall(require, "tokyonight")
if not status_ok then
	print("Error: tokyonight")
	return
end

tokyonight.setup({
    -- your configuration comes here
    -- or leave it empty to use the default settings
    style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
    transparent = false, -- Enable this to disable setting the background color
    terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
    styles = {
        -- Style to be applied to different syntax groups
        -- Value is any valid attr-list value for `:help nvim_set_hl`
        comments = { italic = true },
        keywords = { italic = true, bold = true },
        functions = { italic = true, bold = true },
        variables = {},
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = "night", -- style for sidebars, see below
        floats = "night", -- style for floating windows
    },
    sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
    hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
    dim_inactive = false, -- dims inactive windows
    lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold

    -- You can override specific color groups to use other groups or a hex color
    -- function will be called with a ColorScheme table
    -- @param colors ColorScheme
    on_colors = function(colors)
        -- colors.hint = colors.orange
        -- colors.error = "#ff0000"
    end,

    -- You can override specific highlights to use other groups or a hex color
    -- function will be called with a Highlights and ColorScheme table
    -- @param highlights Highlights
    -- @param colors ColorScheme
    on_highlights = function(hl, cl)
		local black = "#000000"
		hl.WinSeparator = { fg = cl.magenta, bold = true }
		hl.LineNr = { fg = "#697094" }
		hl.CursorLineNr = { fg = "#fefe14" , bold = true }
		hl.IncSearch = { fg = black, bg = cl.red1 }
		hl.TabLineFill = { bg = "#13141c" }
		hl.NvimTreeWinSeparator = { fg = "#A9B1D6" }
		hl.NvimTreeIndentMarker = { fg = "#A9B1D6" } 
		hl.NvimTreeLspDiagnosticsError = { fg = cl.red1 }
		hl.NvimTreeLspDiagnosticsError = { fg = cl.yellow }
		hl.NvimTreeLspDiagnosticsError = { fg = cl.blue2 }
		hl.NvimTreeLspDiagnosticsError = { fg = cl.tear }
	end,
})

vim.cmd[[
	highlight cNormal guifg=#BDC7F1 guibg=#1A1B26
	highlight MyLine guifg=#A9B1D6 guibg=cNormal
	highlight ScrollView guifg=#A9B1D6 guibg=None
	highlight MyHlSearch guifg=Red guibg=cNormal
	highlight Pmenu guibg=cNormal
	highlight PmenuSel guifg=None guibg=#292938
	highlight PmenuSbar guibg=cNormal
	highlight PmenuThumb guifg=#A9B1D6
	highlight cPmenuThumb guifg=#A9B1D6 guibg=None
	hi default link HlSearchNear IncSearch
	hi default link HlSearchLens cNormal
	hi default link HlSearchLensNear MyHlSearch
	hi default link HlSearchFloat IncSearch
	hi Floaterm guibg=Normal
	hi FloatermBorder guifg=#A9B1D6 guibg=Normal
	highlight GitSignsCurrentLineBlame guifg=Yellow guibg=cNormal
	colorscheme tokyonight
]]
