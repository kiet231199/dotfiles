local vim = vim
local opt = vim.opt
local g   = vim.g

g.nvim_profile_path = "/data4/kietpham/00_dot/config/"
opt.runtimepath:append(g.nvim_profile_path)
opt.packpath = g.nvim_profile_path

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

require('packer').init({
    ensure_dependencies = true, -- Should packer install plugin dependencies?
    package_root = g.nvim_profile_path .. "pack/",
    compile_path = g.nvim_profile_path .. "pack/packer_compiled.lua",
    plugin_package = 'packer', -- The default package for plugins
    auto_clean = false, -- During sync(), remove unused plugins
    compile_on_sync = true, -- During sync(), run packer.compile()
    disable_commands = false, -- Disable creating commands
    opt_default = false, -- Default to using opt (as opposed to start) plugins
    transitive_opt = true, -- Make dependencies of opt plugins also opt by default
    transitive_disable = false, -- Automatically disable dependencies of disabled plugins
    auto_reload_compiled = true, -- Automatically reload the compiled file after creating it.
    display = {
        non_interactive = false, -- If true, disable display windows for all operations
        compact = false, -- If true, fold updates results by default
        -- open_fn  = nil, -- An optional function to open a window for packer's display
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
        open_cmd = '65vnew \\[packer\\]', -- An optional command to open a window for packer's display
        working_sym = ' ', -- The symbol for a plugin being installed/updated
        error_sym = ' ', -- The symbol for a plugin with an error in installation/updating
        done_sym = ' ', -- The symbol for a plugin which has completed installation/updating
        removed_sym = ' ', -- The symbol for an unused plugin which was removed
        moved_sym = ' ', -- The symbol for a plugin which was moved (e.g. from opt to start)
        header_sym = '━', -- The symbol for the header line in packer's display
        show_all_info = true, -- Should packer show all update details automatically?
        prompt_border = 'rounded', -- Border style of prompt popups.
        keybindings = { -- Keybindings for the display window
            quit = 'q',
            toggle_update = 'u', -- only in preview
            continue = 'c', -- only in preview
            toggle_info = '<CR>',
            diff = 'd',
            prompt_revert = 'r',
        },
    },
    log = { level = 'warn' }, -- The default print log level. One of: "trace", "debug", "info", "warn", "error", "fatal".
    profile = {
        enable = true,
        threshold = 0.01, -- integer in milliseconds, plugins which load faster than this won't be shown in profile output
    },
    autoremove = false, -- Remove disabled or unused plugins without prompting the user
})

