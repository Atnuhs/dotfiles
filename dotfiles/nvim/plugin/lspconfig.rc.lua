local status, nvim_lsp = pcall(require, 'lspconfig')
if (not status) then return end
local util = require 'lspconfig/util'
local augroup_format = vim.api.nvim_create_augroup("Format", { clear = true })

local enable_format_on_save = function(_, bufnr)
    vim.api.nvim_clear_autocmds({ group = augroup_format, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup_format,
        buffer = bufnr,
        callback = function()
            vim.lsp.buf.format({ bufnr = bufnr })
            vim.lsp.buf.code_action({
                context = { only = { 'source.organizeImports' } }, apply = true
            })
        end,
    })
end

local on_attach = function(_, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

    local opts = { noremap = true, silent = true }
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)

    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
end

-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- TypeScript Configuration

nvim_lsp.tsserver.setup {
    on_attach = on_attach,
    filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
    cmd = { "typescript-language-server", "--stdio" },
    -- capabilities = capabilities,
}

nvim_lsp.svelte.setup {
    on_attach = on_attach
}

-- Lua Configuration

nvim_lsp.lua_ls.setup {
    -- capabilities = capabilities,
    on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        enable_format_on_save(client, bufnr)
    end,
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

nvim_lsp.gopls.setup {
    cmd = { "gopls", "serve" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_dir = util.root_pattern("go.work", "go.mod", ".git"),
    on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        vim.api.nvim_clear_autocmds({ group = augroup_format, buffer = bufnr })
        vim.api.nvim_create_autocmd('BufWritePre', {
            pattern = "*.go",
            callback = function()
                vim.lsp.buf.code_action({
                    context = { only = { 'source.organizeImports' } },
                    apply = true,
                })
            end
        })
    end,
    settings = {
        gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            buildFlags = { "-tags=large" },
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
        },
    },
    capabilities = capabilities,
}



nvim_lsp.fortls.setup({
    on_attach = on_attach,
    -- capabilities = capabilities,
})
