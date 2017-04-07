#export CUDA_ROOT=/usr/local/cuda
##export CUDA_ROOT=/Developer/NVIDIA/CUDA-7.5
##export PATH=$CUDA_ROOT/bin:/usr/local/bin:/usr/local/sbin:~/Dropbox/Code/caffe/build/tools:~/Dropbox/Code/Scripts:~/.cabal/bin:/usr/texbin:$PATH
##export DYLD_LIBRARY_PATH=$CUDA_ROOT/lib:$DYLD_LIBRARY_PATH

#export LD_LIBRARY_PATH=$CUDA_ROOT/lib:$CUDA_ROOT/lib64:$LD_LIBRARY_PATH
#export LIBRARY_PATH=$CUDA_ROOT/lib:$CUDA_ROOT/lib64:$LIBRARY_PATH
#export DYLD_FALLBACK_LIBRARY_PATH=$CUDA_ROOT/lib:$CUDA_ROOT/lib64:/usr/local/Cellar/python/2.7.9/Frameworks/Python.framework/Versions/2.7/lib:$DYLD_LIBRARY_PATH

##export DYLD_FALLBACK_LIBRARY_PATH=/usr/local/Cellar/python/2.7.9/Frameworks/Python.framework/Versions/2.7/lib:$DYLD_LIBRARY_PATH

#export PYTHONPATH=/Users/dusenberrymw/Dropbox/Code/caffe/python:$PYTHONPATH

export CUDA_HOME=/usr/local/cuda
export CUDNN_HOME=/usr/local/cudnn
export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:$CUDA_HOME/lib:$CUDNN_HOME/lib
export PATH=/usr/local/bin:/usr/local/sbin:/usr/texbin:$PATH
export PATH=$PATH:~/Dropbox/Code/scripts
#export PATH=$PATH:~/Dropbox/Code/caffe/build/tools
export PATH=$CUDA_HOME/bin:$PATH

use-java () {
  export JAVA_HOME=`/usr/libexec/java_home -v 1.$1`
}

use-java 8

clean-python () {
  find . | grep -E "(__pycache__|\.pyc|\.pyo$)" | xargs rm -rf
}

