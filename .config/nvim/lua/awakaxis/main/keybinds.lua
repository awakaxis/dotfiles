vim.g.mapleader = " "

local map = vim.keymap

local transparencyFlag = false

local function try_run_project()
	local cwd = vim.fn.getcwd()
	local CMD = "kitty --working-directory %s zsh -ic '%s; read -k1 \"?Press any key to exit...\"'"
	local filename = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())

	if vim.endswith(filename, ".sh") then
		vim.fn.jobstart(string.format(CMD, cwd, filename))
	elseif vim.fn.filereadable(cwd .. "/main.py") == 1 then
		vim.fn.jobstart(string.format(CMD, cwd, "venvpy main.py"))
	elseif vim.fn.filereadable(cwd .. "/build.gradle") == 1 then
		local file = io.open(cwd .. "/build.gradle", "r")
		assert(file ~= nil, "File is nil")
		local content = file:read("*a")
		if content:find("fabric-loom", 1, true) ~= nil then
			vim.fn.jobstart(string.format(CMD, cwd, "./gradlew runClient"))
		else
			vim.notify("bad", vim.log.levels.INFO)
			return
		end
	end
end

function ToggleTransparency()
	local Normal = "#282828"
	local NonText = "#5a524c"
	local EndOfBuffer = "#282828"
	local NormalFloat = "#45403d"

	if transparencyFlag == false then
		vim.cmd.hi("Normal", "guibg=none")
		vim.cmd.hi("NonText", "guibg=none")
		vim.cmd.hi("EndOfBuffer", "guibg=none")
		vim.cmd.hi("NormalFloat", "guibg=none")
	else
		vim.cmd.hi("Normal", "guibg=" .. Normal)
		vim.cmd.hi("NonText", "guibg=" .. NonText)
		vim.cmd.hi("EndOfBuffer", "guibg=" .. EndOfBuffer)
		vim.cmd.hi("NormalFloat", "guibg=" .. NormalFloat)
	end
	transparencyFlag = not transparencyFlag
end

-- PICKER
map.set("n", "<leader>ff", function()
	require("snacks.picker").files({ exclude = { "Documents/custom" } })
end, { desc = "Search for file" })

map.set("n", "<leader>fs", function()
	require("snacks.picker").grep()
end, { desc = "Search for string" })

map.set("n", "<leader>fw", function()
	require("snacks.picker").grep_word()
end, { desc = "Search for selection" })

map.set("v", "<leader>fw", function()
	require("snacks.picker").grep_word()
end, { desc = "Search for selection" })

map.set("n", "<leader>ft", function()
	require("snacks.picker").diagnostics()
end, { desc = "View Todos" })

map.set("n", "<leader>fr", function()
	require("snacks.picker").recent()
end, { desc = "Open recent files" })

map.set("n", "<leader>qf", function()
	require("snacks.picker").qflist()
end, { desc = " Quickfix" })

map.set("n", "<leader>fe", function()
	require("snacks.picker").lsp_workspace_symbols()
end, { desc = "Search Everywhere" })

map.set("n", "<C-q>", function()
	require("snacks.picker.actions").qflist()
end, { desc = "Send to Quickfix" })

map.set("n", "<leader>ee", function()
	require("snacks.explorer").open()
end, { desc = "Open file explorer" })

-- MISCELLANEOUS
map.set("n", "<leader>aa", vim.cmd.Alpha, { desc = "Main Menu" })

map.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Open undotree" })

map.set("n", "<leader>L", vim.cmd.Lazy, { desc = "Open Lazy" })

map.set("n", "<leader>nh", vim.cmd.nohl, { desc = "Clear highlights" })

map.set("n", "<leader>gh", function()
	require("snacks.lazygit").open()
end, { desc = "Open LazyGit" })

map.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection up" })
map.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection down" })

map.set("n", "<leader>y", '"+y', { desc = "Copy to +" })
map.set("v", "<leader>y", '"+y', { desc = "Copy to +" })

map.set("n", "<leader>d", '"_d', { desc = "Delete to void" })
map.set("v", "<leader>d", '"_d', { desc = "Delete to void" })

map.set("n", "<leader>tt", vim.cmd.tabnew, { desc = "Open new tab" })
map.set("n", "<leader>tx", vim.cmd.tabclose, { desc = "Close current tab" })
map.set("n", "<leader>tn", vim.cmd.tabn, { desc = "Go to next tab" })
map.set("n", "<leader>tr", vim.cmd.tabp, { desc = "Go to previous tab" })
map.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

map.set("n", "J", "mzJ`z", { desc = "Keep camera centered" })
map.set("n", "<C-d>", "<C-d>zz", { desc = "Keep camera centered" })
map.set("n", "<C-u>", "<C-u>zz", { desc = "Keep camera centered" })
map.set("n", "n", "nzz", { desc = "Keep camera centered" })
map.set("n", "N", "Nzz", { desc = "Keep camera centered" })

map.set("x", "<leader>p", '"_dP', { desc = "Paste w/o copy" })

map.set("n", "<leader><CR>", try_run_project, { desc = "Try to run the current project if applicable" })

map.set("n", "<leader>tp", ToggleTransparency, { desc = "Toggle background transparency" })
