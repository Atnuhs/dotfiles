local status, lazy = pcall(require, 'lazy')
if (not status) then
    print("lazy is not installed")
    return
end

vim.g.mapleader = " "

lazy.setup({
    'hoob3rt/lualine.nvim', -- Status line
    'nvim-lua/plenary.nvim',
    'onsails/lspkind-nvim',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/nvim-cmp',
    'neovim/nvim-lspconfig', -- LSP config
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'nvimtools/none-ls.nvim',
    {
        "jay-babu/mason-null-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            'nvimtools/none-ls.nvim',
        },
    },
    {
        'glepnir/lspsaga.nvim',
        branch = "main",
        event = "LspAttach",
        config = function()
            require('lspsaga').setup({
                ui = {
                    winblend = 10,
                    border = 'rounded',
                    colors = {
                        normal_bg = "#002b36"
                    }
                }
            })
        end,
        dependencies = {
            { "nvim-tree/nvim-web-devicons" },
        }
    },
    'L3MON4D3/LuaSnip', -- Snipet
    {
        'nvim-treesitter/nvim-treesitter',
        init = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    },
    'nvim-telescope/telescope.nvim',
    'nvim-telescope/telescope-file-browser.nvim',
    'windwp/nvim-autopairs',
    'windwp/nvim-ts-autotag',
    'norcalli/nvim-colorizer.lua',
    {
        "iamcco/markdown-preview.nvim",
        cmd = {
            "MarkdownPreviewToggle",
            "MarkdownPreview",
            "MarkdownPreviewStop",
        },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    },
    'akinsho/nvim-bufferline.lua',
    'lewis6991/gitsigns.nvim',
    'dinhhuy258/git.nvim',
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
    },
})
