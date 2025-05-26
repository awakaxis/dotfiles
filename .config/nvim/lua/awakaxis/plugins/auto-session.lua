return {
    "rmagatti/auto-session",
    config = function()
        local auto_session = require("auto-session")

        auto_session.setup({
            auto_restore_enabled = false,
            auto_session_supres_dirs = { "~/", "~/Dev/", "~/Downloads/", "~/Documents/", "~/Desktop/" }
        })

        local map = vim.keymap

        map.set("n", "<leader>wr", vim.cmd.SessionRestore, { desc = "Restore session for cwd" })
        map.set("n", "<leader>ws", vim.cmd.SessionSave, { desc = "Save session for auto session root dir" })
    end
}
