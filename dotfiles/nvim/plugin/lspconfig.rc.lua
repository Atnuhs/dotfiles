local status, nvim_lsp = pcall(require, 'lspconfig')
if (not status) then return end

-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = {only = {"source.organizeImports"}}
    -- buf_request_sync defaults to a 1000ms timeout. Depending on your
    -- machine and codebase, you may want longer. Add an additional
    -- argument after params if you find that you have to write the file
    -- twice for changes to be saved.
    -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
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

nvim_lsp.tsserver.setup {
    filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
    cmd = { "typescript-language-server", "--stdio" },
    -- capabilities = capabilities,
}

nvim_lsp.svelte.setup {
}

-- Lua Configuration

nvim_lsp.lua_ls.setup {
    capabilities = capabilities,
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
    settings = {
        gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            buildFlags = { "-tags=large" },
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
            gofumpt = true,
        },
    },
    capabilities = capabilities,
}



nvim_lsp.fortls.setup({
})
