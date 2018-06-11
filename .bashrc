shopt -s globstar

# set the command prompt format to display the username, hostname, and current directory
PS1='\u@\h \W\$ '

# set the terminal title
# NOTE: this strips the hostname to just the initial part before any dot, and replaces the home
# portion of the directory path with a tilde
PROMPT_COMMAND='printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'

#export CUDA_HOME=/usr/local/cuda
#export CUDNN_HOME=/usr/local/cudnn
#export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:$CUDA_HOME/lib:$CUDNN_HOME/lib
#export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:$CUDA_HOME/include:$CUDNN_HOME/include
#export PATH=/usr/local/bin:/usr/local/sbin:$CUDA_HOME/bin:/usr/texbin:~/.scripts:$PATH
export PATH=/usr/local/bin:/usr/local/sbin:~/.scripts:$PATH

use-java () {
  export JAVA_HOME=`/usr/libexec/java_home -v 1.$1`
}

#use-java 8

clean-python () {
  find . \( -name "__pycache__" -o -name "*.pyc" -o -name "*.pyo" \) -exec rm -rf {} +
}

clean-ds_store () {
  find . -name ".DS_Store" -exec rm {} +
}

