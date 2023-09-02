return {
	"williamboman/mason.nvim", -- Optional
	dependencies = {
		{ "williamboman/mason-lspconfig.nvim" }, -- Optional
	},
	config = function()
		local mason = require("mason")
        mason.setup()
		local mason_lspconfig = require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"rust_analyzer",
				"taplo",
			},
			automatic_installation = true,
		})
	end,
}
