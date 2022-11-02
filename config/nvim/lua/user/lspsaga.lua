local keymap = vim.keymap.set
local saga = require('lspsaga')

-- Example:
local function get_file_name(include_path)
    local file_name = require('lspsaga.symbolwinbar').get_file_name()
    if vim.fn.bufname '%' == '' then return '' end
    if include_path == false then return file_name end
    -- Else if include path: ./lsp/saga.lua -> lsp > saga.lua
    local sep = vim.loop.os_uname().sysname == 'Windows' and '\\' or '/'
    local path_list = vim.split(string.gsub(vim.fn.expand '%:~:.:h', '%%', ''), sep)
    local file_path = ''
    for _, cur in ipairs(path_list) do
        file_path = (cur == '.' or cur == '~') and '' or
		file_path .. cur .. ' ' .. '%#LspSagaWinbarSep#>%*' .. ' %*'
    end
    return file_path .. file_name
end

local function config_winbar_or_statusline()
    local exclude = {
        ['terminal'] = true,
        ['toggleterm'] = true,
        ['prompt'] = true,
        ['NvimTree'] = true,
        ['help'] = true,
    } -- Ignore float windows and exclude filetype
    if vim.api.nvim_win_get_config(0).zindex or exclude[vim.bo.filetype] then
        vim.wo.winbar = ''
    else
        local ok, lspsaga = pcall(require, 'lspsaga.symbolwinbar')
        local sym
        if ok then sym = lspsaga.get_symbol_node() end
        local win_val = ''
		-- set to true to include path
        win_val = get_file_name(false)
        if sym ~= nil then win_val = win_val .. sym end
        vim.wo.winbar = win_val
        -- if work in statusline
        -- vim.wo.stl = win_val
    end
end

local events = { 'BufEnter', 'BufWinEnter', 'CursorMoved' }

vim.api.nvim_create_autocmd(events, {
    pattern = '*',
    callback = function() config_winbar_or_statusline() end,
})

vim.api.nvim_create_autocmd('User', {
	pattern = 'LspsagaUpdateSymbol',
	callback = function() config_winbar_or_statusline() end,
})

saga.init_lsp_saga
{
    border_style = "rounded",
    saga_winblend = 20,
    -- when cursor in saga window you config these to move
    move_in_saga = { prev = '<C-p>',next = '<C-n>'},
    diagnostic_header = { " ", " ", " ", " " },
    -- preview lines of lsp_finder and definition preview
    max_preview_lines = 20,
    -- use emoji lightbulb in default
    code_action_icon = " ",
    -- if true can press number to execute the codeaction in codeaction window
    code_action_num_shortcut = true,
    -- same as nvim-lightbulb but async
    code_action_lightbulb = {
        enable = true,
        enable_in_insert = true,
        cache_code_action = true,
        sign = true,
        update_time = 1000,
        sign_priority = 20,
        virtual_text = true,
    },
    -- finder icons
    finder_icons = {
        def = '  ',
        ref = ' ',
        link = '  ',
    },
    -- finder do lsp request timeout
    -- if your project big enough or your server very slow
    -- you may need to increase this value
    finder_request_timeout = 1500,
    finder_action_keys = {
        open = "o",
        vsplit = "s",
        split = "i",
        tabe = "t",
        quit = "q",
    },
    code_action_keys = {
        quit = "q",
        exec = "<CR>",
    },
    definition_action_keys = {
        edit = '<C-c>o',
        vsplit = '<C-c>v',
        split = '<C-c>i',
        tabe = '<C-c>t',
        quit = 'q',
    },
    rename_action_quit = "<C-c>",
    rename_in_select = true,
    -- show symbols in winbar must nightly
    -- in_custom mean use lspsaga api to get symbols
    -- and set it to your custom winbar or some winbar plugins.
    -- if in_cusomt = true you must set in_enable to false
    symbol_in_winbar = {
        in_custom = true,
        enable = true,
        separator = '  ',
        show_file = true,
        -- define how to customize filename, eg: %:., %
        -- if not set, use default value `%:t`
        -- more information see `vim.fn.expand` or `expand`
        -- ## only valid after set `show_file = true`
        file_formatter = "",
        click_support = false,
    },
    -- show outline
    show_outline = {
        win_position = 'right',
        --set special filetype win that outline window split.like NvimTree neotree
        -- defx, db_ui
        win_with = '',
        win_width = 50,
        auto_enter = true,
        auto_preview = true,
        virt_text = '┃',
        jump_key = 'o',
        -- auto refresh when change buffer
        auto_refresh = true,
    },
    -- custom lsp kind
    -- usage { Field = 'color code'} or {Field = {your icon, your color code}}
    custom_kind = {},
    -- like server_filetype_map = { metals = { "sbt", "scala" } }
    server_filetype_map = {},
}

-- Finder
keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })
-- Code action
keymap({"n","v"}, "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })
-- Rename
keymap("n", "gr", "<cmd>Lspsaga rename<CR>", { silent = true })
-- Peek Definition
keymap("n", "gpd", "<cmd>Lspsaga peek_definition<CR>", { silent = true })
-- Show line diagnostics
keymap("n", "go", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })
-- Show cursor diagnostic
keymap("n", "go", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })
-- Diagnsotic jump can use `<c-o>` to jump back
keymap("n", "gk", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
keymap("n", "gj", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })
-- Only jump to error
keymap("n", "gek", function()
	require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true })
keymap("n", "gej", function()
	require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true })
-- Hover Doc
keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
-- Outline
keymap("n", "gl", "<cmd>WindowsToggleAutowidth<CR><cmd>LSoutlineToggle<CR>",{ silent = true })
