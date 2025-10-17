return {
	"rmagatti/auto-session",
	config = function()
		local auto_session = require("auto-session")

		auto_session.setup({
			auto_restore_enabled = false,
			auto_session_supres_dirs = {},
		})

		local map = vim.keymap

		map.set("n", "<leader>wr", function()
			vim.cmd.AutoSession("restore")
		end, { desc = "Restore session for cwd" })
		map.set("n", "<leader>ws", function()
			vim.cmd.AutoSession("save")
		end, { desc = "Save session for auto session root dir" })
	end,
}
