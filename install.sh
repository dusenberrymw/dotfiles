#!/usr/bin/env bash
# Create soft links in ~/ to most files in this folder.
shopt -s dotglob extglob
DIR="$(cd "$(dirname "$0")" && pwd)"
SCRIPT=`basename "$0"`
FILES=!(.|..|.git|.gitignore|.gitconfig.template|README.md|$SCRIPT|.bashrc|.bash_profile|.zshrc|.zprofile|.DS_Store|Solarized*)
echo $FILES
for f in $FILES; do
  pushd ~ > /dev/null  # quiet!
  ln -sfFv "${DIR}/${f}"
  popd > /dev/null  # quiet!
done
# these require hard links to avoid issues with full-disk access on macos.
for f in ".bashrc" ".bash_profile" ".zshrc" ".zprofile"; do
  pushd ~ > /dev/null  # quiet!
  ln -fFv "${DIR}/${f}"
  popd > /dev/null  # quiet!
done
