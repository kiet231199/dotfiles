vim.cmd [[ autocmd BufEnter * :lua require('lazygit.utils').project_root_dir() ]]

local lazygit = {
	lazygit_floating_window_winblend = 0,									-- transparency of floating window
	lazygit_floating_window_scaling_factor = 0.9,							-- scaling factor for floating window
	lazygit_floating_window_corner_chars = {'╭', '╮', '╰', '╯'},			-- customize lazygit popup window corner characters
	lazygit_floating_window_use_plenary = 0, 								-- use plenary.nvim to manage floating window if available
	lazygit_use_neovim_remote = 1,											-- fallback to 0 if neovim-remote is not installed
	lazygit_use_custom_config_file_path = 1,
	lazygit_config_file_path = '/data4/kietpham/00_nvim/config/lazygit/config.yml',
}

for k,v in pairs(lazygit) do
	vim.g[k] = v
end

vim.api.nvim_set_keymap("", "<leader>gg", ":LazyGit<CR>", { noremap = true, silent = true })
