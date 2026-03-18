return {
	{
		"olimorris/codecompanion.nvim",

		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},

		config = function()
			require("codecompanion").setup({
				adapters = {
					http = {
						zen = function()
							return require("codecompanion.adapters").extend("openai_compatible", {
								env = {
									url = "https://opencode.ai/zen",
									api_key = "OPENCODE_API_KEY",
									chat_url = "/v1/chat/completions",
								},
							})
						end,

						zen_minimax = function()
							return require("codecompanion.adapters").extend("openai_compatible", {
								env = {
									url = "https://opencode.ai/zen",
									api_key = "OPENCODE_API_KEY",
									chat_url = "/v1/chat/completions",
								},
								schema = {
									model = {
										default = "minimax-m2.5-free",
									},
								},
							})
						end,

						zen_sonnet = function()
							return require("codecompanion.adapters").extend("openai_compatible", {
								env = {
									url = "https://opencode.ai/zen",
									api_key = "OPENCODE_API_KEY",
									chat_url = "/v1/chat/completions",
								},
								schema = {
									model = {
										default = "claude-sonnet-4-6",
									},
								},
							})
						end,

						zen_haiku = function()
							return require("codecompanion.adapters").extend("openai_compatible", {
								env = {
									url = "https://opencode.ai/zen",
									api_key = "OPENCODE_API_KEY",
									chat_url = "/v1/chat/completions",
								},
								schema = {
									model = {
										default = "claude-haiku-4-5",
									},
								},
							})
						end,

						zen_opus = function()
							return require("codecompanion.adapters").extend("openai_compatible", {
								env = {
									url = "https://opencode.ai/zen",
									api_key = "OPENCODE_API_KEY",
									chat_url = "/v1/chat/completions",
								},
								schema = {
									model = {
										default = "claude-opus-4-6",
									},
								},
							})
						end,
					},
				},
				interactions = {
					chat = {
						adapter = "zen_sonnet",
					},
					inline = {
						adapter = "zen_haiku",
					},
				},
			})
		end,
	},
}
