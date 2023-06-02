local status, packer = pcall(require, 'packer')
if (not status) then
    print("Packer is not installed")
    return
end


vim.cmd.packadd "packer.nvim"
vim.cmd.colorscheme "catppuccin"

packer.startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'hoob3rt/lualine.nvim' -- Status line
    use 'nvim-lua/plenary.nvim'
    use 'onsails/lspkind-nvim'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/nvim-cmp'
    use 'neovim/nvim-lspconfig' -- LSP config
    use 'jose-elias-alvarez/null-ls.nvim'
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'

    use {
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
        requires = {
            {"nvim-tree/nvim-web-devicons"},
        }
    }
   use 'L3MON4D3/LuaSnip' -- Snipet
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    }
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-file-browser.nvim'
    use 'windwp/nvim-autopairs'
    use 'windwp/nvim-ts-autotag'
    use {
        'numToStr/Comment.nvim',
        requires = {
        {'JoosepAlviste/nvim-ts-context-commentstring'}
        }
    }
    use 'norcalli/nvim-colorizer.lua'
    use 'folke/zen-mode.nvim'
    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    })
    use 'akinsho/nvim-bufferline.lua'
    use 'lewis6991/gitsigns.nvim'
    use 'dinhhuy258/git.nvim'
    use {"catppuccin/nvim", name= "catppuccin"}
end)
