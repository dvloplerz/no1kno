return {
    "saecki/crates.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    event = {
        "BufRead Cargo.toml",
    },

}
