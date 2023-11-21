local status, none_ls = pcall(require, "none-ls")
if (not status) then return end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})


none_ls.setup {
    sources = {
        none_ls.builtins.formatting.prettierd,
        none_ls.builtins.diagnostics.eslint_d.with({
            diagnostics_format = '[eslint] #{m}\n(#{c})'
        }),
        none_ls.builtins.diagnostics.fish,
        none_ls.builtins.formatting.gofumpt,
        none_ls.builtins.formatting.goimports_reviser,
        none_ls.builtins.formatting.golines,
    },
}
