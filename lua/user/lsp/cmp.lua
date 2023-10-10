local CMP = {}

function CMP.setup()
	local status_ok, cmp = pcall(require, "cmp")
	if not status_ok then
		return
	end

	local has_lspkind, lspkind = pcall(require, "lspkind")
	local has_luasnip, luasnip = pcall(require, "luasnip")
	local has_tailwind_colorizer, tailwind_colorizer = pcall(require, "tailwindcss-colorizer-cmp")
	local has_neogen, neogen = pcall(require, "neogen")

	local has_words_before = function()
		if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
			return false
		end
		local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
	end

	require("luasnip.loaders.from_vscode").lazy_load()

	cmp.setup({
		window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},
		formatting = {
			format = function(entry, vim_item)
				if has_tailwind_colorizer then
					vim_item = tailwind_colorizer.formatter(entry, vim_item)
				end

				if has_lspkind then
					vim_item = lspkind.cmp_format({
						mode = "symbol_text", -- show only symbol annotations
						maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
						ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
						symbol_map = { Copilot = "" },

						-- The function below will be called before any actual modifications from lspkind
						-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
						before = function(entry, vim_item)
							return vim_item
						end,
					})(entry, vim_item)
				end

				return vim_item
			end,
		},
		snippet = {
			expand = function(args)
				if has_luasnip then
					luasnip.lsp_expand(args.body)
				end
			end,
		},
		sources = {
			{
				name = "path",
			},
			{
				name = "copilot",
			},
			{
				name = "conjure",
			},
			{
				name = "nvim_lsp",
				keyword_length = 1,
			},
			{
				name = "nvim_lsp_signature_help",
			},
			{
				name = "buffer",
				keyword_length = 3,
			},
			{
				name = "luasnip",
        keyword_length = 2,
			},
		},
		mapping = {
			["<C-Space>"] = cmp.mapping.complete(),
			["<C-f>"] = cmp.mapping.scroll_docs(-4),
			["<C-b>"] = cmp.mapping.scroll_docs(4),
			["<CR>"] = cmp.mapping.confirm({
				-- documentation says this is important.
				-- I don't know why.
				behavior = cmp.ConfirmBehavior.Replace,
				select = false,
			}),
			["<Tab>"] = vim.schedule_wrap(function(fallback)
				if cmp.visible() and has_words_before() then
					cmp.select_next_item({
						behavior = cmp.SelectBehavior.Select,
					})
				else
					fallback()
				end
			end),
			["<C-j>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				elseif has_neogen and neogen.jumpable() then
					neogen.jump_next()
				elseif has_words_before() then
					cmp.complete()
				else
					fallback()
				end
			end, { "i", "s", "c" }),
			["<C-k>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				elseif has_neogen and neogen.jumpable(1) then
					neogen.jump_prev()
				else
					fallback()
				end
			end, { "i", "s", "c" }),
		},
	})

	-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline({ "/", "?" }, {
		mapping = cmp.mapping.preset.cmdline(),
		sources = { {
			name = "buffer",
		} },
	})
	-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline(":", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({ {
			name = "path",
		} }, { {
			name = "cmdline",
		} }),
	})
end

return CMP
