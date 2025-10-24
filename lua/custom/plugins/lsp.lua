return {
	{ -- LSP Configuration using native vim.lsp.config API
		"williamboman/mason.nvim",
		version = "1.11.0",
		dependencies = {
			-- Useful status updates for LSP.
			{ "j-hui/fidget.nvim", opts = {} },
		},
		config = function()
			-- Brief Aside: **What is LSP?**
			--
			-- LSP is an acronym you've probably heard, but might not understand what it is.
			--
			-- LSP stands for Language Server Protocol. It's a protocol that helps editors
			-- and language tooling communicate in a standardized fashion.
			--
			-- In general, you have a "server" which is some tool built to understand a particular
			-- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc). These Language Servers
			-- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
			-- processes that communicate with some "client" - in this case, Neovim!
			--
			-- LSP provides Neovim with features like:
			--  - Go to definition
			--  - Find references
			--  - Autocompletion
			--  - Symbol Search
			--  - and more!
			--
			-- Thus, Language Servers are external tools that must be installed separately from
			-- Neovim. This is where `mason` and related plugins come into play.
			--
			-- If you're wondering about lsp vs treesitter, you can check out the wonderfully
			-- and elegantly composed help section, `:help lsp-vs-treesitter`

			--  This function gets run when an LSP attaches to a particular buffer.
			--    That is to say, every time a new file is opened that is associated with
			--    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
			--    function will be executed to configure the current buffer
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					-- NOTE: Remember that lua is a real programming language, and as such it is possible
					-- to define small helper and utility functions so you don't have to repeat yourself
					-- many times.
					--
					-- In this case, we create a function that lets us more easily define mappings specific
					-- for LSP related items. It sets the mode, buffer and description for us each time.
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					-- Jump to the definition of the word under your cursor.
					--  This is where a variable was first declared, or where a function is defined, etc.
					--  To jump back, press <C-T>.
					map("gd", function()
						if pcall(require, "telescope.builtin") then
							require("telescope.builtin").lsp_definitions()
						else
							vim.lsp.buf.definition()
						end
					end, "[G]oto [D]efinition")

					-- Find references for the word under your cursor.
					map("gr", function()
						if pcall(require, "telescope.builtin") then
							require("telescope.builtin").lsp_references()
						else
							vim.lsp.buf.references()
						end
					end, "[G]oto [R]eferences")

					-- Jump to the implementation of the word under your cursor.
					--  Useful when your language has ways of declaring types without an actual implementation.
					map("gI", function()
						if pcall(require, "telescope.builtin") then
							require("telescope.builtin").lsp_implementations()
						else
							vim.lsp.buf.implementation()
						end
					end, "[G]oto [I]mplementation")

					-- Jump to the type of the word under your cursor.
					--  Useful when you're not sure what type a variable is and you want to see
					--  the definition of its *type*, not where it was *defined*.
					map("<leader>K", function()
						if pcall(require, "telescope.builtin") then
							require("telescope.builtin").lsp_type_definitions()
						else
							vim.lsp.buf.type_definition()
						end
					end, "Type [D]efinition")

					-- Fuzzy find all the symbols in your current document.
					--  Symbols are things like variables, functions, types, etc.
					map("<leader>ds", function()
						if pcall(require, "telescope.builtin") then
							require("telescope.builtin").lsp_document_symbols()
						else
							vim.lsp.buf.document_symbol()
						end
					end, "[D]ocument [S]ymbols")

					-- Fuzzy find all the symbols in your current workspace
					--  Similar to document symbols, except searches over your whole project.
					map(
						"<leader>ws",
						function()
							if pcall(require, "telescope.builtin") then
								require("telescope.builtin").lsp_dynamic_workspace_symbols()
							else
								vim.lsp.buf.workspace_symbol()
							end
						end,
						"[W]orkspace [S]ymbols"
					)

					-- Rename the variable under your cursor
					--  Most Language Servers support renaming across files, etc.
					map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

					-- Execute a code action, usually your cursor needs to be on top of an error
					-- or a suggestion from your LSP for this to activate.
					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

					-- Opens a popup that displays documentation about the word under your cursor
					--  See `:help K` for why this keymap
					map("K", vim.lsp.buf.hover, "Hover Documentation")

					-- WARN: This is not Goto Definition, this is Goto Declaration.
					--  For example, in C this would take you to the header
					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

					-- The following two autocommands are used to highlight references of the
					-- word under your cursor when your cursor rests there for a little while.
					--    See `:help CursorHold` for information about when this is executed
					--
					-- When you move your cursor, the highlights will be cleared (the second autocommand).
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.server_capabilities.documentHighlightProvider then
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							callback = vim.lsp.buf.clear_references,
						})
					end
				end,
			})

		-- LSP servers and clients are able to communicate to each other what features they support.
		--  By default, Neovim doesn't support everything that is in the LSP Specification.
		--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
		--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			-- Setup Mason for installing LSP servers
			require("mason").setup()

			-- Helper function to find root directory
			local function root_pattern(...)
				local patterns = { ... }
				return function(fname)
					if type(fname) ~= "string" then
						return nil
					end
					local start_path = vim.fs.dirname(fname)
					for _, pattern in ipairs(patterns) do
						if type(pattern) == "string" then
							local found = vim.fs.find(pattern, {
								path = start_path,
								upward = true,
								type = pattern:match("/$") and "directory" or "file",
							})[1]
							if found then
								return vim.fs.dirname(found)
							end
						end
					end
					return nil
				end
			end

		-- LSP server configurations
		local servers = {
			gopls = {
				cmd = { "gopls" },
				filetypes = { "go", "gomod", "gowork", "gotmpl" },
				root_markers = { "go.work", "go.mod", ".git" },
			},
			rust_analyzer = {
				cmd = { "rust-analyzer" },
				filetypes = { "rust" },
				root_markers = { "Cargo.toml", "rust-project.json", ".git" },
			},
			lua_ls = {
				cmd = { "lua-language-server" },
				filetypes = { "lua" },
				root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml", ".git" },
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						workspace = {
							checkThirdParty = false,
							library = {
								"${3rd}/luv/library",
								unpack(vim.api.nvim_get_runtime_file("", true)),
							},
						},
						completion = {
							callSnippet = "Replace",
						},
					},
				},
			},
			ts_ls = {
				cmd = { "typescript-language-server", "--stdio" },
				filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
				root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
				settings = {
					typescript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = true,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
							includeInlayVariableTypeHintsWhenTypeMatchesName = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
						},
					},
					javascript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = true,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
							includeInlayVariableTypeHintsWhenTypeMatchesName = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
						},
					},
				},
			},
		}

		-- Function to start LSP server for a buffer
		local function start_lsp_server(bufnr)
			local filetype = vim.bo[bufnr].filetype
			if not filetype or filetype == "" then
				return
			end

			-- Find matching server for this filetype
			for server_name, config in pairs(servers) do
				for _, ft in ipairs(config.filetypes) do
					if ft == filetype then
						-- Check if server is already running for this buffer
						local existing_clients = vim.lsp.get_clients({ bufnr = bufnr })
						for _, client in ipairs(existing_clients) do
							if client.name == server_name then
								return -- Server already running
							end
						end

						-- Check if server executable exists
						if vim.fn.executable(config.cmd[1]) == 1 then
							-- Start the server
							vim.lsp.start({
								name = server_name,
								cmd = config.cmd,
								filetypes = config.filetypes,
								root_dir = function(filename)
									return root_pattern(unpack(config.root_markers))(filename)
								end,
								capabilities = capabilities,
								settings = config.settings,
								bufnr = bufnr,
							})
							print("Started LSP server:", server_name, "for", filetype)
						else
							print(server_name .. " not found - LSP features will not be available for", filetype)
						end
						return
					end
				end
			end
		end

		-- Start LSP servers when files are opened
		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("lsp-start", { clear = true }),
			callback = function(event)
				start_lsp_server(event.buf)
			end,
		})

		-- Also start for already open buffers
		vim.api.nvim_create_autocmd("VimEnter", {
			group = vim.api.nvim_create_augroup("lsp-start-existing", { clear = true }),
			callback = function()
				for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
					if vim.api.nvim_buf_is_loaded(bufnr) and vim.bo[bufnr].filetype ~= "" then
						start_lsp_server(bufnr)
					end
				end
			end,
		})
		
		-- Debug: Print LSP status
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("debug-lsp-attach", { clear = true }),
			callback = function(event)
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client then
					print("LSP attached:", client.name, "to buffer", event.buf)
				end
			end,
		})
		end,
	},
	{
		"onsails/lspkind.nvim",
	},
}
