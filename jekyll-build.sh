#!/bin/bash

rm -rf ../copy/
cp -R _site/. ../copy
git checkout master
rm -rf *  
cp -R ../copy/. .
git add --all .
git commit -m "Updated Post"
git push origin master
git checkout source
