return {
	{
		'hrsh7th/nvim-cmp',

		dependencies = {
			{
				'L3MON4D3/LuaSnip',
				build = 'make install_jsregexp',
			},
			'saadparwaiz1/cmp_luasnip',

			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-path',
			'onsails/lspkind.nvim',

			'rafamadriz/friendly-snippets',
		},

		config = function()
			local cmp = require('cmp')
			local luasnip = require('luasnip')
			local lspkind = require('lspkind')
			require('luasnip.loaders.from_vscode').lazy_load()
			luasnip.config.setup({})

			cmp.setup({
				formatting = {
					fields = { 'abbr', 'kind', 'menu' },
					expandable_indicator = true,
					format = lspkind.cmp_format({
						with_text = true,
						maxwidth = 50,
						before = function(entry, vim_item)
							local m = vim_item.menu and vim_item.menu or ""
							if #m > 40 then
								vim_item.menu = string.sub(m, 1, 40) .. "..."
							end
							return vim_item
						end,
					})
				},
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				completion = {
					completeopt = 'menu,menuone,noinsert',
				},
				mapping = cmp.mapping.preset.insert({
					['<C-n>'] = cmp.mapping.select_next_item(),
					['<C-p>'] = cmp.mapping.select_prev_item(),
					['<C-b>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<C-Space>'] = cmp.mapping.complete {},
					['<CR>'] = cmp.mapping.confirm {
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					},
					['<Tab>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { 'i', 's' }),
					['<S-Tab>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { 'i', 's' }),
				}),
				sources = {
					{ name = 'nvim_lsp' },
					{ name = 'luasnip' },
					{ name = 'path' },
				},
			})
		end
	},
}
