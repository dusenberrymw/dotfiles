# ~/.zshrc is sourced in interactive shells.
# use this for interactive uses.

stty -ixon  # disable ctrl-s freezing feature
set -o ignoreeof  # prevent accidental exits with ctrl-d

# Set the command prompt format to display the hostname and current directory.
PS1=$'%m:%1~ \U03bb> '

# Set unlimited history stored in a file and shareable across terminals.  This
# can be used with zsh's reverse lookup feature (`CTRL-r`) to search across the
# history of all terminals.  NOTE: The `upd_hist` can be used to update the
# history in a given terminal from the history file, i.e., from all other
# terminal sessions.
setopt INC_APPEND_HISTORY  # immediately append to history file
setopt HIST_FIND_NO_DUPS  # don't display duplicates
setopt HIST_IGNORE_ALL_DUPS  # remove an older duplicate when writing

export HISTFILE=~/.zsh_history
export HISTSIZE=10000000  # unlimited in-terminal history size
export HISTFILESIZE=${HISTSIZE}  # unlimited history file size
export SAVEHIST=${HISTSIZE}  # unlimited history file size

alias upd_hist="fc -R"  # update terminal history from file

clean-python () {
  find . \( -name "__pycache__" -o -name "*.pyc" -o -name "*.pyo" \) -exec rm -rf {} +
}

clean-ds_store () {
  find . -name ".DS_Store" -exec rm {} +
  find . -name ".localized" -exec rm {} +
}

count-files () {
  dir=${1:-.}
  find "${dir}" -type d -mindepth 1 -maxdepth 1 -print0 | sort -z | xargs -0 -I{} sh -c "echo '{}' && find '{}' -type f -exec echo \; | wc -l"
}

# initialize auto-completion. can run `compinstall` for more options.
autoload -U compinit && compinit
