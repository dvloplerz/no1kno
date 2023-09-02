return {
    "neovim/nvim-lspconfig", -- Required
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        { "hrsh7th/nvim-cmp" }, -- Required
    },
    config = function()
        local lspconfig = require "lspconfig"
        local on_attach = require("nebulax.core.utils").on_attach

        lspconfig.lua_ls.setup({
            on_attach = on_attach,
            settings = {
                Lua = {
                    completion = {
                        enable = true,
                        callSnippet = "Replace",
                    },
                    diagnostics = {
                        globals = { "vim" },
                    },
                    hint = {
                        enable = true,
                    },
                    runtime = {
                        version = "LuaJIT",
                    },
                    semantic = {
                        enable = true,
                        keyword = true,
                    },
                    workspace = {
                        library = { vim.env.VIMRUNTIME }
                    }
                },
            },
        })
    end,
}
