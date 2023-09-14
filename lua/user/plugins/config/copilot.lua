local M = {}

function M.setup()
	local status_ok, copilot = pcall(require, "copilot")
	if not status_ok then
		return nil
	end

	local opts = {
    suggestion = { enabled = false },
    panel = { enabled = false },
    filetypes = {
      help = false,
			gitcommit = false,
			gitrebase = false,
			hgcommit = false,
			svn = false,
			cvs = false,
      ["*"] = true
    }
  }

	copilot.setup(opts)
end

return M
