return {
    {
        "rose-pine/neovim",
        lazy = false,
        priority = 1000,
        name = "rose-pine",
        config = function()
            require("rose-pine").setup({
                variant = "main",
                dark_variant = "main",
                disable_background = true,
                disable_float_background = false,
                group = {
                    background = "nc",
                },
                highlight_groups = {
                    CursorlineNr = { bg = "none", fg = "love" },
                    CursorLine = { bg = "love", blend = 10 },
                    TelescopeBorder = { fg = "love", bg = "none" },
                    TelescopeNormal = { bg = "base" },
                    TelescopePromptNormal = { bg = "base" },
                    TelescopeResultsNormal = { fg = "subtle", bg = "base" },
                    TelescopeSelection = { fg = "text", bg = "base" },
                    TelescopeSelectionCaret = { fg = "rose", bg = "base" },
                    SignColumn = { bg = "base", blend = 100 },
                    Pmenu = { bg = "base", blend = 3 },
                    PmenuSel = { fg = "gold", bg = "nc", blend = 0 },
                    --Normal = { bg = "base", blend = 100 },
                    --NormalFloat = { bg = "base", blend = 100 },
                },
            })
            local p = require "rose-pine.palette"
            p.nc = "#0f002e"
            vim.api.nvim_set_hl(0, "Normal", { bg = p.nc, blend = 0 })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = p.nc, blend = 100 })
            vim.cmd.colorscheme("rose-pine")
        end,
    },
}
