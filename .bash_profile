shopt -s globstar

export CUDA_HOME=/usr/local/cuda
export CUDNN_HOME=/usr/local/cudnn
export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:$CUDA_HOME/lib:$CUDNN_HOME/lib
export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:$CUDA_HOME/include:$CUDNN_HOME/include
export PATH=/usr/local/bin:/usr/local/sbin:$CUDA_HOME/bin:/usr/texbin:~/Dropbox/Code/scripts:$PATH
#export PYTHONPATH=/Users/dusenberrymw/Dropbox/Code/caffe/python:$PYTHONPATH
#export PATH=$PATH:~/Dropbox/Code/caffe/build/tools

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

