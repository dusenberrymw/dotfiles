#!/usr/bin/env bash
# Create soft links in ~/ to most files in this folder.
shopt -s dotglob extglob
DIR="$(cd "$(dirname "$0")" && pwd)"
SCRIPT=`basename "$0"`
FILES=!(.|..|.git|.gitignore|README.md|$SCRIPT)
echo $FILES
for f in $FILES; do
  pushd ~ > /dev/null  # quiet!
  ln -sfFv $DIR/$f
  popd > /dev/null  # quiet!
done
