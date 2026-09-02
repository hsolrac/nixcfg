{ pkgs, inputs, ... }:

{
	programs.nixvim = {
		enable = true;
		package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
		viAlias = true;
		vimAlias = true;
		initLua = builtins.readFile ~/.config/nvim/init.lua;
	};

	home.packages = with pkgs; [
		ripgrep
		fzf
		stdenv.cc
		lazygit
	];
}
