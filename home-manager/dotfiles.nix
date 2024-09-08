{
  pkgs,
  config,
# lib,
  ...
}:
let
  repoRoot = "${config.home.homeDirectory}/dot";
  dotfiles = "../dotfiles";

  alacrittyTheme = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/aarowill/base16-alacritty/c9e824811eed70d7cdb1b31614b81c2f82bf16f8/colors/base16-eighties.toml";
    hash = "sha256-0k8v025i3ij83ww5niv5n05h5x137zhyyiwl6f3hsb2m5srdvr16";
  };
in
{
  xdg.configFile."alacritty/alacritty.toml".source = "${dotfiles}/alacritty/alacritty.toml";
  xdg.configFile."alacritty/base16-eighties.toml".source = alacrittyTheme;

  # nix-prefetch-url https://raw.githubusercontent.com/aarowill/base16-alacritty/c9e824811eed70d7cdb1b31614b81c2f82bf16f8/colors/base16-eighties.toml


  home.file = {
    ".ssh/config".source = ../dotfiles/ssh/config;
    ".zshrc".source = ../dotfiles/zsh/zshrc;
    ".zshenv".source = ../dotfiles/zsh/zshenv;
    ".tmux.conf".source = ../dotfiles/tmux.conf;
    ".screenrc".source = ../dotfiles/screenrc;
    ".gitconfig".source = ../dotfiles/git/gitconfig;
    ".gitignore_global".source = ../dotfiles/git/gitignore_global;

    ".gdbinit".text = ''
      set auto-load safe-path /nix/store
    '';
  };

  # Symlink directly to the nvim directory in our repo vs into a nix
  # derivation in the nix store.
  home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${repoRoot}/dotfiles/nvim";
}
