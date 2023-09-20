return {
    { "nvim-lua/plenary.nvim",       lazy = true },
    { "nvim-tree/nvim-web-devicons", lazy = true },
    { "MunifTanjim/nui.nvim",        lazy = true },
--    {
--        "SmiteshP/nvim-navic",
--        lazy = true,
--        init = function()
--            vim.g.navic_silence = true
--            require("lazyvim.util").on_attach(function(client, buffer)
--                if client.server_capabilities.documentSymbolProvider then
--                    require("nvim-navic").attach(client, buffer)
--                end
--            end)
--        end,
--        opts = function()
--            return {
--                separator = " ",
--                highlight = true,
--                depth_limit = 5,
--                icons = require("lazyvim.config").icons.kinds,
--            }
--        end,
--    },
    {
        "folke/lazy.nvim",
        version = false,
    },
}
-- 󱩏
-- 󰡱
