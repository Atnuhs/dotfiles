local status, nvim_lsp = pcall(require, 'lspconfig')
if (not status) then return end

require("mason").setup({
    automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

local protocol = require('vim.lsp.protocol')

local on_attach = function(client, bufnr)
    if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = vim.api.nvim_create_augroup("Format", { clear = true }),
            buffer = bufnr,
            callback = function() vim.lsp.buf.formatting_seq_sync() end
        })
    end
end

-- TypeScript Configuration

nvim_lsp.tsserver.setup {
    on_attach = on_attach,
    filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
    cmd = { "typescript-language-server", "--stdio" }
}

-- Lua Configuration

nvim_lsp.lua_ls.setup {
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
    on_attach = on_attach,
}

nvim_lsp.gopls.setup({
})
nvim_lsp.fortls.setup({
})
