local M = {}

M.on_attach = function(client, bufnr)
    vim.lsp.handlers["textDocument/publishDiagnostics"] =
        vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
            virtual_text = true,
            signs = true,
            underline = false,
            update_in_insert = true,
        })

    if client.supports_method("textDocument/inlayHint") then
        vim.lsp.inlay_hint(bufnr, true)
    else
        vim.lsp.inlay_hint(bufnr, false)
    end
end

return M
