# local .bashrc file for non-login bash shells
# NOTE: vim 8 terminals will use this file since they launch non-login bash shells

# set the command prompt format to display the username, hostname, and current directory
#PS1='\h:\W \u\$ '
#PS1='\u@\h:\W\$ '
PS1='\u@\h \W\$ '

# set the terminal title
# NOTE: this strips the hostname to just the initial part before any dot, and replaces the home
# portion of the directory path with a tilde
PROMPT_COMMAND='printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'

