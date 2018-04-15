shopt -s globstar

# display the hostname, current directory, and username in the prompt
PS1='\h:\W \u\$ '

#export CUDA_HOME=/usr/local/cuda
#export CUDNN_HOME=/usr/local/cudnn
#export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:$CUDA_HOME/lib:$CUDNN_HOME/lib
#export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:$CUDA_HOME/include:$CUDNN_HOME/include
#export PATH=/usr/local/bin:/usr/local/sbin:$CUDA_HOME/bin:/usr/texbin:~/Dropbox/Code/scripts:$PATH
export PATH=/usr/local/bin:/usr/local/sbin:~/Dropbox/Code/scripts:$PATH

use-java () {
  export JAVA_HOME=`/usr/libexec/java_home -v 1.$1`
}

use-java 8

clean-python () {
  find . | grep -E "(__pycache__|\.pyc|\.pyo$)" | xargs rm -rf
}

clean-ds_store () {
  find . | grep -E "(\.DS_Store)" | xargs rm -rf
}

