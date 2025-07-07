return {
	"f4z3r/gruvbox-material.nvim",
	priority = 1000,
	config = function()
		vim.cmd("colorscheme gruvbox-material")

		require("gruvbox-material").setup({
			contrast = "medium",
		})

		vim.cmd.hi("Pmenu", "guibg=#322d2a")
		vim.cmd.hi("Normal", "guibg=none")
		vim.cmd.hi("NonText", "guibg=none")
		vim.cmd.hi("EndOfBuffer", "guibg=none")
		vim.cmd.hi("NormalFloat", "guibg=none")

		vim.api.nvim_set_hl(0, "@variable", { link = "GruvboxFg1" })
		vim.api.nvim_set_hl(0, "@variable.member", { link = "GruvboxFg1" })
		vim.api.nvim_set_hl(0, "@function.method.call", { link = "Green" })
		vim.api.nvim_set_hl(0, "@constant.builtin", { link = "Red" })
		vim.api.nvim_set_hl(0, "@constant", { link = "Purple" })
		vim.api.nvim_set_hl(0, "@variable.parameter", { link = "GruvboxFg1" })
		vim.api.nvim_set_hl(0, "@type", { link = "Yellow" })
		vim.api.nvim_set_hl(0, "@type.builtin", { link = "Red" })
		vim.api.nvim_set_hl(0, "@operator", { link = "GruvboxFg1" })
		vim.api.nvim_set_hl(0, "@module", { link = "GruvboxFg1" })

		-- bufferline
		vim.api.nvim_set_hl(0, "BufferLineSeparator", { fg = "#282828", bg = "none" })
		vim.api.nvim_set_hl(0, "BufferLineFill", { fg = "fg", bg = "#282828" })
		vim.api.nvim_set_hl(0, "TabLineFill", { fg = "fg", bg = "#282828" })

		-- java
		vim.api.nvim_set_hl(0, "@type.java", { link = "Type" })
		vim.api.nvim_set_hl(0, "@constant.java", { link = "Purple" })
		vim.api.nvim_set_hl(0, "@lsp.type.modifier.java", { link = "Red" })
		vim.api.nvim_set_hl(0, "@lsp.type.class.java", { link = "Type" })
		vim.api.nvim_set_hl(0, "@lsp.typemod.property.readonly.java", { link = "Purple" })
		vim.api.nvim_set_hl(0, "@lsp.type.interface.java", { link = "Type" })
		vim.api.nvim_set_hl(0, "@lsp.type.property.java", { link = "GruvboxFg1" })
	end,
}
