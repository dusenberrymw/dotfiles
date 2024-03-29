# ~/.bashrc is sourced in non-login shells.
# use this for interactive uses.

# if this is a non-interactive shell, don't do anything else.
[ -z "$PS1" ] && return

stty -ixon  # disable ctrl-s freezing feature
set -o ignoreeof  # prevent accidental exits with ctrl-d

# Set the command prompt format to display the hostname and current directory.
PS1='\h:\W\$ '

# Set the terminal title.
# NOTE: This strips the hostname to just the initial part before any dot, and replaces the home
# portion of the directory path with a tilde.
BASE_PROMPT_COMMAND='printf "\033]0;%s:%s\007" "${HOSTNAME%%.*}" "${PWD/*\//}"'

# Set unlimited history stored in a file and shareable across terminals.  This can be used with
# bash's reverse lookup feature (`CTRL-r`) to search across the history of all terminals.
# NOTE: The `upd_hist` can be used to update the history in a given terminal from the history file,
# i.e., from all other terminal sessions.
export HISTSIZE=  # unlimited in-terminal history size
export HISTFILESIZE=-1  # unlimited history file size
export HISTCONTROL=ignoredups #:erasedups  # ignore duplicate entries
# TODO: this may be leading to overwrites.
# shopt -s histappend  # append to history file on close
export PROMPT_COMMAND="history -a; $BASE_PROMPT_COMMAND"  # append to the history file at each prompt

alias upd_hist="history -a; history -c; history -r"  # append, and update terminal history from file

clean-python () {
  find . \( -name "__pycache__" -o -name "*.pyc" -o -name "*.pyo" \) -exec rm -rf {} +
}

clean-ds_store () {
  find . -name ".DS_Store" -exec rm {} +
}
