{ lib, pkgs, ... }:

{
	programs = {
        neovim = {
            initLua = lib.mkOrder 550 ''
					-- maps
					local map = vim.keymap.set
					-- map('n', '<leader>e', ':Ex<CR>') -- disabled by Oil
					map('n', '<C-s>', ':w<CR>')
					map('i', '#', 'X#')
					map('n', '<ESC>', ':nohlsearch<CR>')
			'';
        };
	};
}
