#!/bin/bash -xe

SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd $SCRIPT_DIR
cd ..


npx @marp-team/marp-cli@latest --input-dir src --html --output html
npx @marp-team/marp-cli@latest --input-dir src --pdf --output pdf

DIST_PATH=../../public/slides
mkdir -p $DIST_PATH
cp -r html $DIST_PATH

touch slide-links.md
rm -rf slide-links.md
ls src | grep '.md$' | while read file; do
  FILENAME=${file%.*}
  A_LINK="<a href=\"/note/slides/html/${FILENAME}.html\" target=\"_blank\">${FILENAME}</a><br />"
  echo "${A_LINK}" >> slide-links.md
done
