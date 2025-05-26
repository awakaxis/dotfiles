return {
	"f4z3r/gruvbox-material.nvim",
	priority = 1000,
	config = function()
		vim.cmd("colorscheme gruvbox-material")

		require("gruvbox-material").setup({
			contrast = "hard",
			background = {
				transparent = true,
			},
		})
	end,
}
