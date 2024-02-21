#!/usr/bin/env bash
# Create soft links in ~/ to most files in this folder.
shopt -s dotglob extglob
DIR="$(cd "$(dirname "$0")" && pwd)"
SCRIPT=`basename "$0"`
FILES=!(.|..|.git|.gitignore|.gitconfig.template|README.md|$SCRIPT|.DS_Store|.bashrc|.bash_profile|Solarized*)
echo $FILES
for f in $FILES; do
  pushd ~ > /dev/null  # quiet!
  ln -sfFv "${DIR}/${f}"
  popd > /dev/null  # quiet!
done
# these require hard links due to some bash issue during ssh shells.
for f in ".bashrc" ".bash_profile"; do
  pushd ~ > /dev/null  # quiet!
  ln -fFv "${DIR}/${f}"
  popd > /dev/null  # quiet!
done
