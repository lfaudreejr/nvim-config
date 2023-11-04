return {
	{
		"nvim-tree/nvim-web-devicons",
		dependencies = { "DaikyXendo/nvim-material-icon" },
		config = function()
      local devicons = require("nvim-web-devicons")
      local material_icon = require("nvim-material-icon")

      devicons.setup({
        override = material_icon.get_icons(),
      })
		end,
	},
	{ "yamatsum/nvim-nonicons", config = true, enabled = true },
}
