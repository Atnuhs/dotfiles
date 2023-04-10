vim.lsp.set_log_level("debug")

local status, nvim_lsp = pcall(require, 'lspconfig')
if (not status) then return end

local protocol = require('vim.lsp.protocol')
local augroup_format = vim.api.nvim_create_augroup("Format", {clear = true})
local enable_format_on_save = function(_, bufnr)
    vim.api.nvim_clear_autocmds({group = augroup_format, buffer = bufnr})
    vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup_format,
        buffer = bufnr,
        callback = function()
            vim.lsp.buf.format({bufnr = bufnr})
        end,
    })
end

local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

    local opts = {noremmap = true, silent = true}
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- TypeScript Configuration

nvim_lsp.tsserver.setup {
    on_attach = on_attach,
    filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
    cmd = { "typescript-language-server", "--stdio" },
    capabilities = capabilities,
}

-- Lua Configuration

nvim_lsp.lua_ls.setup {
    capabilities = capabilities,
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

nvim_lsp.gopls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
})

nvim_lsp.fortls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
})
