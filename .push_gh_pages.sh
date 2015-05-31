#!/bin/bash

rm -rf out || exit 0;
mkdir out;

GH_REPO="@github.com/stephlocke/optiRum.git"

FULL_REPO="https://$GH_TOKEN$GH_REPO"

for files in '*.tar.gz'; do
        tar xfz $files
done

cd out
git init
git config user.name "stephs-travis"
git config user.email "travis"

for files in '../tfsR/inst/doc/*.html'; do
        cp $files .
done

git add .
git commit -m "deployed to github pages"
git push --force --quiet $FULL_REPO master:gh-pages