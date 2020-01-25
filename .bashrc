# Bash settings
# ---
stty -ixon  # disable ctrl-s freezing feature
set -o ignoreeof  # prevent accidental exits with ctrl-d
shopt -s globstar  # allow searching with wildcards

# Set the command prompt format to display the username, hostname, and current directory.
PS1='\u@\h \W\$ '

# Set the terminal title.
# NOTE: This strips the hostname to just the initial part before any dot, and replaces the home
# portion of the directory path with a tilde.
PROMPT_COMMAND='printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'

# Set unlimited history stored in a file and shareable across terminals.  This can be used with
# bash's reverse lookup feature (`CTRL-r`) to search across the history of all terminals.
# NOTE: The `upd_hist` can be used to update the history in a given terminal from the history file,
# i.e., from all other terminal sessions.
export HISTSIZE=  # unlimited in-terminal history size
export HISTFILESIZE=  # unlimited history file size
export HISTCONTROL=ignoredups:erasedups  # ignore duplicate entries
shopt -s histappend  # append to history file on close
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"  # append to the history file at each prompt
alias upd_hist="history -a; history -c; history -r"  # append, and update terminal history from file

#export CUDA_HOME=/usr/local/cuda
#export CUDNN_HOME=/usr/local/cudnn
#export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:$CUDA_HOME/lib:$CUDNN_HOME/lib
#export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:$CUDA_HOME/include:$CUDNN_HOME/include
#export PATH=/usr/local/bin:/usr/local/sbin:$CUDA_HOME/bin:/usr/texbin:~/.scripts:$PATH
export PATH=/usr/local/bin:/usr/local/sbin:~/.scripts:$PATH

clean-python () {
  find . \( -name "__pycache__" -o -name "*.pyc" -o -name "*.pyo" \) -exec rm -rf {} +
}

clean-ds_store () {
  find . -name ".DS_Store" -exec rm {} +
}

export HOMEBREW_NO_ANALYTICS=1
