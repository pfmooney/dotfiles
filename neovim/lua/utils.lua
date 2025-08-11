local M = {}
local cmd = vim.cmd


-- u.create_augroup('lua', {
--   { 'FileType', 'lua', 'setlocal', 'ts=2 sw=2 et' },
--   { 'FileType', 'lua', 'setlocal', 'foldmethod=indent' },
-- })
function M.create_augroup(name, autocmds)
  cmd('augroup ' .. name)
  cmd('autocmd!')
  for _, autocmd in ipairs(autocmds) do
    cmd('autocmd ' .. table.concat(autocmd, ' '))
  end
  cmd('augroup END')
end

function M.augroup(name, func)
  local group = vim.api.nvim_create_augroup(name, { clear = true })
  --- @param event any
  --- @param opts vim.api.keyset.create_autocmd
  local function autocmd(event, opts)
    vim.api.nvim_create_autocmd(
      event,
      vim.tbl_extend("force", opts, { group = group })
    )
  end
  func(autocmd)
end

return M
