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
