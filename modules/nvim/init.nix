{ lib, pkgs, ... }:

{
	programs = {
        neovim = {
            enable = true;
            defaultEditor = true; # VISUAL=EDITOR=nvim
            extraLuaPackages = luaPkgs: with luaPkgs; [luautf8 ];
            extraPackages = with pkgs; [ # specify deps, ex: LSP
                # lang servers
                lua-language-server # lua
                nil                 # nix lsp
                nixpkgs-fmt         # nix format
            ];
            # extraConfig = ''
	    # ???
            # '';
            initLua = ''
	    vim.cmd(':filetype plugin indent on')

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

	    vim.cmd.colorscheme 'habamax'

	    local map = vim.keymap.set
	    map('n', '<SPACE>e', ':Ex<CR>')
	    map('n', '<C-s>', ':w<CR>')
	    map('i', '#', 'X#')
            '';
            plugins = with pkgs.vimPlugins; [
                # { plugin = foobar;
                #   config = "print('lua, btw')";
                #   type = "lua";
                # }

                # *.type = "lua"  # TODO: find out how to do this

				# core
                nvim-treesitter
				(nvim-treesitter.withPlugins (p: [ p.c p.nix p.lua p.python p.ini p.toml p.json p.rust p.html p.bash p.fish p.zsh p.markdown p.toml p.todotxt p.tmux p.vim ] ))
                nvim-lspconfig

                telescope-nvim
            ];
            viAlias = true;
            vimAlias = true;
            vimdiffAlias = true;
        };
	};
}
