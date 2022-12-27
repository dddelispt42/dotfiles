-- luacheck: globals vim
local neogit_ok, neogit= pcall(require, "neogit")
if not neogit_ok then
	return
end

neogit.setup({})
