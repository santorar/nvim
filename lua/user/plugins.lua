local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- core
  use { "wbthomason/packer.nvim", commit = "00ec5adef58c5ff9a07f11f45903b9dbbaa1b422" } -- Have packer manage itself
  use { "nvim-lua/plenary.nvim", commit = "968a4b9afec0c633bc369662e78f8c5db0eba249" } -- Useful lua functions used by lots of plugins
  use { "windwp/nvim-autopairs", commit = "fa6876f832ea1b71801c4e481d8feca9a36215ec" } -- Autopairs, integrates with both cmp and treesitter
  use { "numToStr/Comment.nvim", commit = "2c26a00f32b190390b664e56e32fd5347613b9e2" }
  use { "JoosepAlviste/nvim-ts-context-commentstring", commit = "88343753dbe81c227a1c1fd2c8d764afb8d36269" }
  use { "kyazdani42/nvim-web-devicons", commit = "8d2c5337f0a2d0a17de8e751876eeb192b32310e" }
  use { "kyazdani42/nvim-tree.lua", commit = "bdb6d4a25410da35bbf7ce0dbdaa8d60432bc243" }
  use { "akinsho/bufferline.nvim", commit = "c78b3ecf9539a719828bca82fc7ddb9b3ba0c353" }
  use { "moll/vim-bbye", commit = "25ef93ac5a87526111f43e5110675032dbcacf56" }
  use { "nvim-lualine/lualine.nvim", commit = "3362b28f917acc37538b1047f187ff1b5645ecdd" }
  use { "akinsho/toggleterm.nvim", commit = "aaeed9e02167c5e8f00f25156895a6fd95403af8" }
  use { "ahmedkhalf/project.nvim", commit = "541115e762764bc44d7d3bf501b6e367842d3d4f" }
  use { "lewis6991/impatient.nvim", commit = "969f2c5c90457612c09cf2a13fee1adaa986d350" }
  use { "lukas-reineke/indent-blankline.nvim", commit = "6177a59552e35dfb69e1493fd68194e673dc3ee2" }
  use { "goolord/alpha-nvim", commit = "ef27a59e5b4d7b1c2fe1950da3fe5b1c5f3b4c94" }
  -- cmp plugins
  use { "hrsh7th/nvim-cmp", commit = "df6734aa018d6feb4d76ba6bda94b1aeac2b378a" } -- The completion plugin
  use { "hrsh7th/cmp-buffer", commit = "62fc67a2b0205136bc3e312664624ba2ab4a9323" } -- buffer completions
  use { "hrsh7th/cmp-path", commit = "466b6b8270f7ba89abd59f402c73f63c7331ff6e" } -- path completions
  use { "saadparwaiz1/cmp_luasnip", commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36" } -- snippet completions
  use { "hrsh7th/cmp-nvim-lsp", commit = "affe808a5c56b71630f17aa7c38e15c59fd648a8" }
  use { "hrsh7th/cmp-nvim-lua", commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21" }

  -- snippets
  use { "L3MON4D3/LuaSnip", commit = "79b2019c68a2ff5ae4d732d50746c901dd45603a" } --snippet engine
  use { "rafamadriz/friendly-snippets", commit = "d27a83a363e61009278b6598703a763ce9c8e617" } -- a bunch of snippets to use

  -- LSP
  use { "neovim/nvim-lspconfig", commit = "148c99bd09b44cf3605151a06869f6b4d4c24455" } -- enable LSP
  use { "williamboman/nvim-lsp-installer", commit = "e9f13d7acaa60aff91c58b923002228668c8c9e6" } -- simple to use language server installer
  use { "jose-elias-alvarez/null-ls.nvim", commit = "ff40739e5be6581899b43385997e39eecdbf9465" } -- for formatters and linters
  use { "RRethy/vim-illuminate", commit = "c82e6d04f27a41d7fdcad9be0bce5bb59fcb78e5" }
  -- Telescope
  use { "nvim-telescope/telescope.nvim", commit = "d96eaa914aab6cfc4adccb34af421bdd496468b0" }

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    commit = "518e27589c0463af15463c9d675c65e464efc2fe",
  }
  -- Git
  use { "lewis6991/gitsigns.nvim", commit = "c18e016864c92ecf9775abea1baaa161c28082c3" }

  -- DAP
  use { "mfussenegger/nvim-dap", commit = "014ebd53612cfd42ac8c131e6cec7c194572f21d" }
  use { "rcarriga/nvim-dap-ui", commit = "d76d6594374fb54abf2d94d6a320f3fd6e9bb2f7" }
  use { "ravenxrz/DAPInstall.nvim", commit = "8798b4c36d33723e7bba6ed6e2c202f84bb300de" }

  -- custom plugins

  use {"christianchiarulli/hop.nvim",commit="69e987e6c78428ae61e4e648a7f366bbf4fcdd85"}
  use {"NvChad/nvim-colorizer.lua",commit="fbe4a8d12ec1238ab1552361f64c852debd9a33f"}
  use {"MattesGroeger/vim-bookmarks",commit="9cc5fa7ecc23b052bd524d07c85356c64b92aeef"}
  use { "michaelb/sniprun", run = "bash ./install.sh",commit="54a98058b1830b1b4d48b445a47ec26f35c4cd43" }
  -- UI
  use {"stevearc/dressing.nvim",commit="e9d0de44707fe5ce06be6f6959d33a3fab985a3c"}
  use {"ghillb/cybu.nvim",commit="aee926d1bc069194ae32e0e490d52fa3c1ed1bb7"}
  use {"rcarriga/nvim-notify",commit="cd2a59f16d3dc8c54dabc58c31c9c539fcef3c2b"}
  use {"folke/which-key.nvim",commit="bd4411a2ed4dd8bb69c125e339d837028a6eea71"}
  use {"karb94/neoscroll.nvim",commit="54c5c419f6ee2b35557b3a6a7d631724234ba97a"}
  use {"andymass/vim-matchup",commit="976ebfe61b407d0a75d87b4a507bf9ae4ffffbaa"}

  -- Colorschemes
  use { "ellisonleao/gruvbox.nvim",commit="29c50f1327d9d84436e484aac362d2fa6bca590b" }

  -- Treesitter
  use {"p00f/nvim-ts-rainbow",commit="9dd019e84dc3b470dfdb5b05e3bb26158fef8a0c"}
  use {"windwp/nvim-ts-autotag",commit="044a05c4c51051326900a53ba98fddacd15fea22"}

  -- Telescope
  use {"nvim-telescope/telescope-media-files.nvim",commit="513e4ee385edd72bf0b35a217b7e39f84b6fe93c"}

  --Lsp
  use {"simrat39/symbols-outline.nvim",commit="15ae99c27360ab42e931be127d130611375307d5"}
  use {"ray-x/lsp_signature.nvim",commit="ae92d9a61ce70007e52feed4f89e97e851ee3fbf"}
  use {"folke/trouble.nvim",commit="da61737d860ddc12f78e638152834487eabf0ee5"}
  use {"j-hui/fidget.nvim",commit="46d1110435f1f023c22fa95bb10b3906aecd7bde"}
  use {"nvim-lua/lsp_extensions.nvim",commit="92c08d4914d5d272fae13c499aafc9f14eb05ada"}


  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
