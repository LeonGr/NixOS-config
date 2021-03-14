{ config, pkgs, ... }:

{
    programs.zsh = {
        enable = true;

        enableCompletion = true;
        enableAutosuggestions = true;

        shellAliases = {
            phpserver = "php -S localhost:8000";
            pythonserver = "python -m http.server";
            py = "python";
            ":wq" = "exit";
            ":q" = "exit";
            music = "echo 'Song: ' && playerctl metadata 'xesam:title' && echo '\nAlbum: ' && playerctl metadata 'xesam:album' && echo '\nArtist: ' && playerctl metadata 'xesam:albumArtist'";
            exuent = "exit";
            spotify = "spotify --force-device-scale-factor = 1.5";
            status = "sudo systemctl status";
            stop = "sudo systemctl stop";
            start = "sudo systemctl start";
            restart = "sudo systemctl restart";
            sus = "systemctl suspend";
            tmux = "TERM = xterm-256color tmux"; # make cursor work
            mv = "mv -i"; # (--interactive) confirm overwrites

            # ls -> exa
            exa = "exa --git";
            ls = "exa";
            ll = "exa -l";
            la = "exa -la";
            lt = "exa -T";
            lr = "exa -R";
            lat = "exa -laT";
            lar = "exa -laR";
        };

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
            #export ZSH=${pkgs.oh-my-zsh}/share/oh-my-zsh

            #plugins=(git zsh zsh-autosuggestions zsh-syntax-highlighting z)
        '';

        oh-my-zsh = {
            enable = true;
            theme = "alanpeabody";
            plugins = [ "git" "z" ];
        };

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
