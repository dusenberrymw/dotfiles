#!/usr/bin/env bash
# Create soft links in ~/ to most files in this folder.
shopt -s dotglob extglob
DIR="$(cd "$(dirname "$0")" && pwd)"
SCRIPT=`basename "$0"`
FILES=!(.|..|.git|.gitignore|README.md|$SCRIPT|.julia|.vim)
echo $FILES
for f in $FILES; do
  pushd ~ > /dev/null  # quiet!
  ln -sfFv $DIR/$f
  popd > /dev/null  # quiet!
done

# julia config
pushd ~ > /dev/null  # quiet!
rm .julia
mkdir .julia
ln -sfFv $DIR/.julia/config .julia/config
popd > /dev/null  # quiet!

# vim (private swap and undo)
pushd ~ > /dev/null  # quiet!
rm .vim
mkdir .vim
mkdir .vim/swap
mkdir .vim/undo
popd > /dev/null  # quiet!
pushd .vim
DIR="$(cd "$(dirname "$0")" && pwd)"
FILES=!(.|..|.|$SCRIPT|swap|undo)
for f in $FILES; do
  pushd ~/.vim > /dev/null  # quiet!
  ln -sfFv $DIR/$f
  popd > /dev/null  # quiet!
done
