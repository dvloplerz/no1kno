return {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    build = function()
        require("nvim-treesitter.install").update({ with_sync = true })()
    end,
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        init= function ()
            require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
            load_textobjects = true
        end,
    },
    cmd = { "TSUpdateSync" },
    opts = {
        ensure_installed = { "rust", "lua", "toml", "html", "cssls", },
        auto_install = true,
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
    },
}
