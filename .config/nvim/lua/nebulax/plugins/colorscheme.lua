return {
    {
        "rose-pine/neovim",
        lazy = true,
        priority = 1000,
        name = "rose-pine",
        config = function()
            require("rose-pine").setup({
                variant = "main",
                dark_variant = "main",
                disable_background = false,
                disable_float_background = false,
                group = {
                    background = 'nc',
                },
                highlight_groups = {
                    Normal = { bg = 'nc', blend = 10 },
                    --NormalFloat = { bg = 'nc', blend = 100 },
                    CursorlineNr = { bg = nil, fg = 'love' },
                    CursorLine = { bg = 'love', blend = 14 },
                    TelescopeBorder = { fg = "love", bg = "none" },
                    TelescopeNormal = { bg = "base", blend = 100 },
                    TelescopePromptNormal = { bg = "base" },
                    TelescopeResultsNormal = { fg = "subtle", bg = "base" },
                    TelescopeSelection = { fg = "text", bg = "base" },
                    TelescopeSelectionCaret = { fg = "rose", bg = "base" },

                    Pmenu = { bg = 'base', fg = 'none' },
                    PmenuSel = { bg = "nc", fg = 'love' },
                    CmpItemMenu = { bg = "base", fg = "none" },
                },
            })
            --vim.api.nvim_set_hl(0, "Normal", { bg = '#16141f', blend = 50 })
            --vim.api.nvim_set_hl(0, "NormalFloat", { bg = '#16141f', blend = 50 })
            vim.cmd.colorscheme("rose-pine")
        end,
    },
}
