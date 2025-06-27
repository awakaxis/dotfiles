--vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.nu = true
opt.rnu = true

opt.termguicolors = true
opt.signcolumn = "yes"

opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

opt.smartindent = true

opt.wrap = false

-- ignore case when searching unless using caps
opt.ignorecase = true
opt.smartcase = true

opt.cursorline = true

opt.backspace = "indent,eol,start"

opt.splitright = true
opt.splitbelow = true

opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

opt.incsearch = true

opt.scrolloff = 8

opt.isfname:append("@-@")

opt.updatetime = 50

opt.colorcolumn = "80"

vim.api.nvim_create_user_command("Redir", function(ctx)
	-- vim.cmd("redir => g:__capture_output | silent ! " .. ctx.args .. " | redir END")
	vim.cmd("redir => g:__capture_output")
	vim.cmd("silent! " .. ctx.args)
	vim.cmd("redir END")
	local lines = vim.split(vim.g.__capture_output or "", "\n")
	vim.cmd("new")
	vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
	vim.opt_local.modified = false
end, { nargs = "+", complete = "command" })

function _G.dump_windows()
	local table = {}
	for i, window in ipairs(vim.api.nvim_list_wins()) do
		local buffer = vim.api.nvim_win_get_buf(window)
		local buffer_name = vim.api.nvim_buf_get_name(buffer)
		local buffer_ft = vim.api.nvim_get_option_value("filetype", { buf = buffer })
		local buffer_type = vim.api.nvim_get_option_value("buftype", { buf = buffer })

		table[window] = {
			name = buffer_name,
			ft = buffer_ft,
			type = buffer_type,
		}
	end
	print(vim.inspect(table))
	return table
end
