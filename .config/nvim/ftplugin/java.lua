-- local config = {
-- 	cmd = { vim.fn.expand("~/.local/share/nvim/mason/bin/jdtls") },
-- 	root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
-- 	settings = {
-- 		java = {
-- 			imports = {
-- 				gradle = {
-- 					wrapper = {
-- 						checksums = {},
-- 					},
-- 				},
-- 			},
-- 		},
-- 	},
-- }

-- JDTLS (Java LSP) configuration
local home = vim.env.HOME -- Get the home directory

local jdtls = require("jdtls")
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = home .. "/jdtls-workspace/" .. project_name

local system_os = ""

-- Determine OS
if vim.fn.has("mac") == 1 then
	system_os = "mac"
elseif vim.fn.has("unix") == 1 then
	system_os = "linux"
elseif vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
	system_os = "win"
else
	print("OS not found, defaulting to 'linux'")
	system_os = "linux"
end

-- Needed for debugging
local bundles = {
	vim.fn.glob(home .. "/.local/share/nvim/mason/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar"),
}

-- Needed for running/debugging unit tests
vim.list_extend(bundles, vim.split(vim.fn.glob(home .. "/.local/share/nvim/mason/share/java-test/*.jar", 1), "\n"))

local config = {
	cmd = {
		home .. "/.local/share/nvim/mason/bin/jdtls",
	},

	root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "pom.xml", "build.gradle" }),

	-- Here you can configure eclipse.jdt.ls specific settings
	-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
	settings = {
		java = {
			-- TODO Replace this with the absolute path to your main java version (JDTLS requires JDK 21 or higher)
			home = "/usr/lib/jvm/java-25-openjdk",
			eclipse = {
				downloadSources = true,
			},
			configuration = {
				updateBuildConfiguration = "interactive",
				-- TODO Update this by adding any runtimes that you need to support your Java projects and removing any that you don't have installed
				-- The runtimes' name parameter needs to match a specific Java execution environments.  See https://github.com/eclipse-jdtls/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request and search "ExecutionEnvironment".
				runtimes = {
					-- {
					-- 	name = "JavaSE-1.8",
					-- 	path = "/usr/lib/jvm/java-8-openjdk-amd64",
					-- },
					-- {
					-- 	name = "JavaSE-11",
					-- 	path = "/usr/lib/jvm/java-11-openjdk-amd64",
					-- },
					-- {
					-- 	name = "JavaSE-17",
					-- 	path = "/usr/lib/jvm/java-17-openjdk-amd64",
					-- },
					-- {
					-- 	name = "JavaSE-19",
					-- 	path = "/usr/lib/jvm/java-19-openjdk-amd64",
					-- },
					{
						name = "JavaSE-21",
						path = "/usr/lib/jvm/java-21-openjdk",
					},
					{
						name = "JavaSE-25",
						path = "/usr/lib/jvm/java-25-openjdk",
					},
				},
			},
			maven = {
				downloadSources = true,
			},
			implementationsCodeLens = {
				enabled = true,
			},
			referencesCodeLens = {
				enabled = true,
			},
			references = {
				includeDecompiledSources = true,
			},
			signatureHelp = { enabled = true },
			format = {
				enabled = true,
				-- Formatting works by default, but you can refer to a specific file/URL if you choose
				-- settings = {
				--   url = "https://github.com/google/styleguide/blob/gh-pages/intellij-java-google-style.xml",
				--   profile = "GoogleStyle",
				-- },
			},
			completion = {
				favoriteStaticMembers = {
					"org.hamcrest.MatcherAssert.assertThat",
					"org.hamcrest.Matchers.*",
					"org.hamcrest.CoreMatchers.*",
					"org.junit.jupiter.api.Assertions.*",
					"java.util.Objects.requireNonNull",
					"java.util.Objects.requireNonNullElse",
					"org.mockito.Mockito.*",
				},
				importOrder = {
					"java",
					"javax",
					"com",
					"org",
				},
			},
			sources = {
				organizeImports = {
					starThreshold = 9999,
					staticStarThreshold = 9999,
				},
			},
			codeGeneration = {
				toString = {
					template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
				},
				useBlocks = true,
			},
		},
	},
	-- Needed for auto-completion with method signatures and placeholders
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	flags = {
		allow_incremental_sync = true,
	},
	init_options = {
		-- References the bundles defined above to support Debugging and Unit Testing
		bundles = bundles,
		extendedClientCapabilities = jdtls.extendedClientCapabilities,
		settings = {
			java = {
				imports = {
					gradle = {
						enabled = true,
						wrapper = {
							enabled = true,
							checksums = {
								{
									sha256 = "7d3a4ac4de1c32b59bc6a4eb8ecb8e612ccd0cf1ae1e99f66902da64df296172",
									allowed = true,
								},
							},
						},
					},
				},
			},
		},
	},
}

-- Needed for debugging
-- config["on_attach"] = function(client, bufnr)
-- 	jdtls.setup_dap({ hotcodereplace = "auto" })
-- 	require("jdtls.dap").setup_dap_main_class_configs()
-- end

jdtls.start_or_attach(config)
