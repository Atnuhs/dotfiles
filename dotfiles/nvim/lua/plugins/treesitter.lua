return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		init = function(plugin)
			require("lazy.core.loader").add_to_rtp(plugin)
			require("nvim-treesitter.query_predicates")
		end,
		main = "nvim-treesitter.configs",
		opts = {
			sync_install = true,
			auto_install = true,
			highlight = {
				enable = true,
				disable = {},
			},
			indent = {
				enable = true,
				disable = {},
			},
			ensure_installed = {
				"bash",
				"fish",
				"json",
				"yaml",
				"css",
				"html",
				"lua",
				"javascript",
				"fortran",
				"go",
				"python",
				"markdown",
				"markdown_inline",
			},
			autotag = {
				enable = true,
			},
		},
	},
}
