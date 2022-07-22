local status_ok, hop = pcall(require, "hop")
if not status_ok then
	return
end
hop.setup()

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap



keymap("", "s", ":HopWordCurrentLine<cr>", { silent = true })
-- keymap("", "S", ":HopChar2<cr>", { silent = true })
keymap("", "S", ":HopPattern<cr>", { silent = true })
