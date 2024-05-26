#!/bin/bash -xe

SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd $SCRIPT_DIR
cd ..


ls src | grep '.md$' | while read file; do
  npx @marp-team/marp-cli@latest "src/${file}" --html -o "html/${file%.*}.html"
done

DIST_PATH=../../public/slides
mkdir -p $DIST_PATH
cp -r html $DIST_PATH
