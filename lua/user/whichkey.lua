local status_ok,which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local setup = {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = false, -- adds help for motions
      text_objects = false, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  key_labels = {
    ["<leader>"] = "SPC",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
  },
  window = {
    border = "rounded", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 5, -- spacing between columns
    align = "center", -- align columns left, center or right
  },
  ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = false, -- show help message on the command line when the popup is visible
  triggers_blacklist = {
    i = { "j", "k" },
    v = { "j", "k" },
  },
}

local opts = {
  mode = "n",
  prefix = "<Leader>",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = true,
}

local m_opts = {
  mode = "n",
  prefix = "m",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = true,
}
local m_mappings = {
  a = { "<cmd>silent BookmarkAnnotate<cr>", "Annotate" },
  c = { "<cmd>silent BookmarkClear<cr>", "Clear" },
  b = { "<cmd>silent BookmarkToggle<cr>", "Toggle" },
  j = { "<cmd>silent BookmarkNext<cr>", "Next" },
  k = { "<cmd>silent BookmarkPrev<cr>", "Prev" },
  S = { "<cmd>silent BookmarkShowAll<cr>", "Prev" },
  x = { "<cmd>BookmarkClearAll<cr>", "Clear All" },
}
local mappings = {
  q = {
    name = "Quit",
    q = {":Bdelete!<CR>","Close the current buffer"},
    a = {":q!<CR>","Closes neovim"},
  },
  s = {
    name = 'Split',
    v = { ":vs<CR>","Vertical split"},
    h = { ":split<CR>","Horizontal split"},
  },
  f = {
    name = "telescope",
    f = {":Telescope find_files<CR>", "find files"},
    g = {":Telescope live_grep<CR>", "find words"},
    p = {":Telescope projects<CR>", "navigate on your projects"},
    b = {":Telescope buffers<CR>", "find buffers"},
    o = {":Telescope oldfiles<CR>", "display recent opened files"},
    h = {":Telescope help_tags<CR>", "display help guides"},
    k = {":Telescope keymaps<CR>", "display the set of keymaps"},
  },
  b = {
    name = "Buffers",
    t = {":enew<CR>","Open a new buffer"},
    h = {":new<CR>","Open a new buffer horizontally"},
    v = {":vnew<CR>","Open a new buffer vertically"},
  },
  u = {
    name = "Update",
    u = {":PackkerSync<CR>","Packer Sync"},
  },
  e = {
    name = "Edit",
    n = {":e /home/santorar/.config/nvim/init.lua<CR>","Edit nvim config"},
  },
  l = {
    name = "LSP",
    i = {":LspInfo<CR>","Connected Language Servers"},
    I = {":LspInstallInfo<CR>","Installed Language Servers"},
    f = {":lua vim.lsp.buf.formatting()<cr>","Format Code"},
    a = {":lua vim.lsp.buf.code_action()<CR>","Code actions"},
    j = {"<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>","Go to next diagnostic"},
    k = {"<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>","Go to prev diagnostic"},
    r = {":lua vim.lsp.buf.rename()<CR>","Rename"},
    s = {":lua vim.lsp.buf.signature_help()<CR>","Signature help"},
    q = {":lua vim.diagnostic.setloclist()<CR>","Show loclist"},
    D = {":lua vim.lsp.buf.type_definition()<CR>","Type definition"},
  },
  d = {
    name = "DAP",
    b = {"<cmd>lua require'dap'.toggle_breakpoint()<cr>","Toggle a breakpoint"},
    c = {"<cmd>lua require'dap'.continue()<cr>","Continue dap"},
    i = {"<cmd>lua require'dap'.step_into()<cr>","Step into"},
    o = {"<cmd>lua require'dap'.step_over()<cr>","Step over"},
    O = {"<cmd>lua require'dap'.step_out()<cr>","Step out"},
    r = {"<cmd>lua require'dap'.repl.toggle()<cr>","Replay toggle"},
    l = {"<cmd>lua require'dap'.run_last()<cr>","Run last part"},
    u = {"<cmd>lua require'dapui'.toggle()<cr>","Toggle ui"},
    t = {"<cmd>lua require'dap'.terminate()<cr>","Terminate debuging"},
  },
  g = {
    name = "GIT",
    g = {"<cmd>lua _LAZYGIT_TOGGLE()<CR>","Opens luagit"},
  },
  n = {":NvimTreeToggle<CR>","Prev buffer"},
  ["/"] = { '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>', "Comment" },
}
local vopts = {
  mode = "v",
  prefix = "<Leader>",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = true,
}
local vmappings ={
  ["/"] = { '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>', "Comment" },
}
which_key.setup(setup)
which_key.register(mappings,opts)
which_key.register(vmappings,vopts)
which_key.register(m_mappings,m_opts)
