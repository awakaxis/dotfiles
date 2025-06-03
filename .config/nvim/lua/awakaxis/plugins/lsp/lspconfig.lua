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

		local map = vim.keymap

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }

				opts.desc = "Show LSP references"
				map.set("n", "gR", function()
					require("snacks.picker").lsp_references()
				end, opts)

				opts.desc = "Go to declaration"
				map.set("n", "gD", vim.lsp.buf.declaration, opts)

				opts.desc = "Show LSP definitions"
				map.set("n", "gd", function()
					require("snacks.picker").lsp_definitions()
				end, opts)

				opts.desc = "Show LSP implementations"
				map.set("n", "gi", function()
					require("snacks.picker").lsp_implementations()
				end, opts)

				opts.desc = "Show LSP type definitions"
				map.set("n", "gt", function()
					require("snacks.picker").lsp_type_definitions()
				end, opts)

				opts.desc = "See available code actions"
				map.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

				opts.desc = "Smart rename"
				map.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

				opts.desc = "Show buffer diagnostics"
				map.set("n", "<leader>DD", function()
					require("snacks.picker").diagnostics_buffer()
				end, opts)

				opts.desc = "Show line diagnostics"
				map.set("n", "<leader>D", vim.diagnostic.open_float, opts)

				opts.desc = "Go to previous diagnostic"
				map.set("n", "[d", vim.diagnostic.goto_prev, opts)

				opts.desc = "Go to next diagnostic"
				map.set("n", "]d", vim.diagnostic.goto_next, opts)

				opts.desc = "Show documentation for what is under cursor"
				map.set("n", "K", vim.lsp.buf.hover, opts)

				opts.desc = "Restart LSP"
				map.set("n", "<leader>rs", ":LspRestart<CR>", opts)
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
						},
					},
				},
			},
			html = {},
			cssls = {},
		}

		mason_lspconfig.setup({
			ensure_installed = vim.tbl_keys(servers),
		})

		local capabilities = cmp_nvim_lsp.default_capabilities()

		for server, config in pairs(servers) do
			config.capabilities = capabilities
			vim.lsp.config[server] = config
		end
	end,
}
