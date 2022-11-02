local status_ok, nvimautopairs = pcall(require, "nvim-autopairs")
if not status_ok then
	print("Error: nvim-autopairs")
	return
end

nvimautopairs.setup({
	disable_filetype = { "TelescopePrompt" },
	disable_in_macro = false,							-- disable when recording or executing a macro
	disable_in_visualblock = false,						-- disable when insert after visual block mode
	ignored_next_char = [=[[%w%%%'%[%"%.]]=],
	enable_moveright = true,
	enable_afterquote = true,							-- add bracket pairs after quote
	enable_check_bracket_line = false,					-- check bracket in same line
	enable_bracket_in_quote = true,
	enable_abbr = false,							 	-- trigger abbreviation
	break_undo = true,									-- switch for basic rule break undo sequence
	check_ts = true,
	ts_config = {
		lua = {'string'},-- it will not add a pair on that treesitter node
		javascript = {'template_string'},
		java = false,-- don't check treesitter on java
	},
	map_cr = true,
	map_bs = true,										-- map the <BS> key
	map_c_h = false,									-- Map the <C-h> key to delete a pair
	map_c_w = false,									-- map <c-w> to delete a pair if possible
})

-- If you want insert `(` after select function or method item
-- local cmp_autopairs = require('nvim-autopairs.completion.cmp')
-- require('cmp').event:on(
	-- 'confirm_done',
	-- cmp_autopairs.on_confirm_done()
-- )

local Rule = require('nvim-autopairs.rule')
local ts_conds = require('nvim-autopairs.ts-conds')

-- press % => %% only while inside a comment or string
nvimautopairs.add_rules({
	Rule("%", "%", "lua")
		:with_pair(ts_conds.is_ts_node({'string','comment'})),
	Rule("$", "$", "lua")
		:with_pair(ts_conds.is_not_ts_node({'function'}))
})
