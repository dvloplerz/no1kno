return {
    {
        "rust-lang/rust.vim",
        ft = "rust",
        init = function()
            vim.g.rustfmt_autosave = 1
        end,
    },

    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        { "mfussenegger/nvim-dap" },
        { "neovim/nvim-lspconfig" }, -- Required

    },
}
