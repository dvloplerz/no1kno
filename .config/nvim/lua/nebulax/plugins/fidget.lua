return {
    "j-hui/fidget.nvim",
    lazy = false,
    tag = "legacy",
    event = "LspAttach",
    opts = {
        window = {
            blend = 0,
        },
        text = {
            spinner = "arc",
        },
    },
}
