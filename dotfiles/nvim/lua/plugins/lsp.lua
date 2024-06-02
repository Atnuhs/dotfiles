vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = {only = {"source.organizeImports"}}
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
    vim.lsp.buf.format({async = false})
  end
})

vim.o.completeopt = "menuone,noinsert,noselect"
vim.api.nvim_set_hl(0, "CmpItemKind", {default = true, link = 'CmpItemMenuDefault'})

return {
    {
        'neovim/nvim-lspconfig', -- LSP config
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
        },
        config = function()
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    }
                }
            })

            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",

                    -- go
                    "gopls",
                    "golangci_lint_ls",

                    -- TS
                    "tsserver",
                }
            })
            require("mason-lspconfig").setup_handlers({
                function(server_name)
                    require("lspconfig")[server_name].setup({
                        -- on_attach = function(_, bufnr)
                        --     vim.api.nvim_buf_set_option(bufnr, "formatexpr",
                        --     "v:lua.vim.lsp.formatexpr(#{timeout_ms:250})")
                        -- end,
                        capabilities = require('cmp_nvim_lsp').default_capabilities(),
                    })
                end,
            })
            vim.cmd("LspStart")

            require("lspconfig").lua_ls.setup {
                -- capabilities = capabilities,
                settings = {
                    Lua = {
                        runtime = {
                            version = 'LuaJIT',
                        },
                        diagnostics = {
                            -- Get the language server tot recognize the 'vim' global
                            globals = { 'vim' },
                        },
                        workspace = {
                            -- Mak the server aware of Neovim runtime files
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false
                        },
                        telemetry = {
                            enable = false
                        },
                    }
                },
            }
        end
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-nvim-lsp',
            'onsails/lspkind.nvim',
        },
        config = function()
            local cmp = require("cmp")
            local map = cmp.mapping
            cmp.setup({
                mapping = map.preset.insert({
                    ['<C-u>'] = map.scroll_docs(-4),
                    ['<C-d>'] = map.scroll_docs(4),
                    ['<C-Space>'] = map.complete(),
                    ['<C-e>'] = map.close(),
                    ['<CR>'] = map.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true
                    }),
                }),
                sources = cmp.config.sources({
                     { name = 'nvim_lsp' },
                     { name = 'buffer' },
                }),
                formatting = {
                    format = require("lspkind").cmp_format({ with_text = false, maxwidth = 50 })
                }
            })
        end,
    },
}

