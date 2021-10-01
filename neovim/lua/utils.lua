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

return M
