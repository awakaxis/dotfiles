return {
    "folke/which-key.nvim",
    even = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 500
    end,
    opts = {
        -- default conf
    }
}
