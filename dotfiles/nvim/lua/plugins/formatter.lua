return {
    {
        'mhartington/formatter.nvim',
        opts = {
            logging = true,
            log_level = vim.log.levels.WARN,
        },
        config = function()
            require("formatter").setup({
                filetype = {
                    lua = {
                        require("formatter.filetypes.lua").stylua,
                    },
                    go = {
                        require("formatter.filetypes.go").gofumpt,
                    },
                },
            })
        end
    }
}
