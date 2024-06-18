-- load lazy.nvim plugin manager
vim.opt.rtp:prepend(vim.fn.stdpath('config') .. '/lazy.nvim')

-- Set the leader early, before other plugins are loaded
vim.g.mapleader = ","

require('lazy').setup({
  {
    'folke/tokyonight.nvim',
    commit = '0fae425aaab04a5f97666bd431b96f2f19c36935',
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
      terminal_colors = false,
      on_colors = function(c)
        c.bg_float = c.transparent
        c.bg_sidebar = c.transparent
      end,
      on_highlights = function(hl, c)
        hl.Folded = {
          bg = c.bg_dark
        }
      end,
    },
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
  {
    'lewis6991/gitsigns.nvim',
    commit = '372d5cb485f2062ac74abc5b33054abac21d8b58',
    opts = {},
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    commit = '443b6a8f87ef52ac252b982d9bd1afb8092e3e24',
  },
  {
    'j-hui/fidget.nvim',
    commit = '90c22e47be057562ee9566bad313ad42d622c1d3',
    opts = {},
  },
  {
    'ray-x/lsp_signature.nvim',
    commit = '33250c84c7a552daf28ac607d9d9e82f88cd0907',
  },

  -- Telescope (and more)
  {
    'nvim-lua/plenary.nvim',
    commit = '9ce85b0f7dcfe5358c0be937ad23e456907d410b',
  },
  {
    'nvim-lua/popup.nvim',
    commit = 'b7404d35d5d3548a82149238289fa71f7f6de4ac',
  },
  {
    'nvim-telescope/telescope.nvim',
    -- v0.1.3
    commit = '54930e1abfc94409e1bb9266e752ef8379008592',
    config = function()
      require('telescope').setup({
        defaults = {
          file_sorter = require('telescope').get_fuzzy_file,
          mappings = {
            i = {
              -- Make ^[ exit insert mode just like <esc>
              ["<c-[>"] = function() vim.cmd [[stopinsert]] end,
            }
          }
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
      })

      local tb = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', tb.find_files, { desc = "Find files" })
      vim.keymap.set('n', '<leader>fg', tb.live_grep, { desc = "Grep files" })
      vim.keymap.set('n', '<leader>fb', tb.buffers, { desc = "Find buffer" })
      vim.keymap.set('n', '<leader>fh', tb.help_tags, { desc = "Find help" })
      vim.keymap.set('n', '<leader>fd', tb.diagnostics, { desc = "Find diagnostics" })
      vim.keymap.set('n', '<leader>fr', tb.git_files, { desc = "Find git files" })
      vim.keymap.set('n', '<leader>ft', function()
        tb.tags({ only_sort_tags = true })
      end, { desc = "Find tags" })

      vim.keymap.set('n', '<leader>flr', tb.lsp_references, { desc = "Find LSP references" })
      vim.keymap.set('n', '<leader>fld', tb.diagnostics, { desc = "Find LSP diagnostics" })
      vim.keymap.set('n', '<leader>fls', tb.lsp_workspace_symbols, { desc = "Find LSP symbols" })

      -- override spellcheck UI
      vim.keymap.set('n', 'z=', function()
        tb.spell_suggest(require("telescope.themes").get_cursor({}))
      end, { desc = "Spelling suggestions" })
    end,
  },

  {
    'folke/which-key.nvim',
    commit = '4b73390eec680b4c061ea175eb32c0ff3412271d',
    opts = {},
  },
})


local u = require('utils')

vim.o.bg = "dark"
vim.cmd([[colorscheme tokyonight-moon]])

vim.wo.list = true
vim.wo.number = true
vim.o.listchars = "tab:>-"
vim.o.fillchars = "fold: "
-- Show only the menu, not the preview (in a scratch window)
vim.o.completeopt = "menu"

-- Return to same line in file
function file_line_return()
  -- Do not bother with line return on git commit messages
  if vim.bo.filetype == "gitcommit" then
    return
  end

  local prev_line = vim.fn.line("'\"");
  local file_end = vim.fn.line("$");
  if prev_line > 0 and prev_line <= file_end then
    vim.cmd("normal! g`\"zvzz")
  end
end
u.create_augroup('line-return', {
  { 'BufReadPost', '*', 'call v:lua.file_line_return()' },
})


-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  --Enable completion triggered by <c-x><c-o>
  vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'

  -- Mappings.
  local function nmap(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  -- ctags-style definition navigation
  nmap('<C-]>', vim.lsp.buf.definition, "Goto definition")

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  nmap('gD', vim.lsp.buf.declaration, "Goto declaration")
  nmap('K', vim.lsp.buf.hover, "Display over info")
  nmap('gi', vim.lsp.buf.implementation, "Goto implementation")
  nmap('<C-k>', vim.lsp.buf.signature_help, "Display signature help")
  nmap('<space>D', vim.lsp.buf.type_definition, "Type definition")
  nmap('<space>rn', vim.lsp.buf.rename, "Rename symbol")
  nmap('<space>ca', vim.lsp.buf.code_action, "Display code actions")
  nmap('gr', vim.lsp.buf.references, "List symbol references")
  nmap('<space>e', vim.diagnostic.open_float, "Diagnostic hover")
  nmap('[d', vim.diagnostic.goto_prev, "Previous diagonistic")
  nmap(']d', vim.diagnostic.goto_next, "Next diagnostic")
  -- consider using setqflist()?
  nmap('<space>q', vim.diagnostic.setloclist, "Load diagnostics list")
  nmap('<space>f', function()
    vim.lsp.buf.format({ async = true })
  end, "Format buffer")

  --
  require('lsp_signature').on_attach({}, bufnr)
end

local nvim_lsp = require('lspconfig')
nvim_lsp.rust_analyzer.setup {
  on_attach = on_attach,
  cmd = {'rustup', 'run', 'stable', 'rust-analyzer'},
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

vim.keymap.set('n', '<space>', 'za');

vim.keymap.set('n', 'tl', ':tabnext<cr>')
vim.keymap.set('n', 'th', ':tabprev<cr>')
vim.keymap.set('n', 'tn', ':tabnew<cr>')
vim.keymap.set('n', 'td', ':tabclose<cr>')


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
vim.g.c_no_comment_fold = 1
vim.g.c_no_if0_fold = 1

u.create_augroup('ft-c', {
  { 'FileType', 'c', 'setlocal foldmethod=syntax' },
  { 'FileType', 'c', 'setlocal list!' },
  -- shiftround messes with block comments and illumos continuation style
  { 'FileType', 'c', 'setlocal noshiftround' },
  { 'FileType', 'c', 'setlocal ts=8 sw=8 list' },
  { 'FileType', 'c', 'setlocal tw=80' },
})

u.create_augroup('ft-rust', {
  -- Module-wide comments (starting with //!) are confusing to the
  -- capitalization checker, so turn it off.
  { 'FileType', 'rust', 'setlocal spellcapcheck=syntax' },
  { 'FileType', 'rust', 'setlocal tw=80' },
})
