local status_ok, ssr = pcall(require, "ssr")
if not status_ok then
	print("Error: ssr")
	return
end

ssr.setup({
	min_width = 50,
	min_height = 5,
	keymaps = {
		close = "q",
		next_match = "n",
		prev_match = "N",
		replace_all = "<leader><CR>",
	},
})

vim.keymap.set({ "n", "x" }, "<leader>sr", function() require("ssr").open() end)
