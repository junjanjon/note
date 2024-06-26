#!/bin/bash -xe

SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd $SCRIPT_DIR
cd ..


npx @marp-team/marp-cli@latest --theme src/yutori.css --input-dir src --html --output html
npx @marp-team/marp-cli@latest --theme src/yutori.css --input-dir src --pdf --output pdf

DIST_PATH=../../public/slides
mkdir -p $DIST_PATH
cp -r html $DIST_PATH
cp -r pdf $DIST_PATH

touch slide-links.md
rm slide-links.md

cat << EOS > slide-links.md
# スライド集

※自動生成による内容未精査含みます。

EOS

ls src | grep '.md$' | while read file; do
  FILENAME=${file%.*}
  A_LINK="<a href=\"/note/slides/html/${FILENAME}.html\" target=\"_blank\">${FILENAME}</a><br />"
  echo "${A_LINK}" >> slide-links.md

  cat << EOS >> slide-links.md
<object data="/note/slides/pdf/${FILENAME}.pdf" type="application/pdf" width="960px" height="540px">
    <p>Your browser does not support PDF files.<a href="/note/slides/pdf/${FILENAME}.pdf">Download the file instead</a></p>
</object>
EOS
done
