local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

vim.api.nvim_create_autocmd("BufRead", {
    group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
    pattern = "Cargo.toml",
    callback = function()
        local cmp = require "cmp"
        cmp.setup.buffer({ sources = { { name = "crates" } } })
    end,
})
--  autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
    callback = function()
        -- Todo!: enable codelens if client supports.
        if true then
            return true
        end
        vim.lsp.codelens.refresh()
        vim.lsp.codelens.get(vim.api.nvim_get_current_buf())
        --vim.api.nvim_notify("Refreshed!", vim.log.levels.INFO, {})
    end
})
vim.api.nvim_create_autocmd({ "BufEnter" }, {
    callback = function()
        vim.g.netrw_bufsettings = "number"
    end
})

return {
    {
        'L3MON4D3/LuaSnip',
        build = (not jit.os:find("Windows")) and
            "echo 'NOTE: jsregexp is optional, so not a big deal if it failed to build'; make install_jsregexp" or nil,
        dependencies = {
            { "hrsh7th/nvim-cmp" }, -- Required
            { 'saadparwaiz1/cmp_luasnip' },
            {
                "rafamadriz/friendly-snippets",
                config = function()
                    require("luasnip.loaders.from_vscode").lazy_load()
                end,
            },
        },
        opts = {
            history = true,
            delete_check_events = "TextChanged",
        },
    },
    {
        "hrsh7th/nvim-cmp", -- Required
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-cmdline' },
            { 'saadparwaiz1/cmp_luasnip' },
            { "hrsh7th/cmp-nvim-lsp-signature-help", },
        },
        event = "InsertEnter",
        config = function()
            -- Set up nvim-cmp.
            local cmp = require 'cmp'
            local luasnip = require "luasnip"
            local types = require "cmp.types"
            vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

            cmp.setup({
                enabled = true,
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body) -- For `luasnip` users.
                    end,
                },
                completion = {
                    completeopt = "menu,menuone,preview,noinsert",
                    keyword_length = 1,
                    autocomplete = { 'InsertEnter', 'TextChanged' },
                },
                confirmation = {
                    default_behavior = types.cmp.ConfirmBehavior.Insert,
                },
                formatting = {
                    --fields = { 'abbr', 'kind', 'menu' },
                    --fields = { "menu", "abbr", "kind" },
                    fields = { "kind", "abbr", "menu" },
                    expandable_indicator = true,
                    format = function(entry, item)
                        local menu_icon = {
                            --  󱠁 󱧜 󰢱 󱃎   󰞷 ␠󰠠 
                            -- nvim_lsp = "λ",
                            -- luasnip = "⋗",
                            -- buffer = " ",
                            -- path = "",
                            -- path = " ",
                            -- nvim_lua = "Π",
                            -- crates = " ",
                            nvim_lsp = "󰞷 ",
                            nvim_lua = " ",
                            luasnip = "󰠠 ",
                            buffer = " ",
                            path = " ",
                            { crates = " " },
                        }
                        local kind_icons = {
                            Text = " ",
                            Method = "󰆧",
                            Function = "󰡱",
                            Constructor = "",
                            Field = "󰇽",
                            Variable = "󰂡",
                            Class = "󰠱",
                            Interface = "",
                            Module = "",
                            Property = "󰜢",
                            Unit = "",
                            Value = "󰎠",
                            Enum = "",
                            Keyword = "󰌋",
                            Snippet = " ",
                            Color = "󰏘",
                            File = "󰈙",
                            Reference = "",
                            Folder = "󰉋",
                            EnumMember = "",
                            Constant = "󰏿",
                            Struct = "",
                            Event = "",
                            Operator = "󰆕",
                            TypeParameter = "󰅲",
                        }
                        item.kind = string.format("%s ", kind_icons[item.kind])
                        item.menu = menu_icon[entry.source.name]
                        return item
                    end,
                },
                preselect = cmp.PreselectMode.None,
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                    winhighlight = "NormalFloat:CursorlineNr,FloatBorder:NormalFloat",
                    max_width = math.floor(20 * (vim.o.columns / 100)),
                    max_height = math.floor(20 * (vim.o.lines / 100)),
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-n>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
                            -- they way you will only jump inside the snippet region
                        elseif luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    ["<C-p>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' }, -- For luasnip users.
                    { name = 'buffer' },
                    { name = 'nvim_lua' },
                    { name = 'nvim_lsp_signature_help' },
                    { name = 'path' },
                    { name = 'crates' },
                }),
                experimental = {
                    ghost_text = {
                        hl_group = "CmpGhostText",
                    },
                },
            })
            cmp.setup.cmdline('/', {
                sources = cmp.config.sources({
                    { name = 'buffer' }
                })
            })
            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                    { name = 'cmdline' }
                })
            })
        end,
    },
    {
        "Jezda1337/nvim-html-css",
        enabled = false,
        ft = { "html", "css", "scss" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require "html-css":setup()
        end
    },
}
