return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		local mason_lspconfig = require("mason-lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }
			end,
		})

		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.HINT] = "󰠠 ",
					[vim.diagnostic.severity.INFO] = " ",
				},
			},
		})

		local function get_python_path()
			local cwd = vim.fn.getcwd()
			for _, venv in ipairs({ ".venv", "venv", "env" }) do
				local python = cwd .. "/" .. venv .. "/bin/python"
				if vim.fn.executable(python) == 1 then
					return python
				end
			end
			return nil
		end

		local servers = {
			lua_ls = {
				cmd = { "lua-language-server" },
				filetypes = { "lua" },
				root_markers = {
					".luarc.json",
					".luarc.jsonc",
					".luacheckrc",
					".stylua.toml",
					"stylua.toml",
					"selene.toml",
					"selene.yml",
					"init.lua",
					".git",
				},
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
						completion = {
							callSnippet = "Replace",
						},
					},
				},
			},
			pyright = {
				settings = {
					python = {
						venvPath = ".",
						venv = ".venv",
						pythonPath = get_python_path(),
						analysis = {
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
							diagnosticMode = "workspace",
							typeCheckingMode = "off",
							diagnosticSeverityOverrides = {
								reportOptionalMemberAccess = false,
							},
						},
					},
				},
			},
			html = {},
			cssls = {},
			-- jdtls = {},
			qmlls = {},
		}

		mason_lspconfig.setup({
			automatic_enable = {
				exclude = { "jdtls" },
			},
			ensure_installed = vim.tbl_keys(servers),
		})

		local capabilities = cmp_nvim_lsp.default_capabilities()

		for server, config in pairs(servers) do
			config.capabilities = capabilities
			vim.lsp.config[server] = config
		end
	end,
}
