vim.g.mapleader = " "
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.modifiable = true
vim.opt.clipboard:append("unnamedplus")
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.undofile = true
vim.opt.number = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.foldmethod = "expr"
vim.opt.foldlevelstart = 99
vim.opt.termguicolors = true
vim.opt.updatetime = 300
vim.o.number = true
vim.o.mouse = "a"
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.updatetime = 250
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.cursorline = true
vim.o.relativenumber = true
vim.o.path='**'
vim.g.transparent_enabled = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.cmd.colorscheme 'retrobox'

-- Basic keymaps 
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<C-s>', '<cmd>:w!<CR>')
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window'})
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window'})
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window'})
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window'})
vim.keymap.set('n', '<leader>e', '<cmd>:Oil<CR>', {})
vim.keymap.set('n', '<leader>ff', ':FzfLua files<CR>', {})
vim.keymap.set('n', '<leader>fg', ':FzfLua grep_visual<CR>', {})
vim.keymap.set('n', '<A-j>', '<cmd>m .+1<CR>==', {})
vim.keymap.set('n', '<A-k>', '<cmd>m .-2<CR>==', {})

vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", {})
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", {})

-- Basic Autocommands
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- Plugin manager
local function gh(repo)
	return 'https://github.com/' .. repo
end

vim.pack.add { gh('lewis6991/gitsigns.nvim') }
vim.pack.add { gh('ibhagwan/fzf-lua') }
vim.pack.add { gh 'j-hui/fidget.nvim' }
vim.pack.add { gh('stevearc/oil.nvim')}
vim.pack.add {
	gh 'neovim/nvim-lspconfig',
	gh 'mason-org/mason.nvim',
	gh 'mason-org/mason-lspconfig.nvim',
	gh 'WhoIsSethDaniel/mason-tool-installer.nvim',
}
vim.pack.add {
	gh 'neovim/nvim-lspconfig',
	gh  'hrsh7th/nvim-cmp',
	gh	'williamboman/mason.nvim',
	gh	'williamboman/mason-lspconfig.nvim',
	gh	'WhoIsSethDaniel/mason-tool-installer.nvim',
  gh  'hrsh7th/cmp-buffer',
  gh  'hrsh7th/cmp-path',
  gh  'hrsh7th/cmp-nvim-lsp',
  gh  'hrsh7th/cmp-nvim-lua',
  gh  'ray-x/cmp-treesitter',
  gh  'L3MON4D3/LuaSnip',
  gh  'saadparwaiz1/cmp_luasnip',
}
-- vim.pack.add { gh('') }

require('fidget').setup {}
require('oil').setup({
	columns = {
		"permissions",
		"size",
		"mtime"
	},
	skip_confirm_for_simple_edits = true
})
require('fzf-lua').setup({
	winopts = {
		height = 0.40,
		width = 1.00,
		row = 1.00,
		col = 0.00,
		border = "none",
		fullscreen = false,
	},
	fzf_opts = {
		["--layout"] = "reverse-list",
	},
})

local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  completion = {
    completeopt = "menu,menuone,noselect",
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
    { name = "nvim_lua" },
    { name = "treesitter" },
  }),
})
--  This function gets run when an LSP attaches to a particular buffer.
--    That is to say, every time a new file is opened that is associated with
--    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
--    function will be executed to configure the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end

    map("<leader>co", function()
      vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
    end, "code [o]rganize imports")

    map("K", vim.lsp.buf.hover, "Hover Documentation")

    map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
    map("gr", function() require("fzf-lua").lsp_references() end, "[G]oto [R]eferences")
    map("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
    map("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")

    map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame Symbol")
    map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
    map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    map("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client.server_capabilities.documentHighlightProvider then
      local highlight_augroup =
      vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = function()
          vim.lsp.buf.document_highlight()
          vim.diagnostic.open_float(nil, { scope = "cursor" })
        end,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd("LspDetach", {
        group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
        end,
      })
    end

    if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
      map("<leader>th", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end, "Toggle inlay [h]ints")
    end
  end,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

local servers = {
  -- ruff = {},
  pyright = {},
  -- htmx = {},
  bashls = {},
  rust_analyzer = {},
  -- rubocop = {},
  -- ruby_lsp = {},
  cssls = {},
  elixirls = {},
  biome = { filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" } },
  ts_ls = {
    filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    -- TODO: this is not working yet for typescript
    settings = {
      typescript = {
        inlayHints = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayVariableTypeHintsWhenTypeMatchesName = false,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
    },
  },
  eslint = { filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" } },
  tailwindcss = {},
  html = {},
  -- html = { filetypes = { 'html', 'twig', 'hbs'} },
  lua_ls = {
    settings = {
      Lua = {
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
        hint = { enable = true },
        diagnostics = {
          enable = true,
          globals = {
            "vim",
            "describe",
            "it",
            "before_each",
            "after_each",
            "packer_plugins",
            "MiniTest",
          },
          disable = { "missing-fields", "lowercase-global" },
        },
      },
    },
  },
}

require("mason").setup({
  ui = {
    border = vim.o.winborder,
  },
})

local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
  "stylua", -- Used to format Lua code
})
require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

require("mason-lspconfig").setup({
  handlers = {
    function(server_name)
      local server = servers[server_name] or {}
      -- This handles overriding only values explicitly passed
      -- by the server configuration above. Useful when disabling
      -- certain features of an LSP (for example, turning off formatting for tsserver)
      server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
      require("lspconfig")[server_name].setup(server)
    end,
  },
  automatic_installation = false
})


vim.pack.add { { src = gh 'nvim-treesitter/nvim-treesitter', version = 'main' } }

-- Ensure basic parsers are installed
local parsers = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc', 'ruby', 'rust', 'zig' }
require('nvim-treesitter').install(parsers)

---@param buf integer
---@param language string
local function treesitter_try_attach(buf, language)
	-- Check if a parser exists and load it
	if not vim.treesitter.language.add(language) then return end
	-- Enable syntax highlighting and other treesitter features
	vim.treesitter.start(buf, language)

	-- Enable treesitter based folds
	-- For more info on folds see `:help folds`
	-- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
	-- vim.wo.foldmethod = 'expr'

	-- Check if treesitter indentation is available for this language, and if so enable it
	-- in case there is no indent query, the indentexpr will fallback to the vim's built in one
	local has_indent_query = vim.treesitter.query.get(language, 'indents') ~= nil

	-- Enable treesitter based indentation
	if has_indent_query then vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" end
end

local available_parsers = require('nvim-treesitter').get_available()
vim.api.nvim_create_autocmd('FileType', {
	callback = function(args)
		local buf, filetype = args.buf, args.match

		local language = vim.treesitter.language.get_lang(filetype)
		if not language then return end

		local installed_parsers = require('nvim-treesitter').get_installed 'parsers'

		if vim.tbl_contains(installed_parsers, language) then
			-- Enable the parser if it is already installed
			treesitter_try_attach(buf, language)
		elseif vim.tbl_contains(available_parsers, language) then
			-- If a parser is available in `nvim-treesitter`, auto-install it and enable it after the installation is done
			require('nvim-treesitter').install(language):await(function() treesitter_try_attach(buf, language) end)
		else
			-- Try to enable treesitter features in case the parser exists but is not available from `nvim-treesitter`
			treesitter_try_attach(buf, language)
		end
	end,
})
