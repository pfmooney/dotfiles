-- load lazy.nvim plugin manager
vim.opt.rtp:prepend(vim.fn.stdpath('config') .. '/lazy.nvim')

-- Set the leader early, before other plugins are loaded
vim.g.mapleader = ","

require('lazy').setup({
  {
    'pfmooney/vim-pmolokai',
    commit = 'c3a0477fd7ac91bd9a4983ba1f1f472315c05a10',
    config = function()
      -- Set colorscheme once it's loaded
      vim.cmd([[colorscheme pmolokai]])
    end,
  },
  {
    'itchyny/lightline.vim',
    commit = 'b1e91b41f5028d65fa3d31a425ff21591d5d957f',
    config = function()
      -- always show status
      vim.opt.laststatus=2
      -- See statusline for lineinfo documentation
      vim.g.lightline = {
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
    end,
  },

  -- Utilities
  {
    'tpope/vim-fugitive',
    commit = '96c1009fcf8ce60161cc938d149dd5a66d570756',
  },
  {
    'tpope/vim-commentary',
    commit = 'f8238d70f873969fb41bf6a6b07ca63a4c0b82b1',
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    commit = '443b6a8f87ef52ac252b982d9bd1afb8092e3e24',
  },
  {
    'j-hui/fidget.nvim',
    commit = '0ba1e16d07627532b6cae915cc992ecac249fb97',
  },

  -- Telescope (and more)
  {
    'nvim-lua/plenary.nvim',
    commit = '253d34830709d690f013daf2853a9d21ad7accab',
  },
  {
    'nvim-lua/popup.nvim',
    commit = 'b7404d35d5d3548a82149238289fa71f7f6de4ac',
  },
  {
    'nvim-telescope/telescope.nvim',
    commit = '942fe5faef47b21241e970551eba407bc10d9547',
  },
})


local fn = vim.fn -- to call Vim functions e.g. fn.bufnr()
local g = vim.g -- a table to access global variables
local opt = vim.opt -- to set options
local u = require('utils')

vim.o.bg = "dark"

vim.wo.list = true
vim.wo.number = true
vim.o.listchars = "tab:>-"
vim.o.fillchars = "fold: "
-- Show only the menu, not the preview (in a scratch window)
vim.o.completeopt = "menu"

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
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  -- consider using setqflist()?
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)

end

nvim_lsp.rust_analyzer.setup {
  on_attach = on_attach,
  cmd_env = {
    CARGO_TARGET_DIR = "target/ra-check"
  },
  flags = {
    debounce_text_changes = 150,
  },
  handlers = {
    ["textDocument/publishDiagnostics"] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
      }
    ),
  },
  settings = {
    ["rust-analyzer"] = {}
  }
}

require('fidget').setup {}

local function noremap(mode, lhs, rhs)
  vim.api.nvim_set_keymap(mode, lhs, rhs, { noremap = true })
end

local telescope = require('telescope')
telescope.setup {
  defaults = {
    file_sorter = telescope.get_fuzzy_file
  },
  pickers = {
    buffers = {
      mappings = {
        i = {
          ["<c-d>"] = require('telescope.actions').delete_buffer,
        }
      }
    }
  }
}

noremap("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>")
noremap("n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>")
noremap("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>")
noremap("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>")
noremap("n", "<leader>fd", "<cmd>lua require('telescope.builtin').diagnostics()<cr>")
noremap("n", "<leader>fr", "<cmd>lua require('telescope.builtin').git_files()<cr>")
noremap("n", "<leader>ft", "<cmd>lua require('telescope.builtin').tags({ only_sort_tags = true })<cr>")

noremap("n", "<leader>flr", "<cmd>lua require('telescope.builtin').lsp_references()<cr>")
noremap("n", "<leader>fld", "<cmd>lua require('telescope.builtin').diagnostics()<cr>")
noremap("n", "<leader>fls", "<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<cr>")

noremap("n", "<space>", "za");

noremap("n", "tl", ":tabnext<cr>")
noremap("n", "th", ":tabprev<cr>")
noremap("n", "tn", ":tabnew<cr>")
noremap("n", "td", ":tabclose<cr>")


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
