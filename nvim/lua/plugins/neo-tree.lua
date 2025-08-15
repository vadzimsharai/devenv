return {
	"nvim-neo-tree/neo-tree.nvim",
	opts = {
		filesystem = {
			filtered_items = {
				visible = true,
				hide_dotfiles = false,
				hide_gitignored = false,
				hide_by_name = { ".DS_Store", "thumbs.db" },
				never_show = { ".git", ".hg", ".svn" },
			},
		},
		window = {
			position = "float",
			popup = { -- settings that apply to float position only
				size = { height = "45", width = "150" },
				position = "50%", -- 50% means center it
			},

			mappings = {
				["<leader>]"] = "next_source",
				["<leader>["] = "prev_source",
			},
		},
	},
}
