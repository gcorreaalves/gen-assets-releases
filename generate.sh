#!/bin/bash

CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
FILES="assets index.html"

echo -e "Creating directories of releases\n"
rm -r releases; mkdir releases

for OUTPUT in $(git tag)
do
  echo -e "Version - $OUTPUT\n"

  echo -e "Creating version directory: $OUTPUT\n"
  mkdir releases/$OUTPUT

  echo -e "Checkout to version: $OUTPUT\n"
  git checkout $OUTPUT

  echo -e "Copying the files to directory release\n"
  cp -r $FILES releases/$OUTPUT

  echo -e "__________________________\n"
done

git checkout $CURRENT_BRANCH
