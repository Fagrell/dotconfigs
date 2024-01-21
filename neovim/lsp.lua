-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)

  local function map(l, r, desc)
    vim.keymap.set('n', l, r, { buffer = bufnr, silent = true, desc = desc })
  end

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap=true, silent=true }
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions

  map('<C-k>', vim.lsp.buf.signature_help, 'Signature Help')
  map('K', vim.lsp.buf.hover, 'Hover')

  map('<Leader>ct', vim.lsp.buf.type_definition, 'Type Definition')
  map('<leader>ca', vim.lsp.buf.code_action, 'Code Action')
  map('<leader>cf', vim.lsp.buf.format, 'Format')
  map('<leader>ci', vim.lsp.buf.implementation, 'Implementation')
  map('<leader>cr', vim.lsp.buf.rename, 'Rename')
  map('<leader>cs', '<cmd>lua require("telescope.builtin").lsp_document_symbols({ symbol_width = 60 })<CR>', 'List symbols')

  map('<leader>cwa', vim.lsp.buf.add_workspace_folder, 'Add workspace')
  map('<leader>cwl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', 'List workspaces')
  map('<leader>cwr', vim.lsp.buf.remove_workspace_folder, 'Remove workspace')
  map('<leader>cws', '<cmd>lua require("telescope.builtin").lsp_workspace_symbols({ symbol_width = 60 })<CR>', 'List symbols')

  map('gD', vim.lsp.buf.declaration, 'Go to Declaration')
  map('gd', vim.lsp.buf.definition, 'Go to Definition')
  map('gr', vim.lsp.buf.references, 'References')


  -- vim.cmd([[autocmd BufWritePre * lua vim.lsp.buf.format({ async = true })]])
end

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

require('lspconfig')['clangd'].setup {
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    vim.keymap.set('n', '<leader>s', '<cmd>ClangdSwitchSourceHeader<CR>', { buffer = bufnr, silent = true, desc = 'Switch Header/Source' })
  end,
  capabilities = capabilities,
}

local servers = { 'dartls', 'rust_analyzer' }
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

require('lspconfig')['ltex'].setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "asciidoc", "bib", "gitcommit", "markdown", "org", "plaintex", "rst", "rnoweb", "tex", "pandoc", "quarto", "rmd" },
  settings = {
    ltex = {
      language = 'en-GB',
      checkFrequency = "save",
      disabledRules = { ['en-GB'] = disabledRules },
      dictionary = { ['en-GB'] = words },
    },
  },
}

require('toggle_lsp_diagnostics').init()

