return {

    "simrat39/rust-tools.nvim",
    event = { "BufRead *.rs" },
    ft = { "rust", "rs" },
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        { "mfussenegger/nvim-dap" },
    },
    config = function()
        local on_attach = require("nebulax.core.utils").on_attach
        local rt = require("rust-tools")
        rt.setup({
            tools = {
                inlay_hints = {
                    auto = false,
                },
                hover_actions = {
                    border = "single",
                },
            },
            server = {
                cmd = { "rustup", "run", "nightly", "rust-analyzer" },
                on_attach = function(client, bufnr)
                    require "nebulax.core.utils".on_attach(client, bufnr)
                    vim.keymap.set(
                        "n",
                        "K",
                        require("rust-tools").hover_actions.hover_actions,
                        { buffer = bufnr }
                    )
                    vim.keymap.set(
                        "n",
                        "<leader>h",
                        require("rust-tools").code_action_group.code_action_group,
                        { buffer = bufnr }
                    )
                end,
                single_file_support = true,
                --capabilities = lsp_capabilities,
                settings = {
                    ["rust-analyzer"] = {
                        imports = {
                            granularity = {
                                group = "preserve",
                            },
                            prefix = "self",
                        },
                        diagnostics = {
                            enable = true,
                            experimental = {
                                enable = true,
                            },
                            previewRustcOutput = true,
                        },
                        completion = {
                            callable = {
                                snippets = "fill_arguments",
                            },
                        },
                        check = {
                            invocationLocation = "root",
                        },
                        cargo = {},
                        inlayHints = {
                            bindingModeHints = { enable = false },
                            chainingHints = { enable = false },
                            closingBraceHints = {
                                enable = true,
                                minLines = 25,
                            },
                            closureCaptureHints = { enable = false },
                            closureReturnTypeHints = { enable = "never" },
                            closureStyle = "impl_fn",
                            expressionAdjustmentHints = { enable = "never" },
                            lifetimeElisionHints = {
                                enable = "never",
                                useParameterNames = true,
                            },
                            parameterHints = { enable = true },
                            reborrowHints = { enable = "never" },
                            renderColons = true,
                            typeHints = {
                                enable = true,
                                hideClosureInitialization = false,
                                hideNamedConstructor = false,
                            },
                        },
                        hover = {
                            actions = {
                                references = {
                                    enable = true,
                                },
                                run = {
                                    enable = true,
                                },
                            },
                        },
                        lens = {
                            enable = true,
                            debug = {
                                enable = true,
                            },
                            forceCustomCommands = true,
                            implementations = {
                                enable = true,
                            },
                            location = "above_name",
                            references = {
                                adt = {
                                    enable = true,
                                },
                                enumVariant = {
                                    enable = true,
                                },
                                method = {
                                    enable = true,
                                },
                                trait = {
                                    enable = true,
                                },
                            },
                            run = {
                                enable = true,
                            },
                        },
                        lru = {
                            capacity = 256,
                        },
                        typing = {
                            autoClosingAngleBrackets = { enable = true },
                            continueCommentsOnNewline = false,
                        },
                        worspace = {
                            symbol = {
                                search = { scope = "all_symbols" },
                            },
                        },
                        restartServerOnConfigChange = true,
                        procMacro = {
                            enable = true,
                            attributes = {
                                enable = true,
                            },
                        },
                        rustfmt = {
                            rangeFormatting = {
                                enable = true,
                            },
                        },
                        semanticHighlighting = {
                            doc = {
                                comment = {
                                    inject = {
                                        enable = true,
                                    },
                                },
                            },
                            nonStandardTokens = false,
                            operator = {
                                enable = true,
                                specialization = {
                                    enable = true,
                                },
                            },
                            punctuation = {
                                enable = true,
                                separate = {
                                    macro = {
                                        bang = true,
                                    },
                                },
                                specialization = {
                                    enable = true,
                                },
                            },
                            strings = {
                                enable = true,
                            },
                        },
                        signatureInfo = {
                            detail = "full",
                            documentation = {
                                enable = true,
                            },
                        },
                    },
                },
            },
        })
    end
}
