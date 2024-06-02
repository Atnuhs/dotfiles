return {{
    'petertriho/nvim-scrollbar',
    config = function ()
        require('scrollbar').setup({
            handle = {
                color = 'black',
            }
        })
        require('scrollbar.handlers.search').setup()
        require('scrollbar.handlers.gitsigns').setup()
    end
}}
