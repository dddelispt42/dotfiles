-- luacheck: globals vim
local cursorline_ok, cursorline = pcall(require, 'nvim-cursorline')
if not cursorline_ok then
  return
end

cursorline.setup {
  cursorline = {
    enable = true,
    timeout = 1000,
    number = false,
  },
  cursorword = {
    enable = true,
    min_length = 3,
    hl = { underline = true },
  },
}
