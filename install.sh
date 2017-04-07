#!/usr/bin/env bash
# Create soft links in ~/ to all files in this folder other than
# .git, README.md, and this script.
shopt -s dotglob extglob
DIR="$(cd "$(dirname "$0")" && pwd)"
SCRIPT=`basename "$0"`
FILES=!(.git|README.md|$SCRIPT)
#echo $FILES
for f in $FILES; do
  pushd ~ > /dev/null  # quiet!
  ln -sF $DIR/$f
  echo "Added ~/$f -> $DIR/$f"
  popd > /dev/null  # quiet!
done

