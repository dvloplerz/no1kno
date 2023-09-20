return {
    {
        "folke/neoconf.nvim",
        ft = "lua",
        cmd = "Neoconf",
        config = false,
        dependencies = { "nvim-lspconfig" }
    },
    { "folke/neodev.nvim", opts = {} },
    {
        "neovim/nvim-lspconfig", -- Required
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "hrsh7th/nvim-cmp" }, -- Required
        },
        opts = {
            diagnostics = {
                underline = false,
                update_in_insert = true,
                virtual_text = {
                    spacing = 4,
                    source = "if_many",
                    prefix = "●",
                },
                severity_sort = true,
            },
            inlay_hints = {
                enabled = true,
            },
            capabilities = {},
            autoformat = true,
            format_notify = true,
        },
        config = function()
            local lspconfig = require "lspconfig"
            local on_attach = require("nebulax.utils").on_attach
            local cmp_capabilities = require "cmp_nvim_lsp".default_capabilities()

            --local mlsp = require("mason-lspconfig").get_installed_servers()
            --for _, sv in ipairs(mlsp) do
            --    lspconfig[sv].setup({
            --        on_attach = on_attach,
            --        capabilities = cmp_capabilities,
            --        single_file_support = true,
            --    })
            --end

            vim.diagnostic.config({
                virtual_text = {
                    spacing = 2,
                    source = "if_many",
                    prefix = "●",
                    severity = vim.log.levels.Hint,
                },
                underline = {
                    severity = vim.log.Error,
                },
                update_in_insert = true,
                float = {
                    bufnr = vim.api.nvim_get_current_buf(),
                    namespace = "diagnostic",
                    border = "rounded",
                    scope = "cursor",
                    source = "always",
                    severity_sort = true,

                },
            })

            -- ⚡ ⊗
            local sign = { Error = " ⊗", Warn = " ", Hint = "", Info = "󰙎" }
            for type, icon in pairs(sign) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
            end

            require("mason-lspconfig").setup_handlers({
                --local mlsp = require("mason-lspconfig").get_installed_servers()
                --for _, sv in ipairs(mlsp) do
                --    lspconfig[sv].setup({
                --        on_attach = on_attach,
                --        capabilities = cmp_capabilities,
                --        single_file_support = true,
                --    })
                --end
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {}
                end,
                ['cssls'] = function()
                    lspconfig.cssls.setup({
                        cmd = { "/home/dvlp/.bun/bin/vscode-css-language-server", "--stdio" },
                        filetypes = { 'css', 'scss', 'less' },
                        on_attach = on_attach,
                        capabilities = cmp_capabilities,
                    })
                end,
                ['rust_analyzer'] = function()
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
                            cmd = { "rustup", "run", "stable", "rust-analyzer" },
                            on_attach = function(client, bufnr)
                                require "nebulax.utils".on_attach(client, bufnr)
                                vim.keymap.set(
                                    "n",
                                    "K",
                                    require("rust-tools").hover_actions.hover_actions,
                                    { buffer = bufnr }
                                )
                                vim.keymap.set(
                                    "n",
                                    "<leader>ca",
                                    require("rust-tools").code_action_group.code_action_group,
                                    { buffer = bufnr }
                                )
                            end,
                            capabilities = cmp_capabilities,
                            single_file_support = true,
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
                                    cargo = {
                                        allFeatures = true,
                                    },
                                    inlayHints = {
                                        bindingModeHints = { enable = false },
                                        chainingHints = { enable = false },
                                        closingBraceHints = {
                                            enable = true,
                                            minLines = 5,
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
                end,
                ["lua_ls"] = function()
                    require "neodev".setup()
                    --vim.api.nvim_notify("Neodev is loaded.", vim.log.levels.DEBUG, {})
                    lspconfig.lua_ls.setup({
                        filetypes = { "lua" },
                        single_file_support = true,
                        on_attach = on_attach,
                        capabilities = cmp_capabilities,

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
                                    library = { vim.env.VIMRUNTIME },
                                    checkThirdParty = false,
                                }
                            },
                        },
                    })
                    --vim.api.nvim_notify("Lua-Ls is loaded.", vim.log.levels.DEBUG, {})
                end
            })
        end,
    }
}
