{ pkgs, ... }:

{
    programs.git = {
        enable = true;

        extraConfig = {
            credential = {
                helper = "cache";
            };

            user = {
                email = "leongrasmeijer@gmail.com";
                name = "LeonGr";
            };

            alias = {
                lol = "log --graph --decorate --pretty=oneline --abbrev-commit";
                lola = "log --graph --decorate --pretty=oneline --abbrev-commit --all";
                ls = "ls-files";
            };

            color = {
                branch = "auto";
                diff = "auto";
                interactive = "auto";
                status = "auto";
            };
            merge = {
                tool = "vimdiff";
                conflictstyle = "diff3";
            };
            mergetool = {
                prompt = "false";
                vimdiff = {
                    path = "nvim";
                };
            };
        };
    };
}
