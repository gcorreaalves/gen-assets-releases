#!/bin/bash

CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
FILES="assets index.html"
LATEST=""

create_version(){
  echo -e "Version - $2\n"

  echo -e "Creating version directory: $2\n"
  mkdir releases/$2

  echo -e "Checkout to version: $2\n"
  git checkout $1

  echo -e "Copying the files to directory release\n"
  cp -r $FILES releases/$2

  echo -e "__________________________\n"
}

echo -e "Creating directories of releases\n"
rm -r releases; mkdir releases

for OUTPUT in $(git tag)
do
  create_version $OUTPUT $OUTPUT
  LATEST=$OUTPUT
done

create_version $LATEST 'latest'

git checkout $CURRENT_BRANCH
