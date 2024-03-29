local lazy = {}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

lazy.opts = {
	defaults = { lazy = false, version = nil },
	install = { missing = true },
	checker = { enabled = true },
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
}

function lazy.install(path)
	if not vim.loop.fs_stat(path) then
		print("Installing lazy.nvim....")
		vim.fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			"https://github.com/folke/lazy.nvim.git",
			"--branch=stable", -- latest stable release
			path,
		})
	end
end

function lazy.setup()
	-- You can "comment out" the line below after lazy.nvim is installed
	lazy.install(lazypath)

	vim.opt.rtp:prepend(lazypath)
	--require("colors.customlight").setup()
	--require("colors.base16").setup()
	require("lazy").setup("plugins", lazy.opts)
end

return lazy
