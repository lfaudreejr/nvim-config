vim.g.colors_name = "nvb-local"

local active_scheme = "rose-pine"

local Color = {}

Color.colorschemes = {}

Color.colorschemes["github"] = {
	base00 = "#ffffff",
	base01 = "#f5f5f5",
	base02 = "#c8c8fa",
	base03 = "#969896",
	base04 = "#e8e8e8",
	base05 = "#333333",
	base06 = "#ffffff",
	base07 = "#ffffff",
	base08 = "#ed6a43",
	base09 = "#0086b3",
	base0A = "#795da3",
	base0B = "#183691",
	base0C = "#183691",
	base0D = "#795da3",
	base0E = "#a71d5d",
	base0F = "#333333",
}

Color.colorschemes["google-light"] = {
	base00 = "#ffffff",
	base01 = "#e0e0e0",
	base02 = "#c5c8c6",
	base03 = "#b4b7b4",
	base04 = "#969896",
	base05 = "#373b41",
	base06 = "#282a2e",
	base07 = "#1d1f21",
	base08 = "#cc342b",
	base09 = "#f96a38",
	base0A = "#fba922",
	base0B = "#198844",
	base0C = "#3971ed",
	base0D = "#3971ed",
	base0E = "#a36ac7",
	base0F = "#3971ed",
}

Color.colorschemes["google-dark"] = {
	base00 = "#1d1f21",
	base01 = "#282a2e",
	base02 = "#373b41",
	base03 = "#969896",
	base04 = "#b4b7b4",
	base05 = "#c5c8c6",
	base06 = "#e0e0e0",
	base07 = "#ffffff",
	base08 = "#cc342b",
	base09 = "#f96a38",
	base0A = "#fba922",
	base0B = "#198844",
	base0C = "#3971ed",
	base0D = "#3971ed",
	base0E = "#a36ac7",
	base0F = "#3971ed",
}

Color.colorschemes["schemer-dark"] = {
	base00 = "#16161D",
	base01 = "#3e4451",
	base02 = "#2c313c",
	base03 = "#565c64",
	base04 = "#6c7891",
	base05 = "#abb2bf",
	base06 = "#9a9bb3",
	base07 = "#c5c8e6",
	base08 = "#e06c75",
	base09 = "#d19a66",
	base0A = "#e5c07b",
	base0B = "#98c379",
	base0C = "#56b6c2",
	base0D = "#0184bc",
	base0E = "#c678dd",
	base0F = "#a06949",
}

Color.colorschemes["schemer-medium"] = {
	base00 = "#212226",
	base01 = "#3e4451",
	base02 = "#2c313c",
	base03 = "#565c64",
	base04 = "#6c7891",
	base05 = "#abb2bf",
	base06 = "#9a9bb3",
	base07 = "#c5c8e6",
	base08 = "#a3a3a3",
	base09 = "#d19a66",
	base0A = "#e5c07b",
	base0B = "#98c379",
	base0C = "#56b6c2",
	base0D = "#0184bc",
	base0E = "#c678dd",
	base0F = "#a06949",
}

Color.colorschemes["dracula"] = {
	base00 = "#282936",
	base01 = "#3a3c4e",
	base02 = "#4d4f68",
	base03 = "#626483",
	base04 = "#62d6e8",
	base05 = "#e9e9f4",
	base06 = "#f1f2f8",
	base07 = "#f7f7fb",
	base08 = "#ea51b2",
	base09 = "#b45bcf",
	base0A = "#00f769",
	base0B = "#ebff87",
	base0C = "#a1efe4",
	base0D = "#62d6e8",
	base0E = "#b45bcf",
	base0F = "#00f769",
}

Color.colorschemes["rose-pine"] = {
	base00 = "#191724",
	base01 = "#1f1d2e",
	base02 = "#26233a",
	base03 = "#6e6a86",
	base04 = "#908caa",
	base05 = "#e0def4",
	base06 = "#e0def4",
	base07 = "#524f67",
	base08 = "#eb6f92",
	base09 = "#f6c177",
	base0A = "#ebbcba",
	base0B = "#31748f",
	base0C = "#9ccfd8",
	base0D = "#c4a7e7",
	base0E = "#f6c177",
	base0F = "#524f67",
}

Color.colorschemes["my-light"] = {
	base00 = "#fafafa",
	base01 = "#e5e5e5",
	base02 = "#c5c8c6",
	base03 = "#b4b7b4",
	base04 = "#969896",
	base05 = "#0a0a0a",
	base06 = "#282a2e",
	base07 = "#1d1f21",
	base08 = "#404040",
	base09 = "#f59e0b",
	base0A = "#525252",
	base0B = "#16a34a",
	base0C = "#9333ea",
	base0D = "#2563eb",
	base0E = "#dc2626",
	base0F = "#3971ed",
}

function Color.setup()
	require("colors.base16.maker").setup(Color.colorschemes[active_scheme])
end

return Color
