#!/bin/bash
yardoc lib/**/*.rb &&
mkdir -p ../stacked-doc &&
mv doc/* ../stacked-doc &&
git checkout gh-pages &&
mv ../stacked-doc/* . &&
git add . &&
git commit -m "Updated documentation." &&
git push origin gh-pages
