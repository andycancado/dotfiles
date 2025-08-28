
# Path to your oh-my-zsh installation. (Not directly applicable to Fish, but keeping the variable for reference)
# set -gx ZSH "/home/anderson/.oh-my-zsh"
set -gx CHROME_EXECUTABLE "/usr/bin/google-chrome-stable"
source ~/.alias

# ZSH_THEME is not directly applicable to Fish, as themes are handled differently.
# Fish themes are usually set via oh-my-fish or by configuring the prompt directly.
# ZSH_THEME="agnoster"

# Uncommented options from .zshrc that are not directly translated to Fish config
# as they are specific to Zsh features or handled differently in Fish.

# Path modifications
set -gx PATH $PATH "$HOME/.pub-cache/bin"
set -gx PATH $PATH "$HOME/fvm/default/bin"
set -gx PATH $PATH "/opt/nvim-linux-x86_64/bin"


# # Starship prompt
# starship init fish | source

# Zoxide
zoxide init fish | source

# ASDF configuration code
if test -z $ASDF_DATA_DIR
    set _asdf_shims "$HOME/.asdf/shims"
else
    set _asdf_shims "$ASDF_DATA_DIR/shims"
end

# Do not use fish_add_path (added in Fish 3.2) because it
# potentially changes the order of items in PATH
if not contains $_asdf_shims $PATH
    set -gx --prepend PATH $_asdf_shims
end
set --erase _asdf_shims

# Go enNVIM_APPNAME=nvim-lazyvim nvimvironment variables
# set -gx GOPATH (asdf where golang)
# set -gx GOROOT (asdf where golang)/go
# set -gx GOBIN (string length --quiet $GOBIN)
# set -gx PATH $PATH "$GOPATH/bin"
# source ~/.env
# # source "$HOME/.sdkman/bin/sdkman-init.sh"
#
# set -gx PATH "$ASDF_DATA_DIR:-$HOME/.asdf}/shims" $PATH
# set -gx PATH "/opt/nvim/bin" $PATH

# fzf (assuming fzf is installed and its fish keybindings are managed separately or via oh-my-fish)
if test -f ~/.fzf.fish
    source ~/.fzf.fish
  end
# Set up fzf key bindings
fzf --fish | source

if test "$TERM_PROGRAM" = "ghostty"
    set -gx TERM xterm-256color
end
set -gx MANPAGER 'nvim --clean +Man!'
#------------------------------------------------------------------------------------- 
# adapted from https://github.com/jonhoo/configs/blob/master/shell/.config/fish/config.fish
abbr -a c cargo
abbr -a v nvim
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


if command -v eza > /dev/null
	abbr -a l 'eza'
	abbr -a ls 'eza'
	abbr -a ll 'eza -l'
	abbr -a lll 'eza -la'
else
	abbr -a l 'ls'
	abbr -a ll 'ls -l'
	abbr -a lll 'ls -la'
end

if test -f /usr/share/autojump/autojump.fish;
	source /usr/share/autojump/autojump.fish;
end


# Fish git prompt
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate ''
set __fish_git_prompt_showupstream 'none'
set -g fish_prompt_pwd_dir_length 3

set -U fish_color_valid_path normal

# colored man output
# from http://linuxtidbits.wordpress.com/2009/03/23/less-colors-for-man-pages/
setenv LESS_TERMCAP_mb \e'[01;31m'       # begin blinking
setenv LESS_TERMCAP_md \e'[01;38;5;74m'  # begin bold
setenv LESS_TERMCAP_me \e'[0m'           # end mode
setenv LESS_TERMCAP_se \e'[0m'           # end standout-mode
setenv LESS_TERMCAP_so \e'[38;5;246m'    # begin standout-mode - info box
setenv LESS_TERMCAP_ue \e'[0m'           # end underline
setenv LESS_TERMCAP_us \e'[04;38;5;146m' # begin underline

setenv FZF_DEFAULT_COMMAND 'fd --type file --follow'
setenv FZF_CTRL_T_COMMAND 'fd --type file --follow'
setenv FZF_DEFAULT_OPTS '--height 20%'


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
	echo -n '| '
	set_color normal
end

function fish_greeting
	echo
	echo -e (uname -ro | awk '{print " \\\\e[1mOS: \\\\e[0;32m"$0"\\\\e[0m"}')
	echo -e (uptime -p | sed 's/^up //' | awk '{print " \\\\e[1mUptime: \\\\e[0;32m"$0"\\\\e[0m"}')
	echo -e (uname -n | awk '{print " \\\\e[1mHostname: \\\\e[0;32m"$0"\\\\e[0m"}')
	echo -e " \\e[1mDisk usage:\\e[0m"
	echo
	echo -ne (\
		df -l -h | grep -E 'dev/(xvda|sd|mapper|nvme)' | \
		awk '{printf "\\\\t%s\\\\t%4s / %4s  %s\\\\n\n", $6, $3, $2, $5}' | \
		sed -e 's/^\(.*\([8][5-9]\|[9][0-9]\)%.*\)$/\\\\e[0;31m\1\\\\e[0m/' -e 's/^\(.*\([7][5-9]\|[8][0-4]\)%.*\)$/\\\\e[0;33m\1\\\\e[0m/' | \
		paste -sd ''\
	)
	echo

	if command -q ip
		echo -e " \\e[1mNetwork:\\e[0m"
		echo
		# http://tdt.rocks/linux_network_interface_naming.html
		echo -ne (\
			ip addr show up scope global | \
				grep -E ': <|inet' | \
				sed \
					-e 's/^[[:digit:]]\+: //' \
					-e 's/: <.*//' \
					-e 's/.*inet[[:digit:]]* //' \
					-e 's/\/.*//'| \
				awk 'BEGIN {i=""} /\.|:/ {print i" "$0"\\\n"; next} // {i = $0}' | \
				sort | \
				column -t -R1 | \
				# public addresses are underlined for visibility \
				sed 's/ \([^ ]\+\)$/ \\\e[4m\1/' | \
				# private addresses are not \
				sed 's/m\(\(10\.\|172\.\(1[6-9]\|2[0-9]\|3[01]\)\|192\.168\.\).*\)/m\\\e[24m\1/' | \
				# unknown interfaces are cyan \
				sed 's/^\( *[^ ]\+\)/\\\e[36m\1/' | \
				# ethernet interfaces are normal \
				sed 's/\(\(en\|em\|eth\)[^ ]* .*\)/\\\e[39m\1/' | \
				# wireless interfaces are purple \
				sed 's/\(wl[^ ]* .*\)/\\\e[35m\1/' | \
				# wwan interfaces are yellow \
				sed 's/\(ww[^ ]* .*\).*/\\\e[33m\1/' | \
				sed 's/$/\\\e[0m/' | \
				sed 's/^/\t/' \
			)
		echo
	end

	set r (random 0 100)
	if [ $r -lt 5 ] # only occasionally show backlog (5%)
		echo -e " \e[1mBacklog\e[0;32m"
		set_color blue
		echo "  [project] <description>"
		echo
	end

	set_color normal
	echo -e " \e[1mTODOs\e[0;32m"
	echo
	if [ $r -lt 10 ]
		# unimportant, so show rarely
		set_color cyan
		# echo "  [project] <description>"
	end
	if [ $r -lt 25 ]
		# back-of-my-mind, so show occasionally
		set_color green
		# echo "  [project] <description>"
	end
	if [ $r -lt 50 ]
		# upcoming, so prompt regularly
		set_color yellow
		# echo "  [project] <description>"
	end

	# urgent, so prompt always
	set_color red
	# echo "  [project] <description>"

	echo

	if test -s ~/todo
		set_color magenta
		cat todo | sed 's/^/ /'
		echo
	end

	set_color normal
end
