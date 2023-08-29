local P = { "jackMort/ChatGPT.nvim" }

P.event = "VeryLazy"
P.cmd = { "ChatGPT", "ChatGPTRun", "ChatGPTActAs", "ChatGPTCompleteCode", "ChatGPTEditWithInstructions" }
P.enabled = true
P.dependencies = {
	"MunifTanjim/nui.nvim",
	"nvim-lua/plenary.nvim",
	"nvim-telescope/telescope.nvim",
}

function P.config()
	require("chatgpt").setup({ api_host_cmd = "echo -n 'api.openai.com'" })
end

return P
