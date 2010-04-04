#!/bin/bash
yardoc lib/**/*.rb &&
rm -rf ../stacked-doc &&
mkdir -p ../stacked-doc &&
mv doc/* ../stacked-doc &&
git checkout gh-pages &&
rm -rf * &&
mv ../stacked-doc/* . &&
git add . &&
git commit -m "Updated documentation." &&
git push origin gh-pages &&
git checkout master
