return {
    "folke/todo-comments.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local todo_comments = require("todo-comments")

        local map = vim.keymap
        
        map.set("n", "]t", function()
            todo_comments.jump_next()
        end, { desc = "Goto next todo comment" })

        map.set("n", "[t", function()
            todo_comments.jump_prev()
        end, { desc = "Goto previous todo comment" })

        todo_comments.setup()
    end
}
