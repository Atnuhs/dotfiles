-- bootstrap of lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
require("lazy").setup("plugins")

-- require("lazy").setup({
--     'nvimtools/none-ls.nvim',
--     {
--         "jay-babu/mason-null-ls.nvim",
--         event = { "BufReadPre", "BufNewFile" },
--         dependencies = {
--             "williamboman/mason.nvim",
--             'nvimtools/none-ls.nvim',
--         },
--     },
--     {
--         'glepnir/lspsaga.nvim',
--         branch = "main",
--         event = "LspAttach",
--         config = function()
--             require('lspsaga').setup({
--                 ui = {
--                     winblend = 10,
--                     border = 'rounded',
--                     colors = {
--                         normal_bg = "#002b36"
--                     }
--                 }
--             })
--         end,
--         dependencies = {
--             { "nvim-tree/nvim-web-devicons" },
--         }
--     },
--     'L3MON4D3/LuaSnip', -- Snipet
--     {
--         'nvim-teesitter/nvim-treesitter',
--         init = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
--     },
--     {
--         'nvim-telescope/telescope.nvim',
--         dependencies = {'nvim-lua/plenary.nvim'},
--     },
--     'nvim-telescope/telescope-file-browser.nvim',
--     'windwp/nvim-autopairs',
--     'windwp/nvim-ts-autotag',
--     'norcalli/nvim-colorizer.lua',
--     {
--         "iamcco/markdown-preview.nvim",
--         cmd = {
--             "MarkdownPreviewToggle",
--             "MarkdownPreview",
--             "MarkdownPreviewStop",
--         },
--         ft = { "markdown" },
--         build = function() vim.fn["mkdp#util#install"]() end,
--     },
--     'akinsho/nvim-bufferline.lua',
--     'lewis6991/gitsigns.nvim',
--     'dinhhuy258/git.nvim',
--     {
--         "catppuccin/nvim",
--         name = "catppuccin",
--         priority = 1000,
--     },
-- })
