local fn = vim.fn -- to call Vim functions e.g. fn.bufnr()
local g = vim.g -- a table to access global variables
local opt = vim.opt -- to set options
local u = require('utils')

g.mapleader = ","

vim.cmd [[colorscheme pmolokai]]
vim.o.bg = "dark"


vim.wo.list = true
vim.wo.number = true
vim.o.listchars = "tab:>-"

-- always show
opt.laststatus=2
-- See statusline for lineinfo documentation
g.lightline = {
  colorscheme = "one",
  component = {
    lineinfo = "%3l:%-5(%c%V%)"
  },
  mode_map = {
    n = "NORM",
    i = "INS ",
    R = "REP ",
    v = "VIS ",
    V = "V-L ",
    ["<C-v>"] = "V-B ",
    c = "COMM",
    s = "SEL ",
    S = "S-L ",
    ["<C-s>"] = "S-B ",
    t = "TERM",
  }
}

-- Return to same line in file
function file_line_return()
  local prev_line = vim.fn.line("'\"");
  local file_end = vim.fn.line("$");
  if prev_line > 0 and prev_line <= file_end then
    vim.cmd("normal! g`\"zvzz")
  end
end
u.create_augroup('line-return', {
  { 'BufReadPost', '*', 'call v:lua.file_line_return()' },
})


local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- ctags-style definition navigation
  buf_set_keymap('n', '<C-]>', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

end

nvim_lsp.rust_analyzer.setup {
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  handlers = {
     ["textDocument/publishDiagnostics"] = vim.lsp.with(
         vim.lsp.diagnostic.on_publish_diagnostics, {
             virtual_text = false,
         }
     ),
  }
}

local function noremap(mode, lhs, rhs)
  vim.api.nvim_set_keymap(mode, lhs, rhs, { noremap = true })
end

noremap("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>")
noremap("n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>")
noremap("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>")
noremap("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>")
noremap("n", "<leader>fd", "<cmd>lua require('telescope.builtin').lsp_workspace_diagnostics()<cr>")

noremap("n", "<space>", "za");


u.create_augroup('ft-lua', {
  { 'FileType', 'lua', 'setlocal ts=2 sw=2 et' },
  { 'FileType', 'lua', 'setlocal foldmethod=indent' },
})

u.create_augroup('ft-vim', {
  { 'FileType', 'vim', 'setlocal foldmethod=marker' },
  { 'FileType', 'help', 'setlocal textwidth=78' },
  -- Move split to the right side when opening help windows
  { 'BufWinEnter', '*.txt', "if &ft == 'help' | wincmd L | endif" },
})



-- Don't fold comments or '#if 0' blocks
g.c_no_comment_fold = 1
g.c_no_if0_fold = 1

u.create_augroup('ft-c', {
  { 'FileType', 'c', 'setlocal foldmethod=syntax' },
  { 'FileType', 'c', 'setlocal list!' },
  -- shiftround messes with block comments and illumos continuation style
  { 'FileType', 'c', 'setlocal noshiftround' },
  { 'FileType', 'c', 'setlocal ts=8 sw=8 list' },
  { 'FileType', 'c', 'setlocal tw=80' },
})
