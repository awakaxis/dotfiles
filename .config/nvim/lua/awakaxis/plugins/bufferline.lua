return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	version = "*",
	opts = {
		options = {
			mode = "tabs",
			separator_style = "thick",
			indicator = {
				style = "underline",
			},
			max_name_length = 30,
			-- diagnostics = "nvim_lsp",
			-- diagnostics_indicator = function(count, level, diagnostics_dict, context)
			-- 	local icon = level:match("error") and " " or " "
			-- 	return " " .. icon .. count
			-- end,
			custom_areas = {
				right = function()
					local result = {}
					local seve = vim.diagnostic.severity
					local error = #vim.diagnostic.get(0, { severity = seve.ERROR })
					local warning = #vim.diagnostic.get(0, { severity = seve.WARN })
					local info = #vim.diagnostic.get(0, { severity = seve.INFO })
					local hint = #vim.diagnostic.get(0, { severity = seve.HINT })

					if error ~= 0 then
						table.insert(result, { text = "  " .. error, link = "DiagnosticError" })
					end

					if warning ~= 0 then
						table.insert(result, { text = "  " .. warning, link = "DiagnosticWarn" })
					end

					if hint ~= 0 then
						table.insert(result, { text = "  " .. hint, link = "DiagnosticHint" })
					end

					if info ~= 0 then
						table.insert(result, { text = "  " .. info, link = "DiagnosticInfo" })
					end
					return result
				end,
			},
		},
	},
}
