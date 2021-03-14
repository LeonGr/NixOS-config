{ config, pkgs, ... }:

{
    programs.tmux = {
        enable = true;

        plugins = with pkgs; [
            #tmuxPlugins.sensible
        ];

        shortcut = "space";
        terminal = "rxvt-256color";
        historyLimit = 50000;

        extraConfig = ''
bind-key r source-file ~/.tmux.conf

set -aa terminal-overrides ',rxvt-256color:Ss=:Se='
set -sa terminal-overrides ',*:Tc' # TODO tmux 3.2 truecolor? https://github.com/tmux/tmux/wiki/FAQ#how-do-i-use-rgb-colour

# Smart pane switching with awareness of vim splits
# See: https://github.com/christoomey/vim-tmux-navigator
is_vim='echo "#{pane_current_command}" | grep -iqE "(^|\/)g?(view|n?vim?x?)(diff)?$"'
bind -n "C-h" if-shell "$is_vim" "send-keys C-h" "select-pane -L"
bind -n "C-j" if-shell "$is_vim" "send-keys C-j" "select-pane -D"
bind -n "C-k" if-shell "$is_vim" "send-keys C-k" "select-pane -U"
bind -n "C-l" if-shell "$is_vim" "send-keys C-l" "select-pane -R"
bind -n "C-\\" if-shell "$is_vim" "send-keys C-\\" "select-pane -l"

#separator colours
set -g pane-border-style fg=white
set -g pane-active-border-style fg=default
set -g pane-active-border-style bg=blue

set -g status-left ' '
set -g status-right '#[fg=blue, bold] %b %d %Y #[fg=blue, bold] %R '
set -g status-right-length 100
set -g status-bg default
setw -g window-status-format '#[fg=white, bold] #I #[fg=white, bold] #W '
setw -g window-status-current-format '#[fg=blue, bold] #I #[fg=blue, bold] #W '

set-option -g mouse on
        '';
    };
}
