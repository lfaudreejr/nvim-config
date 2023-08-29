local P = { "kevinhwang91/nvim-ufo" }

P.dependencies = {
	"kevinhwang91/promise-async",
	"neovim/nvim-lspconfig",
	{
		"luukvbaal/statuscol.nvim",
		config = function()
			local builtin = require("statuscol.builtin")
			require("statuscol").setup({
				relculright = true,
				segments = {
					{ text = { builtin.foldfunc }, click = "v:lua.ScFa" },
					{ text = { "%s" }, click = "v:lua.ScSa" },
					{ text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
				},
			})
		end,
	},
}

P.keys = {
	{
		"zR",
		function()
			require("ufo").openAllFolds()
		end,
		desc = "Open All Folds",
	},
	{
		"zM",
		function()
			require("ufo").closeAllFolds()
		end,
		desc = "Close All Folds",
	},
}

function P.config()
	require('ufo').setup({
    provider_selector = function(bufnr, filetype, buftype)
        return {'treesitter', 'indent'}
    end
})
end

return P
