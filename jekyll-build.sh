jekyll build &&
git checkout master &&

for i in *; do
  if [[ $i != "_site" ]]; then
    rm -rf $i
  fi
done &&

cp _site/* . -r &&
rm -rf _site &&
touch .nojekyll &&

git add --all . &&
git commit

git checkout source
