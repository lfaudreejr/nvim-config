local M = {}

function M.setup()
	local status_ok, chatgpt = pcall(require, "chatgpt")
	if not status_ok then
		return nil
	end

	chatgpt.setup({ api_host_cmd = "echo -n 'api.openai.com'" })
end

return M
