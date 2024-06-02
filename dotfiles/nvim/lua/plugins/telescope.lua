return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			defaults = {
				file_ignore_patterns = { "node_modules/", ".git/" },
			},
		},
		keys = {
			{
				";f",
				function()
					require("telescope.builtin").find_files({
						no_ignore = true,
						hidden = true,
					})
				end,
				desc = "Find Plugin File",
			},
			{
				";r",
				function()
					require("telescope.builtin").live_grep()
				end,
				desc = "Live grep File",
			},
			{
				"\\\\",
				function()
					require("telescope.builtin").buffers()
				end,
				desc = "Buffer Files",
			},
			{
				";t",
				function()
					require("telescope.builtin").help_tags()
				end,
				desc = "help tags",
			},
			{
				";;",
				function()
					require("telescope.builtin").resule()
				end,
				desc = "Resume",
			},
			{
				";e",
				function()
					require("telescope.builtin").diagnostics()
				end,
				desc = "Show diagnostics",
			},
		},
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
	},
}
