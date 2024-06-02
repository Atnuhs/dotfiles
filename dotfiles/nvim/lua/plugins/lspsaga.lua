vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.keymap.set("n", "gh", "<cmd>Lspsaga lsp_finder<CR>")
    -- vim.keymap.set("n", "gh", "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>")
    vim.keymap.set({"n", "v"}, "<leader>ca", "<cmd>Lspsaga code_action<CR>")
    vim.keymap.set("n", "gr", "<cmd>Lspsaga rename<CR>")
    -- vim.keymap.set("n", "gr", "<cmd>Lspsaga rename ++project<CR>")
    vim.keymap.set("n", "gp", "<cmd>Lspsaga peek_definition<CR>")
    vim.keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>")
    vim.keymap.set("n", "gt", "<cmd>Lspsaga peek_type_definition<CR>")
    -- vim.keymap.set("n", "gt", "<cmd>Lspsaga goto_type_definition<CR>")
    -- Show line diagnostics
    vim.keymap.set("n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>")
    vim.keymap.set("n", "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>")
    vim.keymap.set("n", "<leader>sw", "<cmd>Lspsaga show_workspace_diagnostics<CR>")
    vim.keymap.set("n", "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>")
    -- Diagnostic jump
    vim.keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
    vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>")
    vim.keymap.set("n", "[E", function()
      require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
    end)
    vim.keymap.set("n", "]E", function()
      require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
    end)
    -- Toggle outline
    vim.keymap.set("n","<leader>o", "<cmd>Lspsaga outline<CR>")
    -- Hover Doc
    -- vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc <CR>")
    vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc ++keep<CR>")
    -- Call hierarchy
    vim.keymap.set("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>")
    vim.keymap.set("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>")
    -- Floating terminal
    vim.keymap.set({"n", "t"}, "<A-d>", "<cmd>Lspsaga term_toggle<CR>")

  end,
})

return {
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
}
