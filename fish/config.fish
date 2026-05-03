set -gx CHROME_EXECUTABLE /usr/bin/google-chrome-stable
source ~/.alias

fish_add_path "$HOME/.pub-cache/bin"
fish_add_path "$HOME/fvm/default/bin"
fish_add_path /opt/nvim-linux-x86_64/bin


# # Starship prompt
# starship init fish | source

# Zoxide
zoxide init fish | source


# fzf key bindings
fzf --fish | source

if test "$TERM_PROGRAM" = ghostty
    set -gx TERM xterm-ghostty
end
set -gx MANPAGER 'nvim --clean +Man!'
#------------------------------------------------------------------------------------- 
# adapted from https://github.com/jonhoo/configs/blob/master/shell/.config/fish/config.fish
abbr -a c cargo
# abbr -a v nvim
abbr -a vv NVIM_APPNAME=nvim_bk_mini nvim
abbr -a vvv NVIM_APPNAME=nvim_mini_2 nvim
abbr -a nvv NVIM_APPNAME=nvim_yt nvim
abbr -a m make
abbr -a o xdg-open
abbr -a g git
abbr -a yz yazi
abbr -a vimdiff 'nvim -d'


# if status --is-interactive
# 	switch $TERM
# 		case 'linux'
# 			:
# 		case '*'
# 			if ! set -q TMUX
# 				exec tmux set-option -g default-shell (which fish) ';' new-session
# 			end
# 	end
# end


if command -v eza >/dev/null
    abbr -a l eza
    abbr -a ls eza
    abbr -a ll 'eza -l'
    abbr -a lll 'eza -la'
else
    abbr -a l ls
    abbr -a ll 'ls -l'
    abbr -a lll 'ls -la'
end

if test -f /usr/share/autojump/autojump.fish
    source /usr/share/autojump/autojump.fish
end


# Fish git prompt
set __fish_git_prompt_showuntrackedfiles yes
set __fish_git_prompt_showdirtystate yes
set __fish_git_prompt_showstashstate ''
set __fish_git_prompt_showupstream none
set -g fish_prompt_pwd_dir_length 3

set -g fish_color_valid_path normal

# colored man output
# from http://linuxtidbits.wordpress.com/2009/03/23/less-colors-for-man-pages/
setenv LESS_TERMCAP_mb \e'[01;31m' # begin blinking
setenv LESS_TERMCAP_md \e'[01;38;5;74m' # begin bold
setenv LESS_TERMCAP_me \e'[0m' # end mode
setenv LESS_TERMCAP_se \e'[0m' # end standout-mode
setenv LESS_TERMCAP_so \e'[38;5;246m' # begin standout-mode - info box
setenv LESS_TERMCAP_ue \e'[0m' # end underline
setenv LESS_TERMCAP_us \e'[04;38;5;146m' # begin underline

setenv FZF_DEFAULT_COMMAND 'fd --type file --follow'
setenv FZF_CTRL_T_COMMAND 'fd --type file --follow'
setenv FZF_DEFAULT_OPTS '--height 20%'


function mkcd
    mkdir -p $argv[1]
    cd $argv[1]
end

function fish_user_key_bindings
    bind \cz 'fg>/dev/null ^/dev/null'
    if functions -q fzf_key_bindings
        fzf_key_bindings
    end
end

function fish_prompt
    set_color brblack
    echo -n "["(date "+%H:%M")"] "
    set_color blue
    echo -n (command -q hostname; and hostname; or hostnamectl hostname)
    if [ $PWD != $HOME ]
        set_color brblack
        echo -n ':'
        set_color yellow
        echo -n (basename $PWD)
    end
    set_color green
    printf '%s ' (__fish_git_prompt)
    set_color red
    echo -n '~> '
    set_color normal
end

function fish_greeting
    echo
    echo -e (uname -ro | awk '{print " \\\\e[1mOS: \\\\e[0;32m"$0"\\\\e[0m"}')
    echo -e (uptime -p | sed 's/^up //' | awk '{print " \\\\e[1mUptime: \\\\e[0;32m"$0"\\\\e[0m"}')
    echo -e (uname -n | awk '{print " \\\\e[1mHostname: \\\\e[0;32m"$0"\\\\e[0m"}')

    if test -s ~/todo
        echo
        set_color magenta
        cat ~/todo | sed 's/^/ /'
        echo
    end

    set_color normal
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
fish_add_path "$BUN_INSTALL/bin"

/home/anderson/.local/bin/mise activate fish | source # added by https://mise.run/fish
fish_add_path /home/anderson/.c3
