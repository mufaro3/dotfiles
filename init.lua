-- preplugin config

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- text/indent config
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2

-- nerd font
vim.g.have_nerd_font = false

-- folding
vim.o.foldmethod = 'indent'
vim.o.foldlevel = 2
vim.o.foldlevelstart = 0
vim.o.foldnestmax = 2

-- plugins

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- TreeSitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = { 'bash', 'c', 'html', 'lua', 'luadoc', 'markdown', 'vim', 'vimdoc' },
      auto_install = true,
      highlight = {
        enable = true,
	      additional_vim_regex_highlighting = { 'ruby' }
      },
      indent = { enable = true, disable = { 'ruby' } }
    }
  },

  -- Melange Theme
  { 'savq/melange-nvim' },

  -- Indent Blankline
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },

  {
    'echasnovski/mini.nvim',
    config = function()
      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }
    end
  }
})

vim.opt.termguicolors = true
vim.cmd.colorscheme 'melange'

