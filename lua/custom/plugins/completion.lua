local has_words_before = function()
	-- was vim.api.nvim_buf_get_option
	-- if vim.api.nvim_buf_get_option_value(0, "buftype") == "prompt" then
	if vim.api.nvim_get_option_value("buftype", { buf = 0 }) == "prompt" then
		return false
	end
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end

return {
	{
		"saghen/blink.cmp",
		-- optional: provides snippets for the snippet source
		dependencies = {
			"rafamadriz/friendly-snippets",
			"giuxtaposition/blink-cmp-copilot",
			"mikavilpas/blink-ripgrep.nvim",
		},

		-- use a release tag to download pre-built binaries
		version = "v0.*",
		-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
		-- build = 'cargo build --release',
		-- If you use nix, you can build from source using latest nightly rust with:
		-- build = 'nix run .#build-plugin',

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			-- 'default' for mappings similar to built-in completion
			-- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
			-- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
			-- see the "default configuration" section below for full documentation on how to define
			-- your own keymap.
			keymap = {
				preset = "default",
				["<C-k>"] = { "select_prev", "fallback" },
				["<C-j>"] = { "select_next", "fallback" },
				["<c-g>"] = {
					function()
						-- invoke manually, requires blink >v0.7.6
						require("blink-cmp").show({ sources = { "ripgrep" } })
					end,
				},
			},

			appearance = {
				-- Sets the fallback highlight groups to nvim-cmp's highlight groups
				-- Useful for when your theme doesn't support blink.cmp
				-- will be removed in a future release
				use_nvim_cmp_as_default = true,
				-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = "mono",
				kind_icons = {
					Copilot = "",
					Text = "󰉿",
					Method = "󰊕",
					Function = "󰊕",
					Constructor = "󰒓",

					Field = "󰜢",
					Variable = "󰆦",
					Property = "󰖷",

					Class = "󱡠",
					Interface = "󱡠",
					Struct = "󱡠",
					Module = "󰅩",

					Unit = "󰪚",
					Value = "󰦨",
					Enum = "󰦨",
					EnumMember = "󰦨",

					Keyword = "󰻾",
					Constant = "󰏿",

					Snippet = "󱄽",
					Color = "󰏘",
					File = "󰈔",
					Reference = "󰬲",
					Folder = "󰉋",
					Event = "󱐋",
					Operator = "󰪚",
					TypeParameter = "󰬛",
				},
			},

			-- default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = {
				completion = {
					enabled_providers = { "lsp", "path", "snippets", "buffer", "ripgrep", "copilot" },
				},
				-- optionally disable cmdline completions
				-- cmdline = {},
				providers = {
					copilot = {
						name = "copilot",
						module = "blink-cmp-copilot",
						score_offset = 100,
						async = true,
						transform_items = function(_, items)
							local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
							local kind_idx = #CompletionItemKind + 1
							CompletionItemKind[kind_idx] = "Copilot"
							for _, item in ipairs(items) do
								item.kind = kind_idx
							end
							return items
						end,
					},
					ripgrep = {
						module = "blink-ripgrep",
						name = "Ripgrep",
						-- the options below are optional, some default values are shown
						---@module "blink-ripgrep"
						---@type blink-ripgrep.Options
						opts = {
							-- For many options, see `rg --help` for an exact description of
							-- the values that ripgrep expects.

							-- the minimum length of the current word to start searching
							-- (if the word is shorter than this, the search will not start)
							prefix_min_len = 3,

							-- The number of lines to show around each match in the preview
							-- (documentation) window. For example, 5 means to show 5 lines
							-- before, then the match, and another 5 lines after the match.
							context_size = 5,

							-- The maximum file size of a file that ripgrep should include in
							-- its search. Useful when your project contains large files that
							-- might cause performance issues.
							-- Examples:
							-- "1024" (bytes by default), "200K", "1M", "1G", which will
							-- exclude files larger than that size.
							max_filesize = "1M",

							-- (advanced) Any additional options you want to give to ripgrep.
							-- See `rg -h` for a list of all available options. Might be
							-- helpful in adjusting performance in specific situations.
							-- If you have an idea for a default, please open an issue!
							--
							-- Not everything will work (obviously).
							additional_rg_options = {},
						},
					},
				},
			},

			-- experimental signature help support
			-- signature = { enabled = true }
		},
		-- allows extending the providers array elsewhere in your config
		-- without having to redefine it
		opts_extend = { "sources.default" },
	},
	-- { -- Autocompletion
	-- 	"hrsh7th/nvim-cmp",
	-- 	event = "InsertEnter",
	-- 	dependencies = {
	-- 		-- Snippet Engine & its associated nvim-cmp source
	-- 		{
	-- 			"L3MON4D3/LuaSnip",
	-- 			build = (function()
	-- 				-- Build Step is needed for regex support in snippets
	-- 				-- This step is not supported in many windows environments
	-- 				-- Remove the below condition to re-enable on windows
	-- 				if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
	-- 					return
	-- 				end
	-- 				return "make install_jsregexp"
	-- 			end)(),
	-- 		},
	-- 		"saadparwaiz1/cmp_luasnip",
	--
	-- 		-- Adds other completion capabilities.
	-- 		--  nvim-cmp does not ship with all sources by default. They are split
	-- 		--  into multiple repos for maintenance purposes.
	-- 		"hrsh7th/cmp-nvim-lsp",
	-- 		"hrsh7th/cmp-path",
	-- 		"hrsh7th/cmp-buffer",
	-- 		"hrsh7th/cmp-cmdline",
	--
	-- 		-- If you want to add a bunch of pre-configured snippets,
	-- 		--    you can use this plugin to help you. It even has snippets
	-- 		--    for various frameworks/libraries/etc. but you will have to
	-- 		--    set up the ones that are useful for you.
	-- 		-- 'rafamadriz/friendly-snippets',
	-- 	},
	-- 	config = function()
	-- 		-- See `:help cmp`
	-- 		local cmp = require("cmp")
	-- 		local luasnip = require("luasnip")
	-- 		luasnip.config.setup({})
	--
	-- 		local neogen = require("neogen")
	--
	-- 		cmp.setup({
	-- 			snippet = {
	-- 				expand = function(args)
	-- 					luasnip.lsp_expand(args.body)
	-- 				end,
	-- 			},
	-- 			completion = { completeopt = "menu,menuone,noinsert" },
	-- 			formatting = {
	-- 				fields = { "abbr", "menu", "kind" },
	-- 				format = require("lspkind").cmp_format({
	-- 					mode = "symbol_text",
	-- 					maxwidth = 50,
	-- 					ellipsis_char = "...",
	-- 					menu = {
	-- 						buffer = "[BUF]",
	-- 						nvim_lsp = "[LSP]",
	-- 						nvim_lua = "[LUA]",
	-- 						path = "[PATH]",
	-- 						luasnip = "[SNIP]",
	-- 					},
	-- 					before = function(entry, vim_item)
	-- 						vim_item = require("tailwindcss-colorizer-cmp").formatter(entry, vim_item)
	-- 						return vim_item
	-- 					end,
	-- 				}),
	-- 			},
	--
	-- 			-- For an understanding of why these mappings were
	-- 			-- chosen, you will need to read `:help ins-completion`
	-- 			--
	-- 			-- No, but seriously. Please read `:help ins-completion`, it is really good!
	-- 			mapping = cmp.mapping.preset.insert({
	-- 				-- Select the [n]ext item
	-- 				-- ["<C-j>"] = cmp.mapping.select_next_item(),
	-- 				-- Select the [p]revious item
	-- 				-- ["<C-k>"] = cmp.mapping.select_prev_item(),
	-- 				["<C-j>"] = cmp.mapping(function(fallback)
	-- 					if cmp.visible() then
	-- 						cmp.select_next_item()
	-- 					elseif luasnip.expand_or_jumpable() then
	-- 						luasnip.expand_or_jump()
	-- 					elseif neogen.jumpable() then
	-- 						neogen.jump_next()
	-- 					elseif has_words_before() then
	-- 						cmp.complete()
	-- 					else
	-- 						fallback()
	-- 					end
	-- 				end, { "i", "s", "c" }),
	-- 				["<C-k>"] = cmp.mapping(function(fallback)
	-- 					if cmp.visible() then
	-- 						cmp.select_prev_item()
	-- 					elseif luasnip.jumpable(-1) then
	-- 						luasnip.jump(-1)
	-- 					elseif neogen.jumpable(1) then
	-- 						neogen.jump_prev()
	-- 					else
	-- 						fallback()
	-- 					end
	-- 				end, { "i", "s", "c" }),
	--
	-- 				-- Accept ([y]es) the completion.
	-- 				--  This will auto-import if your LSP supports it.
	-- 				--  This will expand snippets if the LSP sent a snippet.
	-- 				["<C-y>"] = cmp.mapping.confirm({ select = true }),
	--
	-- 				-- Manually trigger a completion from nvim-cmp.
	-- 				--  Generally you don't need this, because nvim-cmp will display
	-- 				--  completions whenever it has completion options available.
	-- 				["<C-Space>"] = cmp.mapping.complete({}),
	--
	-- 				-- Think of <c-l> as moving to the right of your snippet expansion.
	-- 				--  So if you have a snippet that's like:
	-- 				--  function $name($args)
	-- 				--    $body
	-- 				--  end
	-- 				--
	-- 				-- <c-l> will move you to the right of each of the expansion locations.
	-- 				-- <c-h> is similar, except moving you backwards.
	-- 				["<C-l>"] = cmp.mapping(function()
	-- 					if luasnip.expand_or_locally_jumpable() then
	-- 						luasnip.expand_or_jump()
	-- 					end
	-- 				end, { "i", "s" }),
	-- 				["<C-h>"] = cmp.mapping(function()
	-- 					if luasnip.locally_jumpable(-1) then
	-- 						luasnip.jump(-1)
	-- 					end
	-- 				end, { "i", "s" }),
	-- 			}),
	-- 			sources = {
	-- 				{ name = "nvim_lsp" },
	-- 				{ name = "luasnip" },
	-- 				{ name = "path" },
	-- 				{ name = "copilot" },
	-- 			},
	-- 			window = {
	-- 				completion = {
	-- 					border = "rounded",
	-- 					winhighlight = "Normal:CmpNormal"
	-- 				}
	-- 			}
	-- 		})
	-- 		-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
	-- 		cmp.setup.cmdline({ "/", "?" }, {
	-- 			mapping = cmp.mapping.preset.cmdline(),
	-- 			sources = { {
	-- 				name = "buffer",
	-- 			} },
	-- 		})
	-- 		-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
	-- 		cmp.setup.cmdline(":", {
	-- 			mapping = cmp.mapping.preset.cmdline(),
	-- 			sources = cmp.config.sources({ {
	-- 				name = "path",
	-- 			} }, { {
	-- 				name = "cmdline",
	-- 			} }),
	-- 		})
	-- 	end,
	-- },
	{
		"roobert/tailwindcss-colorizer-cmp.nvim",
		-- optionally, override the default options:
		config = function()
			require("tailwindcss-colorizer-cmp").setup({
				color_square_width = 2,
			})
		end,
	},
}
