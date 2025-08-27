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
    'nvim-lualine/lualine.nvim',
    commit = 'f4f791f67e70d378a754d02da068231d2352e5bc',
    config = function()
      function fmt_location()
        local line = vim.fn.line('.');
        local cc = vim.fn.charcol('.');
        local vc = vim.fn.virtcol('.');
        if cc == vc then
          return string.format('%3d:%-5d', line, cc)
        else
          return string.format('%3d:%d-%d', line, cc, vc)
        end
      end

      require('lualine').setup {
        theme = 'codedark',
        options = { section_separators = '', component_separators = '|' },
        sections = {
          lualine_b = { 'diagnostics' },
          lualine_x = {
            {
              'fileformat',
              icons_enabled = false,
            },
            'encoding',
            'filetype',
          },
          lualine_z = { fmt_location },
        }
      }
    end,
  },

  -- Utilities
  {
    'tpope/vim-fugitive',
    commit = '4a745ea72fa93bb15dd077109afbb3d1809383f2',
  },
  {
    'tpope/vim-commentary',
    commit = 'f8238d70f873969fb41bf6a6b07ca63a4c0b82b1',
  },
  {
    'lewis6991/gitsigns.nvim',
    commit = '7010000889bfb6c26065e0b0f7f1e6aa9163edd9',
    opts = {},
  },
  {
    'MunifTanjim/nui.nvim',
    commit = '53e907ffe5eedebdca1cd503b00aa8692068ca46',
  },
  {
    "julienvincent/hunk.nvim",
    commit = 'b475ba0011e4b8ef7d7ddecd9764ee1a5f41366d',
    dependencies = {
      'MunifTanjim/nui.nvim',
    },
    cmd = { "DiffEditor" },
    config = function()
      require("hunk").setup()
    end,
  },
  {
    "sindrets/diffview.nvim",
    commit = '4516612fe98ff56ae0415a259ff6361a89419b0a',
  },


  -- LSP
  {
    'neovim/nvim-lspconfig',
    commit = '4ea9083b6d3dff4ddc6da17c51334c3255b7eba5',
  },
  {
    'j-hui/fidget.nvim',
    opts = {
      notification = {
        window = {
          relative = 'win',
        },
      },
    },
  },
  {
    'ray-x/lsp_signature.nvim',
  },

  -- Telescope (and more)
  {
    'nvim-lua/plenary.nvim',
    commit = '857c5ac632080dba10aae49dba902ce3abf91b35',
  },
  {
    'nvim-lua/popup.nvim',
    commit = 'b7404d35d5d3548a82149238289fa71f7f6de4ac',
  },
  {
    'nvim-telescope/telescope.nvim',
    config = function()
      require('telescope').setup({
        defaults = {
          file_sorter = require('telescope').get_fuzzy_file,
          mappings = {
            i = {
              -- Make ^[ exit insert mode just like <esc>
              ["<c-[>"] = function() vim.cmd [[stopinsert]] end,
              ["<c-f>"] = require('telescope.actions').results_scrolling_down,
              ["<c-b>"] = require('telescope.actions').results_scrolling_up,
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
    commit = 'fcbf4eea17cb299c02557d576f0d568878e354a4',
    opts = {},
  },
})


local u = require('utils')

vim.o.bg = "dark"
vim.cmd([[colorscheme tokyonight-moon]])

-- nuke any blinking modes from the cursor
vim.o.guicursor = string.gsub(vim.o.guicursor, ',?[^,]*blink[^,]*', '')

vim.wo.list = true
vim.wo.number = true
vim.o.listchars = "tab:>-,nbsp:␣"
vim.o.fillchars = "fold: "
-- Show only the menu, not the preview (in a scratch window)
vim.o.completeopt = "menu"

-- Highlight trailing spaces
u.augroup('trailing-space', function (aucmd)
  aucmd('BufReadPre', { command = [[match EoLSpace /\s\+$/]] })
  aucmd('InsertEnter', { command = [[highlight clear EoLSpace]] })
  aucmd('InsertLeave', { command = [[highlight EoLSpace ctermbg=131 guibg=#af5f5f]] })
end)

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

-- Force use of the OSC52 clipboard
vim.g.clipboard = {
  name = 'OSC 52',
  copy = {
    ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
    ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
  },
  paste = {
    ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
    ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
  },
}

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
  local function kmap(mode, keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
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

  kmap('n', '<leader>ca', vim.lsp.buf.code_action, 'Display code actions')
  kmap('v', '<leader>ca', vim.lsp.buf.code_action, 'Display code actions')

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
  settings = {
    ["rust-analyzer"] = {}
  }
}

-- Deal with diagnostic cancellations (fixed in 0.11)
if vim.fn.has('nvim-0.11') == 0 then
  for _, method in ipairs({ 'textDocument/diagnostic', 'workspace/diagnostic' }) do
    local default_diagnostic_handler = vim.lsp.handlers[method]
    vim.lsp.handlers[method] = function(err, result, context, config)
      if err ~= nil and err.code == -32802 then
        return
      end
      return default_diagnostic_handler(err, result, context, config)
    end
  end
end


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

vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
  pattern = {'Makefile.*'},
  command = "set filetype=make"
})
