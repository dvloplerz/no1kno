return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { 'nvim-telescope/telescope-fzf-native.nvim' },
        },
        opts = {
            pickers = {
                find_files = {
                    theme = "dropdown",
                },
            },
        },
        config = function()
            local nmap = function(lhs, rhs, opts)
                vim.keymap.set('n', lhs, rhs, opts)
            end

            local builtin = require('telescope.builtin')
            nmap('<leader>pf', builtin.find_files, { noremap = false, silent = false })
            nmap('<leader>bl', builtin.buffers, { noremap = false, silent = false })
            nmap('<leader>H', builtin.help_tags, { noremap = false, silent = false })
            nmap('<leader>?', builtin.oldfiles, { noremap = false, silent = false })
            nmap('<leader>qf', builtin.quickfix, { noremap = false, silent = false })
            nmap('<leader>da', builtin.diagnostics, { noremap = false, silent = false })
        end,
    },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = "make",
        config = function()
            require('telescope').setup {
                extensions = {
                    fzf = {
                        fuzzy = true,                   -- false will only do exact matching
                        override_generic_sorter = true, -- override the generic sorter
                        override_file_sorter = true,    -- override the file sorter
                        case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
                    }
                }
            }
            require('telescope').load_extension('fzf')
        end
    },
}
