return{
  cmd = {"typescript-language-server", "--stdio"},
  root_dir = function() return vim.loop.cwd() end  ,
}
