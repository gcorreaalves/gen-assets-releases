#!/bin/bash

CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
FILES="assets index.html"
LATEST=""

create_version(){
  echo -e "Version - $1\n"

  echo -e "Creating version directory: $1\n"
  mkdir releases/$1

  echo -e "Checkout to version: $1\n"
  git checkout $1

  #echo -e "Generating the release files\n"
  #grunt/gulp

  echo -e "Copying the files to directory release\n"
  cp -r $FILES releases/$1

  echo -e "__________________________\n"
}

create_latest_version(){
  echo -e "Copying the files to latest directory\n"
  mkdir releases/latest
  cp -r releases/$LATEST/* releases/latest
  echo -e "__________________________\n"
}

echo -e "Creating directories of releases\n"
rm -r releases; mkdir releases

for OUTPUT in $(git tag)
do
  create_version $OUTPUT
  LATEST=$OUTPUT
done

create_latest_version

git checkout $CURRENT_BRANCH
