local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

configs.setup {
  ensure_installed = "all",
  auto_install = true,
  sync_install = false,
  ignore_install = {""},
  highlight = {
    enable = true,
    disable = {"markdown"},
    additional_vim_regex_highlightling = true,
  },
  autopairs = {
    enable = true,
  },
  indent = {enable = true,disable = {""}},
  autotag = {enable = true, disable = {"markdown","xml"}},
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
    colors = {
      "#68a0b0",
      "#946EaD",
      "#c7aA6D",
    },
    disable = {"html"},
  },
  playground = {enable = true,},
}
