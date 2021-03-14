{ config, pkgs, ... }:

{
    programs.zsh = {
        enable = true;

        enableCompletion = true;
        enableAutosuggestions = true;

        history = {
            path = "${config.xdg.dataHome}/zsh/zsh_history";
            save = 50000;
            size = 50000;
        };

        sessionVariables = rec {
            EDITOR = "nvim";
        };

        initExtra = ''
            #source /home/leon/dotfiles/zsh/.zshrc
            export ZSH=${pkgs.oh-my-zsh}/share/oh-my-zsh

            ZSH_THEME="alanpeabody"

            plugins=(git zsh zsh-autosuggestions zsh-syntax-highlighting z)
        '';

        plugins = [
            rec {
                name = "zsh-syntax-highlighting";
                src = pkgs.fetchFromGitHub {
                    owner = "zsh-users";
                    repo = name;
                    rev = "0.8.0-alpha1-pre-redrawhook";
                    sha256 = "1gv7cl4kyqyjgyn3i6dx9jr5qsvr7dx1vckwv5xg97h81hg884rn";
                };
            }
        ];
    };
}
