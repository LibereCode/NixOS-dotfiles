{ lib, pkgs, ... }:

{
	programs = {
        neovim = {
            initLua = lib.mkOrder 490 ''
					-- Opts
					vim.cmd(':filetype plugin indent on')

					local g = vim.g
					g.mapleader = ' '
					g.maplocalleader = ','

					local o = vim.opt
					o.shiftwidth = 4
					o.softtabstop = 4
					o.tabstop = 4
					o.number = true
					o.relativenumber = true
					o.smartindent = true
					o.showmatch = true
					o.backspace = 'indent,eol,start'

					o.syntax = "on";

					-- o.exrc = true -- ?
					o.smartcase = true
					o.colorcolumn = '80' -- Highlight char-80
					o.textwidth = 80
					o.completeopt = 'menu,menuone,fuzzy,noinsert'
					o.swapfile = true
					o.confirm = true
					o.linebreak = true -- ?
					o.termguicolors = true
					o.wildoptions:append { 'fuzzy' } -- ?
					o.path:append { '**' } -- ?
					o.smoothscroll = true
					o.grepprg = 'rg --vimgrep --no-messages --smart-case' -- ?
					o.statusline = '[%n] %<%f %h%w%m%r%=%-14.(%l,%c%V%) %P' -- ?
					o.foldlevel = 99
					o.foldmethod = 'expr' -- ?
					o.foldexpr = 'v:lua.vim.treesitter.foldexpr()' -- ?
			'';
        };
	};
}
