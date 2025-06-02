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

		vim.api.nvim_set_hl(0, "@variable.python", { link = "GruvboxFg1" })
		vim.api.nvim_set_hl(0, "@variable.member.python", { link = "GruvboxFg1" })
		vim.api.nvim_set_hl(0, "@function.method.call.python", { link = "Green" })
		vim.api.nvim_set_hl(0, "@constant.builtin.python", { link = "Red" })
		vim.api.nvim_set_hl(0, "@constant.python", { link = "GruvboxFg1" })
		vim.api.nvim_set_hl(0, "@variable.parameter.python", { link = "GruvboxFg1" })
		vim.api.nvim_set_hl(0, "@type.python", { link = "Green" })
		vim.api.nvim_set_hl(0, "@type.builtin.python", { link = "Red" })
		vim.api.nvim_set_hl(0, "@operator.python", { link = "GruvboxFg1" })
		vim.api.nvim_set_hl(0, "@module.python", { link = "GruvboxFg1" })
	end,
}
