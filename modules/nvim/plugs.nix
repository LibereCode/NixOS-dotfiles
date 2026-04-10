{ lib, pkgs, ... }:

{
	programs = {
        neovim = {
            extraPackages = with pkgs; [ # specify deps, ex: LSP
                # lang servers
                lua-language-server # lua
                nil                 # nix lsp
                nixpkgs-fmt         # nix format
            ];
            plugins = with pkgs.vimPlugins; [
                # { plugin = foobar;
                #   config = "print('lua, btw')";
                #   type = "lua";
				#	optional = true; -- convert :plug.add-->:packadd
                # }

                # *.type = "lua"  # TODO: find out how to do this

				# core
                nvim-lspconfig

                nvim-treesitter
				(nvim-treesitter.withPlugins (p: [ p.c p.nix p.lua 
				p.python p.ini p.toml p.json p.rust p.html p.bash p.fish
				p.zsh p.markdown p.toml p.todotxt p.tmux p.vim ] ))

				plenary-nvim

                {	plugin = telescope-nvim;
					config = ''
					local tbi = require('telescope.builtin')
					local leadmap = function(key, cmd, opt, mode)
						mode = mode or 'n'
						opt = opt or {}
						vim.keymap.set(mode, '<LEADER>' .. key, cmd, opt)
					end
					leadmap('f', tbi.find_files)
					leadmap('s', tbi.live_grep)
					leadmap('b', tbi.buffers)
					leadmap('h', tbi.help_tags)
					'';
					type = "lua";
				}
				telescope-fzf-native-nvim

				{	plugin = oil-nvim;
					config = ''
					require('oil').setup()
					vim.keymap.set('n', '<leader>o', ':Oil<CR>');
					'';
					type = "lua";
				}
				{	plugin = undotree;
					optional = true;
				}

				{	plugin = catppuccin-nvim;
					config = ''
						vim.cmd.colorscheme 'catppuccin'
					'';
					type = "lua";
				}
            ];
        };
	};
}
