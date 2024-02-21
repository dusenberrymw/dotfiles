# ~/.bash_profile is sourced in login shells.
# use this to set the PATH and anything else that should be available globally.

if [ -d "/opt/homebrew" ]; then
  HOMEBREW_DIR=/opt/homebrew
else
  HOMEBREW_DIR=/usr/local
fi

export PATH="${HOMEBREW_DIR}/opt/ruby/bin:$PATH"
export PATH="${HOMEBREW_DIR}/opt/llvm/bin:$PATH"
export PATH="${HOMEBREW_DIR}/sbin:$PATH"
export PATH="${HOMEBREW_DIR}/bin:$PATH"

export LDFLAGS="-L${HOMEBREW_DIR}/opt/llvm/lib"
export CPPFLAGS="-I${HOMEBREW_DIR}/opt/llvm/include"

# sources ~/.bashrc for interactive login shells
if [[ $- == *i* ]]; then
  if [ -r ~/.bashrc ]; then
    source ~/.bashrc;
  fi
fi
